import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/model/setting_model.dart';
import '../../../setting/model/website_setup_model.dart';
import '../repository/app_setting_repository.dart';

part 'app_setting_state.dart';

class AppSettingCubit extends Cubit<AppSettingState> {
  final _className = 'AppSettingCubit';
  final AppSettingRepository _appSettingRepository;
  WebsiteSetupModel? settingModel;

  AppSettingCubit(AppSettingRepository appSettingRepository)
      : _appSettingRepository = appSettingRepository,
        super(const AppSettingStateInitial()) {
    init();
    loadWebSetting();
  }

  bool get isOnBoardingShown =>
      _appSettingRepository.checkOnBoarding().fold((l) => false, (r) => true);

  Future<bool> cachOnBoarding() async {
    final result = await _appSettingRepository.cashOnBoarding();

    return result.fold((l) => false, (success) => success);
  }

  void init() {
    emit(const AppSettingStateInitial());
    final localSetting = _appSettingRepository.getCachedWebsiteSetup();

    localSetting.fold(
      (failure) {
        log(failure.toString(), name: _className);
        emit(const AppSettingStateNotCashed('Not cashed app setting'));
      },
      (value) {
        settingModel = value;
        log('init success', name: _className);
        emit(AppSettingStateLoaded(value));
      },
    );
  }

  Future<void> loadWebSetting() async {
    emit(const AppSettingStateLoading());
    final result = await _appSettingRepository.websiteSetup();
    result.fold(
      (failure) {
        emit(AppSettingStateError(failure.message, failure.statusCode));
      },
      (value) {
        final stateData = AppSettingStateLoaded(value);
        settingModel = value;
        emit(stateData);
      },
    );
  }
}
