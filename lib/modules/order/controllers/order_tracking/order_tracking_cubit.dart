import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/controller/login/login_bloc.dart';
import '../../model/order_model.dart';
import '../repository/order_repository.dart';

part 'order_tracking_state.dart';

class OrderTrackingCubit extends Cubit<OrderTrackingState> {
  final OrderRepository _orderRepository;

  OrderTrackingCubit({
    required LoginBloc loginBloc,
    required OrderRepository orderRepository,
  })  : _orderRepository = orderRepository,
        super(OrderTrackingInitial());
  OrderModel? singleOrder;
  TextEditingController orderIdNumberController = TextEditingController();
  GlobalKey<FormState> trackingKey = GlobalKey<FormState>();

  Future<void> trackingOrderResponse() async {
    emit(const OrderStateTrackingLoading());
    final result = await _orderRepository
        .trackingOrderResponse(orderIdNumberController.text.trim());
    result.fold(
      (failure) {
        print('errors ${failure.message}');
        emit(OrderTrackingStateError(failure.message, failure.statusCode));
      },
      (data) {
        singleOrder = data;
        final loadedState = OrderStateTrackingLoaded(data);
        emit(loadedState);
      },
    );
  }
}
