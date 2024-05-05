part of 'stripe_cubit.dart';

abstract class StripeState extends Equatable {
  const StripeState();

  @override
  List<Object> get props => [];
}

class StripeInitial extends StripeState {
  const StripeInitial();
}

class StripeLoading extends StripeState {
  const StripeLoading();
}

class StripeError extends StripeState {
  const StripeError(this.message, this.statusCode);

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class StripeLoaded extends StripeState {
  const StripeLoaded(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
