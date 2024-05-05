part of 'add_to_cart_cubit.dart';

abstract class AddToCartState extends Equatable {
  const AddToCartState();

  @override
  List<Object> get props => [];
}

class AddToCartStateInitial extends AddToCartState {
  const AddToCartStateInitial();
}

class AddToCartStateLoading extends AddToCartState {
  const AddToCartStateLoading();
}

class AddToCartStateError extends AddToCartState {
  final String message;
  final int statusCode;
  const AddToCartStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class AddToCartStateAdded extends AddToCartState {
  final String message;
  const AddToCartStateAdded(this.message);

  @override
  List<Object> get props => [message];
}
