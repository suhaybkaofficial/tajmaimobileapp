import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/error/failure.dart';
import '../../../authentication/controller/login/login_bloc.dart';
import '../../../authentication/models/auth_error_model.dart';
import '../../../authentication/models/user_prfile_model.dart';
import '../repository/profile_repository.dart';

part 'profile_edit_state.dart';

class ProfileEditCubit extends Cubit<ProfileEditStateModel> {
  final LoginBloc _loginBloc;
  final ProfileRepository _profileRepository;
  final profileFormKey = GlobalKey<FormState>();

  ProfileEditCubit({
    required LoginBloc loginBloc,
    required ProfileRepository profileRepository,
  })  : _loginBloc = loginBloc,
        _profileRepository = profileRepository,
        super(ProfileEditStateModel.init(loginBloc.userInfo!.user));

  void changeName(String value) {
    emit(
      state.copyWith(
        name: value,
        stateStatus: const ProfileEditStateInitial(),
      ),
    );
  }

  void changePhoneCode(String value) {
    emit(
      state.copyWith(
        phoneCode: value,
        stateStatus: const ProfileEditStateInitial(),
      ),
    );
  }

  void changePhone(String value) {
    emit(
      state.copyWith(
        phone: value,
        stateStatus: const ProfileEditStateInitial(),
      ),
    );
  }

  void changeCountry(String value) {
    emit(
      state.copyWith(
        country: value,
        stateStatus: const ProfileEditStateInitial(),
      ),
    );
  }

  void changeState(String value) {
    emit(
      state.copyWith(
        state: value,
        stateStatus: const ProfileEditStateInitial(),
      ),
    );
  }

  void changeCity(String value) {
    emit(
      state.copyWith(
        city: value,
        stateStatus: const ProfileEditStateInitial(),
      ),
    );
  }

  void changeZipCode(String value) {
    emit(
      state.copyWith(
        zipCode: value,
        stateStatus: const ProfileEditStateInitial(),
      ),
    );
  }

  void changeAddress(String value) {
    emit(
      state.copyWith(
        address: value,
        stateStatus: const ProfileEditStateInitial(),
      ),
    );
  }

  void changeImage(String? value) {
    emit(
      state.copyWith(
        image: value,
        stateStatus: const ProfileEditStateInitial(),
      ),
    );
  }

  Future<void> submitForm() async {
    //if (!profileFormKey.currentState!.validate()) return;

    emit(state.copyWith(stateStatus: const ProfileEditStateLoading()));

    final result = await _profileRepository.profileUpdate(
        state, _loginBloc.userInfo!.accessToken);

    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          final errorState = ProfileEditFormValidState(failure.errors);
          emit(state.copyWith(stateStatus: errorState));
        } else {
          emit(state.copyWith(
              stateStatus:
                  ProfileEditStateError(failure.message, failure.statusCode)));
        }
      },
      (successData) {
        emit(state.copyWith(stateStatus: ProfileEditStateLoaded(successData)));
      },
    );
  }
}
