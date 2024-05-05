part of 'change_password_cubit.dart';

class ChangePasswordStateModel extends Equatable {
  final String currentPassword;
  final String password;
  final String passwordConfirmation;
  final ChangePasswordState status;
  const ChangePasswordStateModel({
    required this.currentPassword,
    required this.password,
    required this.passwordConfirmation,
    required this.status,
  });
  factory ChangePasswordStateModel.init() {
    return const ChangePasswordStateModel(
      currentPassword: '',
      password: '',
      passwordConfirmation: '',
      status: ChangePasswordStateInitial(),
    );
  }

  ChangePasswordStateModel copyWith({
    String? currentPassword,
    String? password,
    String? passwordConfirmation,
    ChangePasswordState? status,
  }) {
    return ChangePasswordStateModel(
      currentPassword: currentPassword ?? this.currentPassword,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'current_password': currentPassword});
    result.addAll({'password': password});
    result.addAll({'password_confirmation': passwordConfirmation});

    return result;
  }

  @override
  String toString() {
    return 'ChangePasswordStateModel(currentPassword: $currentPassword, password: $password, passwordConfirmation: $passwordConfirmation, status: $status)';
  }

  @override
  List<Object> get props =>
      [currentPassword, password, passwordConfirmation, status];
}

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordStateInitial extends ChangePasswordState {
  const ChangePasswordStateInitial();
}

class ChangePasswordStateLoading extends ChangePasswordState {
  const ChangePasswordStateLoading();
}

class ChangePasswordStateLoaded extends ChangePasswordState {
  final String mesage;
  const ChangePasswordStateLoaded(this.mesage);
  @override
  List<Object> get props => [mesage];
}

class ChangePasswordStateError extends ChangePasswordState {
  final String message;
  final int statusCode;
  const ChangePasswordStateError(this.message, this.statusCode);
  @override
  List<Object> get props => [message, statusCode];
}
