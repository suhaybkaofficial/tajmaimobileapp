import 'dart:convert';

import 'package:equatable/equatable.dart';

class AddressInfo extends Equatable {
  final int id;
  final int userId;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String type;
  final int countryId;
  final int stateId;
  final int cityId;
  final int defaultShipping;
  final int defaultBilling;
  final String createdAt;
  final String updatedAt;

  const AddressInfo({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.type,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.defaultShipping,
    required this.defaultBilling,
    required this.createdAt,
    required this.updatedAt,
  });

  AddressInfo copyWith({
    int? id,
    int? userId,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? type,
    int? countryId,
    int? stateId,
    int? cityId,
    int? defaultShipping,
    int? defaultBilling,
    String? createdAt,
    String? updatedAt,
  }) {
    return AddressInfo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      type: type ?? this.type,
      countryId: countryId ?? this.countryId,
      stateId: stateId ?? this.stateId,
      cityId: cityId ?? this.cityId,
      defaultShipping: defaultShipping ?? this.defaultShipping,
      defaultBilling: defaultBilling ?? this.defaultBilling,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'user_id': userId});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'phone': phone});
    result.addAll({'address': address});
    result.addAll({'type': type});
    result.addAll({'country_id': countryId});
    result.addAll({'state_id': stateId});
    result.addAll({'city_id': cityId});
    result.addAll({'default_shipping': defaultShipping});
    result.addAll({'default_billing': defaultBilling});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});

    return result;
  }

  factory AddressInfo.fromMap(Map<String, dynamic> map) {
    return AddressInfo(
      id: map['id']?.toInt() ?? 0,
      userId: map['user_id'] != null ? int.parse(map['user_id'].toString()) : 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
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
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressInfo.fromJson(String source) =>
      AddressInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddressInfo(id: $id, user_id: $userId, name: $name, email: $email, phone: $phone, address: $address, type: $type, country_id: $countryId, state_id: $stateId, city_id: $cityId,default_shipping: $defaultShipping,  default_billing: $defaultBilling, created_at: $createdAt, updated_at: $updatedAt)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      name,
      email,
      phone,
      address,
      type,
      countryId,
      stateId,
      cityId,
      defaultShipping,
      defaultBilling,
      cityId,
      createdAt,
      updatedAt,
    ];
  }
}
