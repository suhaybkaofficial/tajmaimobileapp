import 'dart:convert';
import 'package:equatable/equatable.dart';

class SliderModel extends Equatable {
  final int id;
  final String badge;
  final String titleOne;
  final String titleTwo;
  final String image;
  final int status;
  final int serial;
  final String sliderLocation;
  final String productSlug;
  final String createdAt;
  final String updatedAt;
  const SliderModel({
    required this.id,
    required this.badge,
    required this.titleTwo,
    required this.titleOne,
    required this.image,
    required this.status,
    required this.serial,
    required this.sliderLocation,
    required this.productSlug,
    required this.createdAt,
    required this.updatedAt,
  });

  SliderModel copyWith({
    int? id,
    String? badge,
    String? titleTwo,
    String? titleOne,
    String? image,
    String? link,
    int? status,
    int? serial,
    String? sliderLocation,
    String? productSlug,
    String? createdAt,
    String? updatedAt,
  }) {
    return SliderModel(
      id: id ?? this.id,
      badge: badge ?? this.badge,
      titleTwo: titleTwo ?? this.titleTwo,
      titleOne: titleOne ?? this.titleOne,
      image: image ?? this.image,
      status: status ?? this.status,
      serial: serial ?? this.serial,
      sliderLocation: sliderLocation ?? this.sliderLocation,
      productSlug: productSlug ?? this.productSlug,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'badge': badge,
      'title_one': titleOne,
      'title_two': titleTwo,
      'image': image,
      'status': status,
      'serial': serial,
      'slider_location': sliderLocation,
      'product_slug': productSlug,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory SliderModel.fromMap(Map<String, dynamic> map) {
    return SliderModel(
      id: map['id'] ?? 0,
      badge: map['badge'] ?? "",
      titleTwo: map['title_one'] ?? "",
      titleOne: map['title_two'] ?? "",
      image: map['image'] ?? "",
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      serial: map['serial'] != null ? int.parse(map['serial'].toString()) : 0,
      sliderLocation: map['slider_location'] ?? "",
      productSlug: map['product_slug'] ?? "",
      createdAt: map['createdAt'] ?? "",
      updatedAt: map['updatedAt'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory SliderModel.fromJson(String source) =>
      SliderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SliderModel(id: $id, badge:$badge, title_one: $titleOne,title_two: $titleTwo, image: $image, status: $status, serial: $serial, slider_location: $sliderLocation, product_slug: $productSlug, created_at: $createdAt, updated_at: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      badge,
      titleTwo,
      titleOne,
      image,
      status,
      serial,
      sliderLocation,
      productSlug,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;
}
