import 'package:paymongo_sdk/paymongo_sdk.dart';

/// A relationship of [PaymongoPublic] and [PaymongoSecret]
abstract class Paymongo {}

///{@template paymongo_public_client}
///{@endtemplate}
class PaymongoPublic extends Paymongo {
  ///{@macro paymongo_public_client}
  factory PaymongoPublic() => _singleton;
  PaymongoPublic._internal();
  static final PaymongoPublic _singleton = PaymongoPublic._internal();

  ///
  late String key;

  ///
  late String url;

  /// Use for creating gcash payment.
  ///
  /// Sources will be deprecated when gcash migrates to intent api
  Source get source => Source(key, url);

  /// Use for storing payment intent
  PaymentMethod get paymentMethod => PaymentMethod(key, url);
}

///{@template paymongo_secret_client}
///{@endtemplate}
class PaymongoSecret extends Paymongo {
  /// {@macro paymongo_secret_client}
  factory PaymongoSecret() => _singleton;
  PaymongoSecret._internal();
  static final PaymongoSecret _singleton = PaymongoSecret._internal();

  ///
  late String key;

  ///
  late String url;

  /// After [Source] response, use `payment.create` method
  Payment get payment => Payment(key, url);

  /// After [PaymentMethod] response, create and attach to get the url.
  PaymentIntent get paymentIntent => PaymentIntent(key, url);
}
