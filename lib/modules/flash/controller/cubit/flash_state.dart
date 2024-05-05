part of 'flash_cubit.dart';

abstract class FlashState extends Equatable {
  const FlashState();

  @override
  List<Object> get props => [];
}

class FlashInitial extends FlashState {}

class FlashSaleLoading extends FlashState {}

class FlashSaleError extends FlashState {
  final String errorMessage;
  const FlashSaleError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}

class FlashSaleLoaded extends FlashState {
  final FlashModel flashModel;
  const FlashSaleLoaded({required this.flashModel});

  @override
  List<Object> get props => [flashModel];
}
