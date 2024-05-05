part of 'checkout_cubit.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

class CheckoutStateInitial extends CheckoutState {
  const CheckoutStateInitial();
}

class CheckoutStateLoading extends CheckoutState {
  const CheckoutStateLoading();
}

class CheckoutStateError extends CheckoutState {
  final String message;
  final int statusCode;
  const CheckoutStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class CheckoutStateLoaded extends CheckoutState {
  const CheckoutStateLoaded(this.checkoutResponseModel);

  final CheckoutResponseModel checkoutResponseModel;

  @override
  List<Object> get props => [checkoutResponseModel];
}
