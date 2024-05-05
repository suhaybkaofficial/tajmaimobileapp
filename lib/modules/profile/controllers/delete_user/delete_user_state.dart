part of 'delete_user_cubit.dart';

abstract class DeleteUserState extends Equatable {
  const DeleteUserState();

  @override
  List<Object> get props => [];
}

class DeleteUserInitial extends DeleteUserState {
  const DeleteUserInitial();
}

class DeleteUserLoading extends DeleteUserState {
  const DeleteUserLoading();
}

class DeleteUserLoaded extends DeleteUserState {
  final String message;

  const DeleteUserLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class DeleteUserError extends DeleteUserState {
  final String message;
  final int statusCode;

  const DeleteUserError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
