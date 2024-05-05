import 'dart:convert';

import 'package:equatable/equatable.dart';

class HomePageCategoriesModel extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String icon;
  final String image;

  const HomePageCategoriesModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.image,
  });

  HomePageCategoriesModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? icon,
    String? image,
  }) {
    return HomePageCategoriesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      icon: icon ?? this.icon,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'slug': slug,
      'icon': icon,
      'image': image,
    };
  }

  factory HomePageCategoriesModel.fromMap(Map<String, dynamic> map) {
    return HomePageCategoriesModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      icon: map['icon'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HomePageCategoriesModel.fromJson(String source) =>
      HomePageCategoriesModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, slug, icon, image];
}
