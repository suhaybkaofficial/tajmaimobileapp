import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/modules/setting/model/all_about_model.dart';

import '../repository/setting_repository.dart';
part 'about_us_state.dart';

class AboutUsCubit extends Cubit<AboutUsState> {
  AboutUsCubit(this.settingRepository) : super(AboutUsStateLoading());

  final SettingRepository settingRepository;
  late AboutInformationModel aboutInfo;

  Future<void> getAboutUs() async {
    emit(AboutUsStateLoading());

    final result = await settingRepository.getAboutUs();
    result.fold(
      (failure) {
        emit(AboutUsStateError(errorMessage: failure.message));
      },
      (data) {
        aboutInfo = data;
        emit(AboutUsStateLoaded(aboutInfo: data));
      },
    );
  }
}
