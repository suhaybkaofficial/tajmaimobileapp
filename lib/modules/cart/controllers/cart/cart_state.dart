part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartStateInitial extends CartState {
  const CartStateInitial();
}

class CartStateLoading extends CartState {
  const CartStateLoading();
}

class CartStateDecIncrementLoading extends CartState {
  const CartStateDecIncrementLoading();
}

class CartStateError extends CartState {
  final String message;
  final int statusCode;

  const CartStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class CartStateDecIncError extends CartState {
  final String message;
  final int statusCode;

  const CartStateDecIncError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class CartDecIncState extends CartState {
  final String message;

  const CartDecIncState(this.message);

  @override
  List<Object> get props => [message];
}

class CartStateLoaded extends CartState {
  final CartResponseModel cartResponseModel;

  const CartStateLoaded(this.cartResponseModel);

  @override
  List<Object> get props => [cartResponseModel];
}

class CartStateRemove extends CartState {
  final String message;

  const CartStateRemove(this.message);

  @override
  List<Object> get props => [message];
}

class CartCouponStateLoaded extends CartState {
  final CouponResponseModel couponResponseModel;

  const CartCouponStateLoaded(this.couponResponseModel);

  @override
  List<Object> get props => [couponResponseModel];
}
