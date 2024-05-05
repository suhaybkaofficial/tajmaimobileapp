part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpEventName extends SignUpEvent {
  final String name;

  const SignUpEventName(this.name);

  @override
  List<Object> get props => [name];
}

class SignUpEventEmail extends SignUpEvent {
  final String email;

  const SignUpEventEmail(this.email);

  @override
  List<Object> get props => [email];
}

class SignUpEventPhone extends SignUpEvent {
  final String phone;

  const SignUpEventPhone(this.phone);

  @override
  List<Object> get props => [phone];
}

class SignUpEventCountryCode extends SignUpEvent {
  final String code;

  const SignUpEventCountryCode(this.code);

  @override
  List<Object> get props => [code];
}

class SignUpEventPassword extends SignUpEvent {
  final String password;

  const SignUpEventPassword(this.password);

  @override
  List<Object> get props => [password];
}

class SignUpEventPasswordConfirm extends SignUpEvent {
  final String passwordConfirm;

  const SignUpEventPasswordConfirm(this.passwordConfirm);

  @override
  List<Object> get props => [passwordConfirm];
}

class SignUpEventAgree extends SignUpEvent {
  final int agree;

  const SignUpEventAgree(this.agree);

  @override
  List<Object> get props => [agree];
}

class SignUpEventSubmit extends SignUpEvent {}

class SignUpEventShowPassword extends SignUpEvent {
  final bool value;

  const SignUpEventShowPassword(this.value);

  @override
  List<Object> get props => [value];
}

class SignUpEventShowConPassword extends SignUpEvent {
  final bool value;

  const SignUpEventShowConPassword(this.value);

  @override
  List<Object> get props => [value];
}

class SignUpEventActive extends SignUpEvent {
  final bool value;

  const SignUpEventActive(this.value);

  @override
  List<Object> get props => [value];
}
