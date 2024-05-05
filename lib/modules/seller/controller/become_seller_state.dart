part of 'become_seller_cubit.dart';

abstract class BecomeSellerState extends Equatable {
  const BecomeSellerState();

  @override
  List<Object> get props => [];
}

class BecomeSellerInitial extends BecomeSellerState {
  const BecomeSellerInitial();
}

class BecomeSellerLoading extends BecomeSellerState {
  const BecomeSellerLoading();
}

class BecomeSellerLoaded extends BecomeSellerState {
  final String message;

  const BecomeSellerLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class BecomeSellerError extends BecomeSellerState {
  final String message;
  final int statusCode;

  const BecomeSellerError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class BecomeSellerAgreeError extends BecomeSellerState {
  final String message;

  const BecomeSellerAgreeError(this.message);

  @override
  List<Object> get props => [message];
}

class BecomeSellerFormValidate extends BecomeSellerState {
  final Errors error;

  const BecomeSellerFormValidate(this.error);

  @override
  List<Object> get props => [error];
}
