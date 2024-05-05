// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CityModel extends Equatable {
  final int id;
  final String name;
  // final String countryStateId;

  // "country_state_id": "7",
  const CityModel({
    required this.id,
    required this.name,
    // required this.countryStateId,
  });

  CityModel copyWith({
    int? id,
    String? name,
    // String? countryStateId,
  }) {
    return CityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      // countryStateId: countryStateId ?? this.countryStateId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      // 'country_state_id': countryStateId,
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? ''
      // countryStateId: map['country_state_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id,
        name,
        // countryStateId,
      ];
}
