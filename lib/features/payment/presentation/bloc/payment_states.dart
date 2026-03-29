
abstract class PaymentState {}

class PaymentInitial    extends PaymentState {}
class PaymentLoading    extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final String transactionId;
  final String message;
  PaymentSuccess({required this.transactionId, required this.message});
}

class PaymentFailure extends PaymentState {
  final String message;
  PaymentFailure(this.message);
}