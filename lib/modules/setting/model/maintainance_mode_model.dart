// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class MaintainTextModel extends Equatable {
  //maintainance_text
  final int id;
  final int status;
  final String image;
  final String description;
  final String createdAt;
  final String updatedAt;
  const MaintainTextModel({
    required this.id,
    required this.status,
    required this.image,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props {
    return [
      id,
      status,
      image,
      description,
      createdAt,
      updatedAt,
    ];
  }

  MaintainTextModel copyWith({
    int? id,
    int? status,
    String? image,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    return MaintainTextModel(
      id: id ?? this.id,
      status: status ?? this.status,
      image: image ?? this.image,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'image': image,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory MaintainTextModel.fromMap(Map<String, dynamic> map) {
    return MaintainTextModel(
      id: map['id'] ?? 0,
      status: map['status'] != null ? int.parse(map['status'].toString()):0,
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MaintainTextModel.fromJson(String source) => MaintainTextModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
