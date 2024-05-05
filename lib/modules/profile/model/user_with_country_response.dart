import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../authentication/models/user_prfile_model.dart';
import 'country_model.dart';

class UserWithCountryResponse extends Equatable {
  final UserProfileModel user;
  final List<CountryModel> countries;
  const UserWithCountryResponse({
    required this.user,
    required this.countries,
  });

  UserWithCountryResponse copyWith({
    UserProfileModel? user,
    List<CountryModel>? countries,
  }) {
    return UserWithCountryResponse(
      user: user ?? this.user,
      countries: countries ?? this.countries,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'user': user.toMap()});
    result.addAll({'countries': countries.map((x) => x.toMap()).toList()});

    return result;
  }

  factory UserWithCountryResponse.fromMap(Map<String, dynamic> map) {
    return UserWithCountryResponse(
      user: UserProfileModel.fromMap(map['user']),
      countries: List<CountryModel>.from(
          map['countries']?.map((x) => CountryModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserWithCountryResponse.fromJson(String source) =>
      UserWithCountryResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserWithCountryResponse(user: $user, countries: $countries)';

  @override
  List<Object> get props => [user, countries];
}
