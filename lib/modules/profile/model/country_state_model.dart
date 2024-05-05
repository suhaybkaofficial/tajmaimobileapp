// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CountryStateModel extends Equatable {
  final int id;
  final String name;
  // final String countryId;
  //"country_id" : "4",
  const CountryStateModel({
    required this.id,
    required this.name,
    // required this.countryId,
  });

  CountryStateModel copyWith({
    int? id,
    String? name,
    String? countryId,
  }) {
    return CountryStateModel(
      id: id ?? this.id,
      name: name ?? this.name,
      // countryId: countryId ?? this.countryId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      // 'country_id': countryId,
    };
  }

  factory CountryStateModel.fromMap(Map<String, dynamic> map) {
    return CountryStateModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      // countryId: map['country_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryStateModel.fromJson(String source) =>
      CountryStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id,
        name,
        // countryId,
      ];
}
