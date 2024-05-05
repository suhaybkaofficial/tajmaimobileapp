import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/modules/flash/controller/flash_repository.dart';
import '/modules/flash/model/flash_model.dart';

part 'flash_state.dart';

class FlashCubit extends Cubit<FlashState> {
  FlashCubit(FlashRepository flashRepository)
      : _repository = flashRepository,
        super(FlashSaleLoading()) {
    getFalshSale();
  }

  final FlashRepository _repository;
  late FlashModel flashModel;

  Future<void> getFalshSale() async {
    emit(FlashSaleLoading());

    final result = await _repository.getFlashSale();
    result.fold(
      (failuer) {
        emit(FlashSaleError(errorMessage: failuer.message));
      },
      (data) {
        flashModel = data;
        emit(FlashSaleLoaded(flashModel: data));
      },
    );
  }
}
