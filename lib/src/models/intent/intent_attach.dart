import 'dart:convert';

///{@template payment_intent_attach}
///{@endtemplate}
class PaymentIntentAttach {
  /// Converts [Map<String,dynamic>] to [PaymentIntentAttach] class
  /// {@macro payment_intent_attach}
  factory PaymentIntentAttach.fromMap(Map<String, dynamic> map) {
    return PaymentIntentAttach(
      paymentMethod: map['payment_method'] ?? '',
      clientKey: map['client_key'] ?? '',
      returnUrl: map['return_url'] ?? '',
    );
  }

  /// Converts [String] of json to [PaymentIntentAttach] class
  /// {@macro payment_intent_attach}
  factory PaymentIntentAttach.fromJson(String source) =>
      PaymentIntentAttach.fromMap(json.decode(source));

  /// {@macro payment_intent_attach}
  const PaymentIntentAttach({
    required this.paymentMethod,
    this.clientKey,
    this.returnUrl,
  });

  ///
  final String paymentMethod;

  ///
  final String? clientKey;

  ///
  final String? returnUrl;

  /// {@macro payment_intent_attach}
  PaymentIntentAttach copyWith({
    String? paymentMethod,
    String? clientKey,
    String? returnUrl,
  }) {
    return PaymentIntentAttach(
      paymentMethod: paymentMethod ?? this.paymentMethod,
      clientKey: clientKey ?? this.clientKey,
      returnUrl: returnUrl ?? this.returnUrl,
    );
  }

  /// Converts [PaymentIntentAttach] to [Map<String,dynamic>]
  ///
  /// {@macro payment_intent_attach}
  Map<String, dynamic> toMap() {
    return {
      'payment_method': paymentMethod,
      'client_key': clientKey,
      'return_url': returnUrl,
    };
  }

  /// Converts [Map<String,dynamic>] to [String] json
  String toJson() => json.encode(toMap());

  @override
  String toString() => '''
      PaymentIntentAttach(paymentMethod: $paymentMethod, 
      clientKey: $clientKey, 
      returnUrl: $returnUrl
      )
      ''';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentIntentAttach &&
        other.paymentMethod == paymentMethod &&
        other.clientKey == clientKey &&
        other.returnUrl == returnUrl;
  }

  @override
  int get hashCode =>
      paymentMethod.hashCode ^ clientKey.hashCode ^ returnUrl.hashCode;
}
