part of 'home_controller_cubit.dart';

abstract class HomeControllerState extends Equatable {
  const HomeControllerState();

  @override
  List<Object> get props => [];
}

class HomeControllerLoading extends HomeControllerState {}

class HomeControllerError extends HomeControllerState {
  final String errorMessage;
  const HomeControllerError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}

class HomeControllerLoaded extends HomeControllerState {
  final HomeModel homeModel;
  const HomeControllerLoaded({required this.homeModel});

  @override
  List<Object> get props => [homeModel];
}
