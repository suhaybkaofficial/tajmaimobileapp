import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/error/failure.dart';
import '/modules/authentication/models/auth_error_model.dart';
import '../../authentication/controller/login/login_bloc.dart';
import '../repository/become_seller_repository.dart';
import 'become_seller_state_model.dart';

part 'become_seller_state.dart';

class BecomeSellerCubit extends Cubit<BecomeSellerStateModel> {
  final LoginBloc _loginBloc;
  final BecomeSellerRequestRepository _sellerRequestRepository;

  BecomeSellerCubit(
      {required LoginBloc loginBloc,
      required BecomeSellerRequestRepository sellerRequestRepository})
      : _loginBloc = loginBloc,
        _sellerRequestRepository = sellerRequestRepository,
        super(const BecomeSellerStateModel());

  void shopNameChange(String name) {
    emit(state.copyWith(
        shopName: name, sellerState: const BecomeSellerInitial()));
  }

  void emailChange(String email) {
    emit(
        state.copyWith(email: email, sellerState: const BecomeSellerInitial()));
  }

  void addressChange(String address) {
    emit(state.copyWith(
        address: address, sellerState: const BecomeSellerInitial()));
  }

  void phoneChange(String phone) {
    emit(
        state.copyWith(phone: phone, sellerState: const BecomeSellerInitial()));
  }

  void openAtChange(String openAt) {
    emit(state.copyWith(
        openAt: openAt, sellerState: const BecomeSellerInitial()));
  }

  void closeAtChange(String closeAt) {
    emit(state.copyWith(
        closeAt: closeAt, sellerState: const BecomeSellerInitial()));
  }

  void conditionChange(String condition) {
    emit(state.copyWith(
        agreeTermsAndCondition: condition,
        sellerState: const BecomeSellerInitial()));
  }

  void bannerChange(String banner) {
    emit(state.copyWith(
        bannerImage: banner, sellerState: const BecomeSellerInitial()));
  }

  void logoChange(String logo) {
    emit(state.copyWith(logo: logo, sellerState: const BecomeSellerInitial()));
  }

  Future<void> becomeSellerRequest() async {
    if (state.agreeTermsAndCondition == '0') {
      emit(state.copyWith(
          sellerState:
              const BecomeSellerAgreeError('Please Agree Terms & Condition')));
      emit(state.copyWith(sellerState: const BecomeSellerInitial()));
      return;
    }
    emit(state.copyWith(sellerState: const BecomeSellerLoading()));
    print('stateBody: $state');
    final result = await _sellerRequestRepository.becomeSellerRequest(
        _loginBloc.userInfo!.accessToken, state);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        emit(state.copyWith(
            sellerState: BecomeSellerFormValidate(failure.errors)));
      } else {
        emit(state.copyWith(
            sellerState:
                BecomeSellerError(failure.message, failure.statusCode)));
      }
    }, (success) {
      emit(state.copyWith(sellerState: BecomeSellerLoaded(success)));
      emit(state.clear());
    });
  }
}
