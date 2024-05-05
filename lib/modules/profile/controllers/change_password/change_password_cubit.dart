import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../authentication/controller/login/login_bloc.dart';
import '../repository/profile_repository.dart';
part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordStateModel> {
  ChangePasswordCubit({
    required ProfileRepository profileRepository,
    required LoginBloc loginBloc,
  })  : _profileRepository = profileRepository,
        _loginBloc = loginBloc,
        super(ChangePasswordStateModel.init());

  final ProfileRepository _profileRepository;
  final LoginBloc _loginBloc;

  final formKey = GlobalKey<FormState>();
  final currentPassCtr = TextEditingController();
  final passCtr = TextEditingController();
  final passConfCtr = TextEditingController();

  void currentPassChange(String value) {
    emit(state.copyWith(
      currentPassword: value,
      status: const ChangePasswordStateInitial(),
    ));
  }

  void paswordChange(String value) {
    emit(state.copyWith(
      password: value,
      status: const ChangePasswordStateInitial(),
    ));
  }

  void paswordConfirmChange(String value) {
    emit(state.copyWith(
      passwordConfirmation: value,
      status: const ChangePasswordStateInitial(),
    ));
  }

  Future<void> submitForm() async {
    if (_loginBloc.userInfo == null) {
      emit(state.copyWith(
          status: const ChangePasswordStateError('Signin please', 10000)));
      return;
    }
    if (!formKey.currentState!.validate()) return;

    emit(state.copyWith(status: const ChangePasswordStateLoading()));

    final token = _loginBloc.userInfo!.accessToken;

    final result = await _profileRepository.passwordChange(state, token);

    result.fold(
      (failure) {
        final currentState =
            ChangePasswordStateError(failure.message, failure.statusCode);
        emit(state.copyWith(status: currentState));
      },
      (succes) {
        final currentState = ChangePasswordStateLoaded(succes);
        emit(state.copyWith(status: currentState));
        currentPassCtr.clear();
        passConfCtr.clear();
        passCtr.clear();
      },
    );
  }
}
