part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEvenEmailOrPhone extends LoginEvent {
  final String text;

  const LoginEvenEmailOrPhone(this.text);

  @override
  List<Object> get props => [text];
}

class LoginEventPassword extends LoginEvent {
  final String password;

  const LoginEventPassword(this.password);

  @override
  List<Object> get props => [password];
}

class LoginEventSubmit extends LoginEvent {
  const LoginEventSubmit();

}class GoogleSignInEvent extends LoginEvent {
  const GoogleSignInEvent();
}

class FacebookSignInEvent extends LoginEvent {
  const FacebookSignInEvent();
}

class LoginEventLogout extends LoginEvent {
  const LoginEventLogout();
}

class LoginEventCheckProfile extends LoginEvent {
  const LoginEventCheckProfile();
}

class SentAccountActivateCodeSubmit extends LoginEvent {
  const SentAccountActivateCodeSubmit();
}

class AccountActivateCodeSubmit extends LoginEvent {
  const AccountActivateCodeSubmit(this.code);

  final String code;

  @override
  List<Object> get props => [code];
}

class ShowPasswordEvent extends LoginEvent {
  final bool showPassword;

  const ShowPasswordEvent(this.showPassword);

  @override
  List<Object> get props => [showPassword];
}

class RememberMeEvent extends LoginEvent {
  final bool rememberMe;

  const RememberMeEvent(this.rememberMe);

  @override
  List<Object> get props => [rememberMe];
}
