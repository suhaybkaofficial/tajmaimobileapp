part of 'payment_cubit.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

class PaymentError extends PaymentState {
  final String message;
  final int statusCode;

  const PaymentError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class PaymentLoaded extends PaymentState {
  final TransactionResponse transactionResponse;
  const PaymentLoaded(this.transactionResponse);

  @override
  List<Object> get props => [transactionResponse];
}
