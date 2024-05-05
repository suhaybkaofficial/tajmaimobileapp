part of 'razorpay_cubit.dart';

abstract class RazorpayState extends Equatable {
  const RazorpayState();

  @override
  List<Object> get props => [];
}

class RazorpayStateInitial extends RazorpayState {
  const RazorpayStateInitial();
}

class RazorStateLoading extends RazorpayState {
  const RazorStateLoading();
}

class RazorStateError extends RazorpayState {
  final String message;
  final int statusCode;

  const RazorStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class RazorStateLoaded extends RazorpayState {
  final Map<String, dynamic> razorOrder;

  const RazorStateLoaded(this.razorOrder);

  @override
  List<Object> get props => [razorOrder];
}
