import 'dart:convert';

class PaymentIntentAttach {
  final String paymentMethod;
  final String? clientKey;
  final String? returnUrl;
  PaymentIntentAttach({
    required this.paymentMethod,
    this.clientKey,
    this.returnUrl,
  });

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

  Map<String, dynamic> toMap() {
    return {
      'payment_method': paymentMethod,
      'client_key': clientKey,
      'return_url': returnUrl,
    };
  }

  factory PaymentIntentAttach.fromMap(Map<String, dynamic> map) {
    return PaymentIntentAttach(
      paymentMethod: map['payment_method'] ?? '',
      clientKey: map['client_key'] ?? '',
      returnUrl: map['return_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentIntentAttach.fromJson(String source) =>
      PaymentIntentAttach.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaymentIntentAttach(paymentMethod: $paymentMethod, clientKey: $clientKey, returnUrl: $returnUrl)';

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
