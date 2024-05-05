import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/faq_model.dart';
import '../repository/setting_repository.dart';

part 'faq_cubit_state.dart';

class FaqCubit extends Cubit<FaqCubitState> {
  FaqCubit(this.settingRepository) : super(const FaqCubitStateLoading());

  final SettingRepository settingRepository;
  late List<FaqModel> faqList;

  Future<void> getFaqList() async {
    emit(const FaqCubitStateLoading());

    final result = await settingRepository.getFaqList();
    result.fold(
      (failuer) {
        emit(FaqCubitStateError(errorMessage: failuer.message));
      },
      (data) {
        faqList = data;
        emit(FaqCubitStateLoaded(faqList: data));
      },
    );
  }
}
