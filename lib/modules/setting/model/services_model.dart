// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Services extends Equatable {
  final int id;
  final String title;
  final String icon;
  final String description;
  final String createdAt;
  final String updatedAt;

  const Services({
    required this.id,
    required this.title,
    required this.icon,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  Services copyWith({
    int? id,
    String? title,
    String? icon,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    return Services(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'icon': icon,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Services.fromMap(Map<String, dynamic> map) {
    return Services(
      id: map['id'] as int,
      title: map['title'] as String,
      icon: map['icon'] as String,
      description: map['description'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Services.fromJson(String source) =>
      Services.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      title,
      icon,
      description,
      createdAt,
      updatedAt,
    ];
  }
}
