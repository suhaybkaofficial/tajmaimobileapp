import 'dart:convert';

import 'package:equatable/equatable.dart';

class ContactUsModel extends Equatable {
  final int id;
  final String banner;
  final String title;
  final String description;
  final String email;
  final String address;
  final String phone;
  final String map;
  final String createdAt;
  final String updatedAt;
  const ContactUsModel({
    required this.id,
    required this.banner,
    required this.title,
    required this.description,
    required this.email,
    required this.address,
    required this.phone,
    required this.map,
    required this.createdAt,
    required this.updatedAt,
  });

  ContactUsModel copyWith({
    int? id,
    String? banner,
    String? title,
    String? description,
    String? email,
    String? address,
    String? phone,
    String? map,
    String? createdAt,
    String? updatedAt,
  }) {
    return ContactUsModel(
      id: id ?? this.id,
      banner: banner ?? this.banner,
      title: title ?? this.title,
      description: description ?? this.description,
      email: email ?? this.email,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      map: map ?? this.map,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'banner': banner});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'email': email});
    result.addAll({'address': address});
    result.addAll({'phone': phone});
    result.addAll({'map': map});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});

    return result;
  }

  factory ContactUsModel.fromMap(Map<String, dynamic> map) {
    return ContactUsModel(
      id: map['id']?.toInt() ?? 0,
      banner: map['banner'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      map: map['map'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactUsModel.fromJson(String source) =>
      ContactUsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ContactUsModel(id: $id, banner: $banner, title: $title, description: $description, email: $email, address: $address, phone: $phone, map: $map, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      banner,
      title,
      description,
      email,
      address,
      phone,
      map,
      createdAt,
      updatedAt,
    ];
  }
}
