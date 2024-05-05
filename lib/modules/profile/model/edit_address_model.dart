import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'address_info.dart';
import 'city_model.dart';
import 'country_model.dart';
import 'country_state_model.dart';


class EditAddressModel extends Equatable {
  final AddressInfo address;
  final List<CityModel> cities;
  final List<CountryModel> countries;
  final List<CountryStateModel> states;

  const EditAddressModel({
    required this.address,
    required this.cities,
    required this.countries,
    required this.states,
  });

  @override
  List<Object> get props =>
      [address, cities, countries, states];

  EditAddressModel copyWith({
    AddressInfo? address,
    List<CityModel>? cities,
    List<CountryModel>? countries,
    List<CountryStateModel>? states,
  }) {
    return EditAddressModel(
      address: address ?? this.address,
      cities: cities ?? this.cities,
      countries: countries ?? this.countries,
      states: states ?? this.states,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address.toMap(),
      'cities': cities.map((x) => x.toMap()).toList(),
      'countries': countries.map((x) => x.toMap()).toList(),
      'states': states.map((x) => x.toMap()).toList(),
    };
  }

  factory EditAddressModel.fromMap(Map<String, dynamic> map) {
    return EditAddressModel(
      address:
      AddressInfo.fromMap(map['address'] as Map<String, dynamic>),
      cities: List<CityModel>.from(
        (map['cities'] as List<dynamic>).map<CityModel>(
              (x) => CityModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      countries: List<CountryModel>.from(
        (map['countries'] as List<dynamic>).map<CountryModel>(
              (x) => CountryModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      states: List<CountryStateModel>.from(
        (map['states'] as List<dynamic>).map<CountryStateModel>(
              (x) => CountryStateModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory EditAddressModel.fromJson(String source) =>
      EditAddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
