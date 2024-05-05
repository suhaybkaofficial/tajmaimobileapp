// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UpdateUserInfo extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final int countryId;
  final int stateId;
  final int cityId;
  final String zipCode;
  final String address;

  const UpdateUserInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.zipCode,
    required this.address,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      phone,
      image,
      countryId,
      stateId,
      cityId,
      zipCode,
      address,
    ];
  }

  UpdateUserInfo copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? image,
    int? countryId,
    int? stateId,
    int? cityId,
    String? zipCode,
    String? address,
  }) {
    return UpdateUserInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      countryId: countryId ?? this.countryId,
      stateId: stateId ?? this.stateId,
      cityId: cityId ?? this.cityId,
      zipCode: zipCode ?? this.zipCode,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'country_id': countryId,
      'state_id': stateId,
      'city_id': cityId,
      'zipCode': zipCode,
      'address': address,
    };
  }

  factory UpdateUserInfo.fromMap(Map<String, dynamic> map) {
    return UpdateUserInfo(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      image: map['image'] ?? '',
      countryId: map['country_id'] != null
          ? int.parse(map['country_id'].toString())
          : 0,
      stateId:
      map['state_id'] != null ? int.parse(map['state_id'].toString()) : 0,
      cityId: map['city_id'] != null ? int.parse(map['city_id'].toString()) : 0,
      zipCode: map['zip_code'] ?? '',
      address: map['address'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateUserInfo.fromJson(String source) =>
      UpdateUserInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
