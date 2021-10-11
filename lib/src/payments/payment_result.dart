import 'package:equatable/equatable.dart';
import 'package:paymongo_sdk/src/models/intent/intent.dart';

enum PaymentMethodStatus {
  awaitingPaymentMethod,
  processing,
  succeeded,
  awaitingNextAction,
}
typedef PayMongoIntentAuthentication = void Function(String url);

class PaymentResult extends Equatable {
  final String id;
  final PaymentMethodStatus status;
  final String clientKey;
  final String paymentMethod;
  final String? errors;
  final String? authenticateUrl;
  final PaymentIntentNextAction? nextAction;
  const PaymentResult({
    required this.id,
    required this.status,
    required this.clientKey,
    required this.paymentMethod,
    this.errors,
    this.authenticateUrl,
    this.nextAction,
  });

  PaymentResult copyWith({
    String? id,
    PaymentMethodStatus? status,
    String? clientKey,
    String? paymentMethod,
    String? errors,
    String? authenticateUrl,
    PaymentIntentNextAction? nextActions,
  }) {
    return PaymentResult(
      id: id ?? this.id,
      status: status ?? this.status,
      clientKey: clientKey ?? this.clientKey,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      errors: errors ?? this.errors,
      authenticateUrl: authenticateUrl ?? this.authenticateUrl,
      nextAction: nextActions ?? nextAction,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      status,
      clientKey,
      paymentMethod,
      errors,
      authenticateUrl,
      nextAction,
    ];
  }
}
