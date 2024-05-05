import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/error/failure.dart';
import '../../../profile/controllers/repository/profile_repository.dart';
import '../../../profile/model/country_model.dart';
import '../../../profile/model/user_with_country_response.dart';
import '../../models/auth_error_model.dart';
import '../../models/user_login_response_model.dart';
import '../../repository/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginModelState> {
  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;
  final formKey = GlobalKey<FormState>();

  final List<CountryModel> countries = [];

  UserLoginResponseModel? _user;

  bool get isLogedIn => _user != null && _user!.accessToken.isNotEmpty;

  UserLoginResponseModel? get userInfo => _user;

  set user(UserLoginResponseModel userData) => _user = userData;

  LoginBloc({
    required AuthRepository authRepository,
    required ProfileRepository profileRepository,
  })  : _authRepository = authRepository,
        _profileRepository = profileRepository,
        super(const LoginModelState()) {
    on<LoginEvenEmailOrPhone>((event, emit) {
      emit(state.copyWith(text: event.text, state: const LoginStateInitial()));
    });
    on<LoginEventPassword>((event, emit) {
      emit(state.copyWith(
          password: event.password, state: const LoginStateInitial()));
    });
    on<ShowPasswordEvent>((event, emit) {
      emit(state.copyWith(
          showPassword: !(event.showPassword),
          state: const LoginStateInitial()));
    });
    on<RememberMeEvent>((event, emit) {
      emit(state.copyWith(
          rememberMe: !(event.rememberMe), state: const LoginStateInitial()));
    });
    on<LoginEventSubmit>(_submitLoginForm);
    on<GoogleSignInEvent>(_googleSocialAuth);
    on<FacebookSignInEvent>(_facebookSocialAuth);
    on<SentAccountActivateCodeSubmit>(_sentAccountActivateCode);
    on<AccountActivateCodeSubmit>(_accountActivateCode);
    on<LoginEventLogout>(_logOut);
    on<LoginEventCheckProfile>(_getUserInfo);

    /// set user data if usre already login

    final result = _authRepository.getCashedUserInfo();

    result.fold(
      (l) => _user = null,
      (r) {
        user = r;
      },
    );
  }

  Future<void> _getUserInfo(
    LoginEventCheckProfile event,
    Emitter<LoginModelState> emit,
  ) async {
    final result = _authRepository.getCashedUserInfo();

    result.fold(
      (l) => _user = null,
      (r) {
        user = r;
        emit(state.copyWith(state: LoginStateLoaded(r)));
      },
    );

    ///load user info if user loged in and update user on bloc state
    if (isLogedIn) {
      final updateProfile =
          await _profileRepository.userProfile(userInfo!.accessToken);

      updateProfile.fold(
        (failure) {
          if (failure.statusCode == 401) {
            final currentState = LoginStateLogOut(
                'Session expired, Sign-in again', failure.statusCode);
            emit(state.copyWith(state: currentState));
          } else {
            final currentState =
                LoginStateError(failure.message, failure.statusCode);
            emit(state.copyWith(state: currentState));
          }
        },
        (UserWithCountryResponse userCountry) {
          user = (_user?.copyWith(user: userCountry.user))!;
          countries.clear();
          countries.addAll(userCountry.countries);
          emit(state.copyWith(state: LoginStateUpdatedProfile(userInfo!)));
        },
      );
    } else {
      _user = null;
      const currentState = LoginStateInitial();
      emit(state.copyWith(state: currentState));
    }
  }

  Future<void> _submitLoginForm(
    LoginEventSubmit event,
    Emitter<LoginModelState> emit,
  ) async {
    if (!formKey.currentState!.validate()) return;

    emit(state.copyWith(state: const LoginStateLoading()));
    final bodyData = state.toMap();

    final result = await _authRepository.login(bodyData);

    result.fold(
      (failure) {
        if (failure is InvalidAuthData) {
          final errors = LoginStateFormInvalid(failure.errors);
          emit(state.copyWith(state: errors));
        } else {
          final error = LoginStateError(failure.message, failure.statusCode);
          emit(state.copyWith(state: error));
        }
      },
      (user) {
        final loadedData = LoginStateLoaded(user);
        _user = user;
        emit(state.copyWith(state: loadedData));

        emit(state.copyWith(
          text: '',
          password: '',
          state: const LoginStateInitial(),
        ));
      },
    );
  }

  final _googleSignIn = GoogleSignIn();

  // final _firebaseAuth = FirebaseAuth.instance;

  FutureOr<void> _googleSocialAuth(
      GoogleSignInEvent event, Emitter<LoginModelState> emit) async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        emit(state.copyWith(state: const GoogleStateLoading()));
        final userInfo =
            "email=${googleSignInAccount.email}&name=${googleSignInAccount.displayName}&provider=google&provider_id={${googleSignInAccount.id}}";

        final request = await _authRepository.socialSignInRepo(userInfo);

        request.fold(
          (failure) {
            final error = LoginStateError(failure.message, failure.statusCode);
            emit(state.copyWith(state: error));
          },
          (user) {
            final loadedData = LoginStateLoaded(user);
            _user = user;
            emit(state.copyWith(state: loadedData));
          },
        );
      }
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  FutureOr<void> _facebookSocialAuth(
      FacebookSignInEvent event, Emitter<LoginModelState> emit) async {
    try {
      final result = await FacebookAuth.instance.login();
      //     .then((value) {
      //   FacebookAuth.instance.getUserData().then((value)async{
      //     userData = value;
      //   });
      // });

      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        emit(state.copyWith(state: const FacebookStateLoading()));
        final userInfo =
            "email=${userData['email']}&name=${userData['name']}&provider=facebook&provider_id={${userData['id']}}";

        final request = await _authRepository.socialSignInRepo(userInfo);

        request.fold(
          (failure) {
            final error = LoginStateError(failure.message, failure.statusCode);
            emit(state.copyWith(state: error));
          },
          (user) {
            final loadedData = LoginStateLoaded(user);
            _user = user;
            emit(state.copyWith(state: loadedData));
          },
        );
      }
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  Future<void> _sentAccountActivateCode(
    SentAccountActivateCodeSubmit event,
    Emitter<LoginModelState> emit,
  ) async {
    emit(state.copyWith(state: const LoginStateLoading()));

    final result = await _authRepository.sendActiveAccountCode(state.text);

    result.fold(
      (Failure failure) {
        final error = LoginStateError(failure.message, failure.statusCode);
        emit(state.copyWith(state: error));
      },
      (String success) {
        final loadedData = SendAccountCodeSuccess(success);
        emit(state.copyWith(state: loadedData));
      },
    );
  }

  Future<void> _accountActivateCode(
    AccountActivateCodeSubmit event,
    Emitter<LoginModelState> emit,
  ) async {
    emit(state.copyWith(state: const LoginStateLoading()));

    final result = await _authRepository.activeAccountCodeSubmit(event.code);

    result.fold(
      (Failure failure) {
        final error = LoginStateError(failure.message, failure.statusCode);
        emit(state.copyWith(state: error));
      },
      (String success) {
        final loadedData = AccountActivateSuccess(success);
        emit(state.copyWith(state: loadedData));
      },
    );
  }

  Future<void> _logOut(
    LoginEventLogout event,
    Emitter<LoginModelState> emit,
  ) async {
    emit(state.copyWith(state: const LoginStateLogOutLoading()));

    final result = await _authRepository.logOut(userInfo!.accessToken);

    result.fold(
      (Failure failure) {
        if (failure.statusCode == 500) {
          const loadedData = LoginStateLogOut('logout success', 200);
          emit(state.copyWith(state: loadedData));
        } else {
          final error =
              LoginStateSignOutError(failure.message, failure.statusCode);
          emit(state.copyWith(state: error));
        }
      },
      (String success) {
        _user = null;
        final loadedData = LoginStateLogOut(success, 200);
        emit(state.copyWith(state: loadedData));
      },
    );
  }
}
