part of 'updated_info_cubit.dart';

abstract class UserProfileInfoState extends Equatable {
  const UserProfileInfoState();

  @override
  List<Object> get props => [];
}

class UpdatedInfoInitial extends UserProfileInfoState {}

class UpdatedLoading extends UserProfileInfoState {}

class UpdatedLoaded extends UserProfileInfoState {
  final UserProfileInfo updatedInfo;

  const UpdatedLoaded({required this.updatedInfo});

  @override
  List<Object> get props => [updatedInfo];
}

class UpdatedError extends UserProfileInfoState {
  final String message;

  const UpdatedError({required this.message});

  @override
  List<Object> get props => [message];
}

class ProfileUpdatedState extends UserProfileInfoState {
  final String message;

  const ProfileUpdatedState({required this.message});

  @override
  List<Object> get props => [message];
}

class ProfileUpdatedErrorState extends UserProfileInfoState {
  final String message;

  const ProfileUpdatedErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
