import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/failure.dart';
import '../../authentication/models/auth_error_model.dart';
import '../../authentication/repository/auth_repository.dart';
import 'delivery_man_state_model.dart';

part 'delivery_man_state.dart';

class DeliveryManCubit extends Cubit<DeliveryManStateModel> {
  final AuthRepository _authRepository;

  DeliveryManCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(DeliveryManStateModel().clear());

  void changeFirstName(String text) {
    emit(state.copyWith(
        firstName: text, deliveryState: const DeliveryManInitial()));
  }

  void changeLastName(String text) {
    emit(state.copyWith(
        lastName: text, deliveryState: const DeliveryManInitial()));
  }

  void changeManImage(String text) {
    emit(state.copyWith(
        manImage: text, deliveryState: const DeliveryManInitial()));
  }

  void changeIdnImage(String text) {
    emit(state.copyWith(
        idnImage: text, deliveryState: const DeliveryManInitial()));
  }

  void changeEmail(String text) {
    emit(
        state.copyWith(email: text, deliveryState: const DeliveryManInitial()));
  }

  void changePhone(String text) {
    emit(
        state.copyWith(phone: text, deliveryState: const DeliveryManInitial()));
  }

  void changeManType(String text) {
    emit(state.copyWith(
        manType: text, deliveryState: const DeliveryManInitial()));
  }

  void changeIdnType(String text) {
    emit(state.copyWith(
        idnType: text, deliveryState: const DeliveryManInitial()));
  }

  void changeIdnNumber(String text) {
    emit(state.copyWith(
        idnNumber: text, deliveryState: const DeliveryManInitial()));
  }

  void changePassword(String text) {
    emit(state.copyWith(
        password: text, deliveryState: const DeliveryManInitial()));
  }

  void changeConfirmPassword(String text) {
    emit(state.copyWith(
        confirmPassword: text, deliveryState: const DeliveryManInitial()));
  }

  void showPassword(bool visible) {
    emit(state.copyWith(
        showPassword: !visible, deliveryState: const DeliveryManInitial()));
  }

  void showConfirmPassword(bool visible) {
    emit(state.copyWith(
        showConfirmPassword: !visible,
        deliveryState: const DeliveryManInitial()));
  }

  Future<void> createDeliveryMan() async {
    emit(state.copyWith(deliveryState: const DeliveryManLoading()));
    print('stateBody $state');
    final result = await _authRepository.createDeliveryMan(state);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final error = DeliveryManFieldError(failure.errors);
        emit(state.copyWith(deliveryState: error));
      } else {
        final error = DeliveryManError(failure.message, failure.statusCode);
        emit(state.copyWith(deliveryState: error));
      }
    }, (created) {
      emit(state.copyWith(deliveryState: DeliveryManCreated(created)));
    });
  }

  Future<void> clearState() async {
    emit(state.clear());
  }
}
