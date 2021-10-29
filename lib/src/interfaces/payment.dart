/// Use for Retrieve/Create response via Public Key
abstract class PublicPaymentInterface<R, P> {
  /// Retrieve data [R]
  Future<R> retrieve(int id);

  /// Create data [R] along with [P]
  Future<R> create(P attributes);
}

/// Use for [retrieve],[create],[attach] endpoints via Secret Key
abstract class PaymentIntentInterface<R, P, A, AR>
    extends PublicPaymentInterface<R, P> {
  /// Attach payment
  Future<AR> attach(String id, A attributes);

  /// Retrieve payment intent. Used for re-query to check payment status
  Future<R> retrieveIntentClient(String paymentIntentId, String clientKey);
}

/// Use for [retrieve],[create],[listAll] endpoints via Secret Key
abstract class SecretPaymentInterface<R, P, QP>
    extends PublicPaymentInterface<R, P> {
  /// Pagination of Payments
  Future<R> listAll(P attributes, [QP? queryParams]);
}
