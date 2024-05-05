part of 'delivery_man_cubit.dart';

abstract class DeliveryManState extends Equatable {
  const DeliveryManState();

  @override
  List<Object> get props => [];
}

class DeliveryManInitial extends DeliveryManState {
  const DeliveryManInitial();
}

class DeliveryManLoading extends DeliveryManState {
  const DeliveryManLoading();
}

class DeliveryManError extends DeliveryManState {
  final String message;
  final int statusCode;

  const DeliveryManError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class DeliveryManFieldError extends DeliveryManState {
  final Errors errors;

  const DeliveryManFieldError(this.errors);

  @override
  List<Object> get props => [errors];
}

class DeliveryManCreated extends DeliveryManState {
  final String message;

  const DeliveryManCreated(this.message);

  @override
  List<Object> get props => [message];
}
