part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderStateInitial extends OrderState {
  const OrderStateInitial();
}

class OrderStateLoading extends OrderState {
  const OrderStateLoading();
}

class OrderStateError extends OrderState {
  const OrderStateError(this.message, this.statusCode);
  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class OrderStateLoaded extends OrderState {
  final List<OrderModel> orderList;
  const OrderStateLoaded(this.orderList);

  @override
  List<Object> get props => [orderList];
}

class OrderSingleStateLoaded extends OrderState {
  final OrderModel singleOrder;
  const OrderSingleStateLoaded(this.singleOrder);

  @override
  List<Object> get props => [singleOrder];
}
