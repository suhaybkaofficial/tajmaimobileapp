import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../models/auth_error_model.dart';
import '../../repository/auth_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpModelState> {
  final AuthRepository repository;

  //final formKey = GlobalKey<FormState>();
  SignUpBloc(this.repository) : super(const SignUpModelState()) {
    on<SignUpEventName>((event, emit) {
      emit(state.copyWith(name: event.name, state: const SignUpStateInitial()));
    });
    on<SignUpEventEmail>((event, emit) {
      emit(state.copyWith(
          email: event.email, state: const SignUpStateInitial()));
    });
    on<SignUpEventPhone>((event, emit) {
      emit(state.copyWith(
          phone: event.phone, state: const SignUpStateInitial()));
    });
    on<SignUpEventCountryCode>((event, emit) {
      emit(state.copyWith(
          countryCode: event.code, state: const SignUpStateInitial()));
    });
    on<SignUpEventPassword>((event, emit) {
      emit(state.copyWith(
          password: event.password, state: const SignUpStateInitial()));
    });
    on<SignUpEventPasswordConfirm>((event, emit) {
      emit(state.copyWith(
          passwordConfirmation: event.passwordConfirm,
          state: const SignUpStateInitial()));
    });
    on<SignUpEventAgree>((event, emit) {
      emit(state.copyWith(
          agree: event.agree, state: const SignUpStateInitial()));
    });

    on<SignUpEventShowPassword>((event, emit) {
      emit(state.copyWith(
          showPassword: !(event.value), state: const SignUpStateInitial()));
    });

    on<SignUpEventShowConPassword>((event, emit) {
      emit(state.copyWith(
          showConPassword: !(event.value), state: const SignUpStateInitial()));
    });

    on<SignUpEventActive>((event, emit) {
      emit(state.copyWith(
          active: !(event.value), state: const SignUpStateInitial()));
    });
    on<SignUpEventSubmit>(_submitForm);
  }

  void _submitForm(
      SignUpEventSubmit event, Emitter<SignUpModelState> emit) async {
    //if (!formKey.currentState!.validate()) return;

    if (state.agree == 0) {
      const stateError =
          SignUpStateFormError('Please agree with privacy policy', 404);
      emit(state.copyWith(state: const SignUpStateInitial()));
      emit(state.copyWith(state: stateError));
      return;
    }
    emit(state.copyWith(state: const SignUpStateLoading()));
    final bodyData = state.toMap();
    log(bodyData.toString(), name: "SignUp Data");

    final result = await repository.signUp(bodyData);

    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          final errors = SignUpStateFormValidationError(failure.errors);
          emit(state.copyWith(state: errors));
        } else {
          // final data = failure['notification'];
          //log(failure.errors.toString(), name: "SignUpBloc Error");
          final error =
              SignUpStateFormError(failure.message, failure.statusCode);
          emit(state.copyWith(state: error));
        }
      },
      (user) {
        log(user.toString(), name: "SignUpBloc Success");
        emit(state.copyWith(state: SignUpStateLoaded(user)));
      },
    );
  }
}
