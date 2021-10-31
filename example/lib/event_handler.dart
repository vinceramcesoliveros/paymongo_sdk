import 'package:example/shoes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

import 'checkout.dart';

const payMongoKey = String.fromEnvironment('apiKey',
    defaultValue: 'pk_test_Dpe7cKewo7JpHyF2iBra5Sjm');
const secretKey = String.fromEnvironment('secretKey',
    defaultValue: 'sk_test_8Fk9xMNRXDChC4b1XBsHpUEm');
mixin PaymongoEventHandler<T extends StatefulWidget> on State<T> {
  final sdk = PayMongoSDK(payMongoKey);
  final secret = PayMongoSDK(secretKey);
  final publicClient = PaymongoClient<PaymongoPublic>(payMongoKey);
  final secretClient = PaymongoClient<PaymongoSecret>(secretKey);
  final billing = PayMongoBilling(
    name: 'Vince',
    email: "vince@gmail.com",
    phone: "09555841041",
    address: PayMongoAddress(
      line1: "test address",
      line2: "test 2 address",
      city: "Cotabato City",
      state: "Maguindanao",
      postalCode: "9600",
      country: "PH",
    ),
  );
  Future<void> cardPayment(List<Shoe> _cart) async {
    try {
      final _amount = _cart.fold<num>(
          0, (previousValue, element) => previousValue + element.amount);
      final payment = await publicClient.instance.paymentMethod
          .create(PaymentMethodAttributes(
        billing: billing,
        details: PaymentMethodDetails(
          cardNumber: '4120000000000007',
          expMonth: 2,
          expYear: 27,
          cvc: "123",
        ),
      ));
      final intent = PaymentIntentAttributes(
          amount: _amount.toDouble(),
          description: "Test payment",
          statementDescriptor: "Test payment descriptor",
          metadata: {
            "environment": kReleaseMode ? "LIVE" : "DEV",
          });
      final result =
          await secretClient.instance.paymentIntent.onPaymentListener(
              attributes: intent,
              paymentMethod: payment.id,
              onRedirect: (url) async {
                debugPrint("${url}");
                final res = await Navigator.push<bool>(context,
                    CupertinoPageRoute(builder: (context) {
                  return CheckoutPage(
                    url: url,
                  );
                }));
                return res ?? false;
              });
      debugPrint("${result?.status}");
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> gcashPayment(List<Shoe> _cart) async {
    final _amount = _cart.fold<num>(
        0, (previousValue, element) => previousValue + element.amount);
    final url = 'google.com';
    final _source = SourceAttributes(
      type: "gcash",
      amount: _amount.toDouble(),
      currency: 'PHP',
      redirect: Redirect(
        success: "https://$url/success",
        failed: "https://$url/failed",
      ),
      billing: billing,
    );
    final result = await sdk.createSource(_source);
    final paymentUrl = result.attributes?.redirect.checkoutUrl ?? '';
    final successLink = result.attributes?.redirect.success ?? '';
    if (paymentUrl.isNotEmpty) {
      final response = await Navigator.push<String>(
        context,
        CupertinoPageRoute(
          builder: (context) => CheckoutPage(
            url: paymentUrl,
            returnUrl: successLink,
          ),
        ),
      );

      debugPrint("==============================");
      debugPrint("||$response||");
      debugPrint("==============================");
    }
  }
}
