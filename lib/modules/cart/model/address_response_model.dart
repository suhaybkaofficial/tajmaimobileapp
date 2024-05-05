// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AddressResponseModel extends Equatable {
  final int id;
  final int userId;
  final String name;
  final String email;
  final String phone;
  final int countryId;
  final int stateId;
  final int cityId;
  final String address;
  final int type;
  final int defaultShipping;
  final int defaultBilling;
  final String createdAt;
  final String updatedAt;

  const AddressResponseModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.address,
    required this.type,
    required this.defaultShipping,
    required this.defaultBilling,
    required this.createdAt,
    required this.updatedAt,
  });

  AddressResponseModel copyWith({
    int? id,
    int? userId,
    String? name,
    String? email,
    String? phone,
    int? countryId,
    int? stateId,
    int? cityId,
    String? address,
    int? type,
    int? defaultShipping,
    int? defaultBilling,
    String? createdAt,
    String? updatedAt,
  }) {
    return AddressResponseModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      countryId: countryId ?? this.countryId,
      stateId: stateId ?? this.stateId,
      cityId: cityId ?? this.cityId,
      address: address ?? this.address,
      type: type ?? this.type,
      defaultShipping: defaultShipping ?? this.defaultShipping,
      defaultBilling: defaultBilling ?? this.defaultBilling,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'country_id': countryId,
      'state_id': stateId,
      'city_id': cityId,
      'address': address,
      'type': type,
      'default_shipping': defaultShipping,
      'default_billing': defaultBilling,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory AddressResponseModel.fromMap(Map<String, dynamic> map) {
    return AddressResponseModel(
      id: map['id'] as int,
      userId: map['user_id'] != null ? int.parse(map['user_id'].toString()) : 0,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      type: map['type'] != null ? int.parse(map['type'].toString()) : 0,
      countryId: map['country_id'] != null
          ? int.parse(map['country_id'].toString())
          : 0,
      stateId:
          map['state_id'] != null ? int.parse(map['state_id'].toString()) : 0,
      cityId: map['city_id'] != null ? int.parse(map['city_id'].toString()) : 0,
      defaultShipping: map['default_shipping'] != null
          ? int.parse(map['default_shipping'].toString())
          : 0,
      defaultBilling: map['default_billing'] != null
          ? int.parse(map['default_billing'].toString())
          : 0,
      address: map['address'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressResponseModel.fromJson(String source) =>
      AddressResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      userId,
      name,
      email,
      phone,
      countryId,
      stateId,
      cityId,
      address,
      type,
      defaultShipping,
      defaultBilling,
      createdAt,
      updatedAt,
    ];
  }
}
