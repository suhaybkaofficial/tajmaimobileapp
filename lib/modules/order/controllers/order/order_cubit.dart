import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/utils.dart';
import '../../../authentication/controller/login/login_bloc.dart';
import '../../model/order_model.dart';
import '../repository/order_repository.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final LoginBloc _loginBloc;
  final OrderRepository _orderRepository;

  OrderCubit({
    required LoginBloc loginBloc,
    required OrderRepository orderRepository,
  })  : _loginBloc = loginBloc,
        _orderRepository = orderRepository,
        super(const OrderStateInitial());

  List<OrderModel> orderList = [];
  OrderModel? singleOrder;

  void getOrderList() async {
    if (_loginBloc.userInfo == null) {
      emit(const OrderStateError('Sign-In please', 401));
      return;
    }
    emit(const OrderStateLoading());
    final result =
        await _orderRepository.orderList(_loginBloc.userInfo!.accessToken);
    result.fold(
      (failure) {
        emit(OrderStateError(failure.message, failure.statusCode));
      },
      (data) {
        orderList = data;
        final loadedState = OrderStateLoaded(data);
        emit(loadedState);
      },
    );
  }

  Future<void> showOrderTracking(String trackNumber) async {
    if (_loginBloc.userInfo == null) {
      emit(const OrderStateError('Sign-In please', 401));
      return;
    }
    emit(const OrderStateLoading());
    final result = await _orderRepository.showOrderTracking(
        trackNumber, _loginBloc.userInfo!.accessToken);
    result.fold(
      (failure) {
        emit(OrderStateError(failure.message, failure.statusCode));
      },
      (data) {
        singleOrder = data;
        final loadedState = OrderSingleStateLoaded(data);
        emit(loadedState);
      },
    );
  }

  String orderStatusWithLenght(int i) {
    final temList = <OrderModel>[];

    for (var element in orderList) {
      if (i == element.orderStatus) {
        temList.add(element);
      }
    }
    return "${Utils.orderStatus(i.toString())} (${temList.length})";
  }
}
