/// API request for webhooks via http methods
abstract class WebhookInterface<T> {
  /// allows user to create a webhook using secret key
  Stream<T> create();

  /// allows user to retrieve a webhook using public key
  Stream<T> retrieve(String id);

  /// allows user to disable a webhook using secret key
  Future<T> disable(String id);

  /// allows user to enable a webhook using secret key
  Future<T> enable(String id);

  /// allows user to fetch all webhook using pubic key
  Stream<List<T>> listAll();
}
