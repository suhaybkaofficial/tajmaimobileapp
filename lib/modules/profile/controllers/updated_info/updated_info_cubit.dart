import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../authentication/controller/login/login_bloc.dart';
import '../../model/city_model.dart';
import '../../model/country_model.dart';
import '../../model/country_state_model.dart';
import '../../model/user_info/user_updated_info.dart';
import '../repository/profile_repository.dart';

part 'updated_info_state.dart';

class UserProfileInfoCubit extends Cubit<UserProfileInfoState> {
  final ProfileRepository _profileRepository;
  final LoginBloc _loginBloc;
  late UserProfileInfo updatedInfo;

  UserProfileInfoCubit({
    required ProfileRepository profileRepository,
    required LoginBloc loginBloc,
  })  : _profileRepository = profileRepository,
        _loginBloc = loginBloc,
        super(UpdatedInfoInitial());

  List<CountryModel> countryList = [];
  List<CountryStateModel> stateList = [];
  List<CityModel> cities = [];

  Future<void> getUserProfileInfo() async {
    if (_loginBloc.userInfo != null) {
      emit(UpdatedLoading());

      final result = await _profileRepository
          .getUserProfileInfo(_loginBloc.userInfo!.accessToken);
      result.fold((f) {
        return UpdatedError(message: f.message);
      }, (success) {
        updatedInfo = success;

        countryList = updatedInfo.countryModel.toSet().toList();
        stateList = updatedInfo.stateModel.toSet().toList();
        cities = updatedInfo.cityModel.toSet().toList();

        log(updatedInfo.stateModel.toString(), name: "SL Check");

        emit(UpdatedLoaded(updatedInfo: success));
      });
    }
  }

  Future<void> updateProfileInformation(
      Map<String, String> dataMap, String token) async {
    emit(UpdatedLoading());
    final result = await _profileRepository.updateProfileInformation(
        _loginBloc.userInfo!.accessToken, dataMap);
    result.fold((l) {
      emit(ProfileUpdatedErrorState(message: l.message));
    }, (profileUpdated) {
      emit(ProfileUpdatedState(message: profileUpdated));
    });
  }

  CountryStateModel? defaultState(String id) {
    for (var item in stateList) {
      if (item.id.toString() == id) {
        return item;
      }
    }
    return null;
  }

  CityModel? defaultCity(String id) {
    for (var item in cities) {
      if (item.id.toString() == id) {
        return item;
      }
    }
    return null;
  }
}
