part of 'cash_on_payment_cubit.dart';

abstract class CashPaymentState extends Equatable {
  const CashPaymentState();

  @override
  List<Object> get props => [];
}

class CashPaymentStateInitial extends CashPaymentState {
  const CashPaymentStateInitial();
}

class CashPaymentStateLoading extends CashPaymentState {
  const CashPaymentStateLoading();
}

class CashPaymentStateError extends CashPaymentState {
  final String message;
  final int statusCode;
  const CashPaymentStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class CashPaymentStateLoaded extends CashPaymentState {
  final String message;
  const CashPaymentStateLoaded(this.message);

  @override
  List<Object> get props => [message];
}
