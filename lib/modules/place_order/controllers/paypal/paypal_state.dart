part of 'paypal_cubit.dart';

abstract class PaypalState extends Equatable {
  const PaypalState();

  @override
  List<Object> get props => [];
}

class PaypalStateInitial extends PaypalState {
  const PaypalStateInitial();
}

class PaypalStateLoading extends PaypalState {
  const PaypalStateLoading();
}

class PaypalStateError extends PaypalState {
  final String message;
  final int statusCode;
  const PaypalStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class PaypalStateLoaded extends PaypalState {
  final String message;
  const PaypalStateLoaded(this.message);

  @override
  List<Object> get props => [message];
}
