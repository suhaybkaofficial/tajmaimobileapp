import 'dart:convert';
import 'package:equatable/equatable.dart';

class SetPasswordModel extends Equatable {
  final String code;
  final String email;
  final String password;
  final String passwordConfirmation;
  const SetPasswordModel({
    required this.code,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  SetPasswordModel copyWith({
    String? code,
    String? email,
    String? password,
    String? passwordConfirmation,
  }) {
    return SetPasswordModel(
      code: code ?? this.code,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': email});
    result.addAll({'password': password});
    result.addAll({'password_confirmation': passwordConfirmation});

    return result;
  }

  factory SetPasswordModel.fromMap(Map<String, dynamic> map) {
    return SetPasswordModel(
      code: map['code'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      passwordConfirmation: map['password_confirmation'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SetPasswordModel.fromJson(String source) =>
      SetPasswordModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SetPasswordModel(code: $code, email: $email, password: $password, password_confirmation: $passwordConfirmation)';
  }

  @override
  List<Object> get props => [code, email, password, passwordConfirmation];
}
