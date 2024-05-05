part of 'login_bloc.dart';

class LoginModelState extends Equatable {
  final String text;
  final String password;
  final bool showPassword;
  final bool rememberMe;
  final LoginState state;

  const LoginModelState({
    this.text = 'user@gmail.com',
    this.password = '1234',
    // this.text = '',
    // this.password = '',
    this.showPassword = true,
    this.rememberMe = false,
    this.state = const LoginStateInitial(),
  });

  LoginModelState copyWith({
    String? text,
    String? password,
    bool? showPassword,
    bool? rememberMe,
    LoginState? state,
  }) {
    return LoginModelState(
      text: text ?? this.text,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
      rememberMe: rememberMe ?? this.rememberMe,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': text.trim()});
    result.addAll({'password': password});
    // result.addAll({'state': state});

    return result;
  }

  factory LoginModelState.fromMap(Map<String, dynamic> map) {
    return LoginModelState(
      text: map['text'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModelState.fromJson(String source) =>
      LoginModelState.fromMap(json.decode(source));

  @override
  String toString() =>
      'LoginModelState(username: $text, password: $password, state: $state)';

  @override
  List<Object> get props => [text, password, state, showPassword, rememberMe];
}

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginStateInitial extends LoginState {
  const LoginStateInitial();
}

class LoginStateFormInvalid extends LoginState {
  final Errors error;

  const LoginStateFormInvalid(this.error);

  @override
  List<Object> get props => [error];
}

class LoginStateLoading extends LoginState {
  const LoginStateLoading();
}

class GoogleStateLoading extends LoginState {
  const GoogleStateLoading();
}

class FacebookStateLoading extends LoginState {
  const FacebookStateLoading();
}

class LoginStateLogOutLoading extends LoginState {
  const LoginStateLogOutLoading();
}

class LoginStateLoaded extends LoginState {
  final UserLoginResponseModel user;

  const LoginStateLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class LoginStateUpdatedProfile extends LoginState {
  final UserLoginResponseModel user;

  const LoginStateUpdatedProfile(this.user);

  @override
  List<Object> get props => [user];
}

class LoginStateError extends LoginState {
  final String errorMsg;
  final int statusCode;

  const LoginStateError(this.errorMsg, this.statusCode);

  @override
  List<Object> get props => [errorMsg, statusCode];
}

class LoginStateSignOutError extends LoginState {
  final String errorMsg;
  final int statusCode;

  const LoginStateSignOutError(this.errorMsg, this.statusCode);

  @override
  List<Object> get props => [errorMsg, statusCode];
}

class AccountActivateSuccess extends LoginState {
  final String msg;

  const AccountActivateSuccess(this.msg);

  @override
  List<Object> get props => [msg];
}

class SendAccountCodeSuccess extends LoginState {
  final String msg;

  const SendAccountCodeSuccess(this.msg);

  @override
  List<Object> get props => [msg];
}

class LoginStateLogOut extends LoginState {
  final String msg;
  final int statusCode;

  const LoginStateLogOut(this.msg, this.statusCode);

  @override
  List<Object> get props => [msg, statusCode];
}
