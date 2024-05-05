part of 'order_tracking_cubit.dart';

abstract class OrderTrackingState extends Equatable {
  const OrderTrackingState();

  @override
  List<Object> get props => [];
}

class OrderTrackingInitial extends OrderTrackingState {}

class OrderStateTrackingLoading extends OrderTrackingState {
  const OrderStateTrackingLoading();
}

class OrderTrackingStateError extends OrderTrackingState {
  const OrderTrackingStateError(this.message, this.statusCode);

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class OrderStateTrackingLoaded extends OrderTrackingState {
  final OrderModel singleOrder;

  const OrderStateTrackingLoaded(this.singleOrder);

  @override
  List<Object> get props => [singleOrder];
}
