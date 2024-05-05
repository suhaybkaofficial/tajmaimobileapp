part of 'country_state_by_id_cubit.dart';

abstract class CountryStateByIdState extends Equatable {
  const CountryStateByIdState();

  @override
  List<Object> get props => [];
}

class CountryStateByIdStateInitial extends CountryStateByIdState {}

class CountryStateByIdStateLoading extends CountryStateByIdState {
  const CountryStateByIdStateLoading();
}

class CountryStateByIdStateError extends CountryStateByIdState {
  const CountryStateByIdStateError(this.statusCode, this.mesage);
  final int statusCode;
  final String mesage;
  @override
  List<Object> get props => [mesage, statusCode];
}

class CountryStateByIdStateLoadied extends CountryStateByIdState {
  final List<CountryStateModel> stateList;
  const CountryStateByIdStateLoadied(this.stateList);

  @override
  List<Object> get props => [stateList];
}

class CountryStateByIdCityLoading extends CountryStateByIdState {
  const CountryStateByIdCityLoading();
}

class CountryStateByIdCityLoaded extends CountryStateByIdState {
  final List<CityModel> cities;
  const CountryStateByIdCityLoaded(this.cities);
}

class CountryStateByIdCityFilter extends CountryStateByIdState {
  final List<CityModel> cities;
  const CountryStateByIdCityFilter(this.cities);
}

class CountryLoadingState extends CountryStateByIdState {
  const CountryLoadingState();
}

class CountryLoadedState extends CountryStateByIdState {
  final List<CountryModel> countries;
  const CountryLoadedState(this.countries);
}


