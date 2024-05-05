// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ChildCategoryModel extends Equatable {
  final int id;
  final String categoryId;
  final String subCategoryId;
  final String name;
  final String slug;
  final String status;
  final String createdAt;
  final String updatedAt;

  const ChildCategoryModel({
    required this.id,
    required this.categoryId,
    required this.subCategoryId,
    required this.name,
    required this.slug,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  ChildCategoryModel copyWith({
    int? id,
    String? categoryId,
    String? subCategoryId,
    String? name,
    String? slug,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return ChildCategoryModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category_id': categoryId,
      'sub_category_id': subCategoryId,
      'name': name,
      'slug': slug,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory ChildCategoryModel.fromMap(Map<String, dynamic> map) {
    return ChildCategoryModel(
      id: map['id'] as int,
      categoryId: map['category_id'] as String,
      subCategoryId: map['sub_category_id'] as String,
      name: map['name'] as String,
      slug: map['slug'] as String,
      status: map['status'] as String,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChildCategoryModel.fromJson(String source) =>
      ChildCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      categoryId,
      subCategoryId,
      name,
      slug,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
