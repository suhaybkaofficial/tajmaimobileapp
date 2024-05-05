part of 'bank_cubit.dart';

abstract class BankState extends Equatable {
  const BankState();

  @override
  List<Object> get props => [];
}

class BankInitialState extends BankState {
  const BankInitialState();
}

class BankStateLoading extends BankState {
  const BankStateLoading();
}

class BankStateError extends BankState {
  const BankStateError(this.message, this.statusCode);

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class BankLoadedState extends BankState {
  const BankLoadedState(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class BankPaymentFormError extends BankState {
  const BankPaymentFormError(this.errors);

  final Errors errors;

  @override
  List<Object> get props => [errors];
}
