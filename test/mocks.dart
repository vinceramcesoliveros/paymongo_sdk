import 'package:mocktail/mocktail.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

class MockPaymongo extends Mock implements Paymongo {}

class FakeSource extends Fake implements Source {}

class FakePaymentMethod extends Fake implements PaymentMethod {}

class MockPaymongoPublic extends Fake implements PaymongoPublic {
  @override
  Source get source => FakeSource();

  @override
  PaymentMethod<PaymentGateway> get paymentMethod => FakePaymentMethod();
}

class MockPaymongoSecret extends Fake implements PaymongoSecret {}
