import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'shoes.dart';

const payMongoKey = String.fromEnvironment('apiKey', defaultValue: '');
const secretKey = String.fromEnvironment('secretKey', defaultValue: '');
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: MyApp()));
}

/// Your PayMaya Example App.
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with PaymongoEventHandler {
  final List<Shoe> _shoes = List.generate(5, (index) {
    return Shoe(
      amount: 100 * index,
      currency: 'PHP',
      name: 'Shoe #$index',
      description: 'A smol shoe size of S-$index',
    );
  });

  @override
  void initState() {
    super.initState();
  }

  final List<Shoe> _cart = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Paymaya Shoepping app'),
        ),
        body: GridView.builder(
          itemCount: _shoes.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250),
          itemBuilder: (context, index) {
            final shoe = _shoes[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (!_cart.contains(shoe)) {
                    _cart.add(shoe);
                  }
                });
              },
              child: _ShoeCard(shoe: shoe),
            );
          },
        ),
        floatingActionButton: Row(
          children: [
            FloatingActionButton.extended(
              onPressed: () async {
                await _handleCredit(_cart);
              },
              label: Text('Single Payment(${_cart.length})'),
              icon: const Icon(Icons.credit_card),
            ),
          ],
        ));
  }
}

class _ShoeCard extends StatelessWidget {
  const _ShoeCard({
    Key? key,
    required this.shoe,
  }) : super(key: key);

  final Shoe shoe;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            color: Colors.red[100],
            height: 100,
          ),
          ListTile(
            title: Text(shoe.name),
            subtitle: Text(shoe.description),
            trailing: Text(
              '${shoe.currency} ${shoe.amount.toStringAsFixed(2)}',
            ),
          )
        ],
      ),
    );
  }
}

// ignore: public_member_api_docs
class CheckoutPage extends StatefulWidget {
  // ignore: public_member_api_docs
  const CheckoutPage({required this.url, required this.returnUrl});
  // ignore: public_member_api_docs
  final String url;
  final String returnUrl;

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final Completer<WebViewController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, false);
        return false;
      },
      child: Scaffold(
          body: SafeArea(
        child: WebView(
          onWebViewCreated: _controller.complete,
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          debuggingEnabled: kDebugMode,
          navigationDelegate: (request) async {
            if (request.url == widget.returnUrl) {
              Navigator.pop(context, widget.returnUrl);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onWebResourceError: (error) async {
            final dialog = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Something went wrong'),
                  content: Text('$error'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('close'),
                    )
                  ],
                );
              },
            );
            if (dialog) {
              Navigator.pop(context, false);
            }
          },
        ),
      )),
    );
  }
}

mixin PaymongoEventHandler<T extends StatefulWidget> on State<T> {
  final sdk = PayMongoSDK(payMongoKey);
  final secret = PayMongoSDK(secretKey);

  Future<void> _handleCredit(List<Shoe> _cart) async {
    try {
      final _amount = _cart.fold<num>(
          0, (previousValue, element) => previousValue + element.amount);
      final createdPaymentMethod = await sdk.createPaymentMethod(
          data: PaymentMethodAttributes(
        billing: PayMongoBilling(
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
        ),
        details: PaymentMethodDetails(
          cardNumber: '4120000000000007',
          expMonth: 2,
          expYear: 27,
          cvc: "123",
        ),
      ));

      final intent = await secret.createPaymentIntent(
        PaymentIntentAttributes(
            amount: _amount.toDouble(),
            description: "Test payment",
            statementDescriptor: "Test payment descriptor",
            metadata: {
              "environment": kReleaseMode ? "LIVE" : "DEV",
            }),
      );
      if (intent.attributes.status == 'awaiting_payment_method' &&
          (intent.attributes.lastPaymentError?.isNotEmpty ?? false)) {
        debugPrint('${intent.attributes.lastPaymentError}');
        return;
      }
      final result = await sdk.onPaymentListener(
        intent: intent,
        paymentMethod: createdPaymentMethod.id,
      );
      final redirect = result?.nextAction?.redirect;
      if (redirect?.url != null) {
        debugPrint("${redirect?.url}");
        final res = await Navigator.push(context,
            CupertinoPageRoute(builder: (context) {
          return CheckoutPage(
            returnUrl: redirect?.returnUrl ?? '',
            url: redirect?.url ?? '',
          );
        }));
        if (res != null) {
          debugPrint("$res");
        }
      }
      debugPrint("$intent");
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> _handleGcash(List<Shoe> _cart) async {
    final _amount = _cart.fold<num>(
        0, (previousValue, element) => previousValue + element.amount);
    final url = 'google.com';
    final _source = Source(
      type: "gcash",
      amount: _amount.toDouble(),
      currency: 'PHP',
      redirect: Redirect(
        success: "https://$url/success",
        failed: "https://$url/failed",
      ),
      billing: PayMongoBilling(
        address: PayMongoAddress(
          city: "Cotabato City",
          country: "PH",
          state: "Mindanao",
          line1: "Secret Address",
        ),
        name: "Anonymous",
        email: "test@gmail.com",
        phone: "09123456002",
      ),
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
