// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../city_model.dart';
import '../country_model.dart';
import '../country_state_model.dart';
import 'update_user_info.dart';

class UserProfileInfo extends Equatable {
  final UpdateUserInfo updateUserInfo;
  final List<CityModel> cityModel;
  final List<CountryModel> countryModel;
  final List<CountryStateModel> stateModel;
  final DefaultImage? defaultImage;

  const UserProfileInfo({
    required this.updateUserInfo,
    required this.cityModel,
    required this.countryModel,
    required this.stateModel,
    required this.defaultImage,
  });

  @override
  List<Object> get props =>
      [updateUserInfo, cityModel, countryModel, stateModel,defaultImage!];

  UserProfileInfo copyWith({
    UpdateUserInfo? updateUserInfo,
    List<CityModel>? cityModel,
    List<CountryModel>? countryModel,
    List<CountryStateModel>? stateModel,
    DefaultImage? defaultImage,
  }) {
    return UserProfileInfo(
      updateUserInfo: updateUserInfo ?? this.updateUserInfo,
      cityModel: cityModel ?? this.cityModel,
      countryModel: countryModel ?? this.countryModel,
      stateModel: stateModel ?? this.stateModel,
      defaultImage: defaultImage ?? this.defaultImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'personInfo': updateUserInfo.toMap(),
      'cities': cityModel.map((x) => x.toMap()).toList(),
      'countries': countryModel.map((x) => x.toMap()).toList(),
      'states': stateModel.map((x) => x.toMap()).toList(),
      'defaultProfile': defaultImage!.toMap(),
    };
  }

  factory UserProfileInfo.fromMap(Map<String, dynamic> map) {
    return UserProfileInfo(
      updateUserInfo:
          UpdateUserInfo.fromMap(map['personInfo'] as Map<String, dynamic>),
      cityModel: List<CityModel>.from(
        (map['cities'] as List<dynamic>).map<CityModel>(
          (x) => CityModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      countryModel: List<CountryModel>.from(
        (map['countries'] as List<dynamic>).map<CountryModel>(
          (x) => CountryModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      stateModel: List<CountryStateModel>.from(
        (map['states'] as List<dynamic>).map<CountryStateModel>(
          (x) => CountryStateModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      defaultImage: map['defaultProfile'] != null
          ? DefaultImage.fromMap(map['defaultProfile'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileInfo.fromJson(String source) =>
      UserProfileInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}

class DefaultImage extends Equatable {
  final int id;
  final String image;

  const DefaultImage({
    required this.id,
    required this.image,
  });

  DefaultImage copyWith({
    int? id,
    String? image,
  }) {
    return DefaultImage(
      id: id ?? this.id,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
    };
  }

  factory DefaultImage.fromMap(Map<String, dynamic> map) {
    return DefaultImage(
      id: map['id'] ?? 0,
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DefaultImage.fromJson(String source) =>
      DefaultImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, image];
}
