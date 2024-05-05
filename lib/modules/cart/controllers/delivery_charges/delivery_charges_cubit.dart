import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'delivery_charges_state.dart';

class DeliveryChargesCubit extends Cubit<DeliveryChargesState> {
  DeliveryChargesCubit() : super(DeliveryChargesInitial());
  double initialPrice = 0.0;

  void addDeliveryCharges(double price) {
    emit(DeliveryChargesInitial());
    initialPrice = price;
    emit(DeliveryChargesAdded());
  }
}
