import 'dart:convert';

import 'package:equatable/equatable.dart';

class Testimonials extends Equatable {
  final int id;
  final String name;
  final String designation;
  final String image;
  final String rating;
  final String comment;
  final int status;
  final String createdAt;
  final String updatedAt;

  const Testimonials({
    required this.id,
    required this.name,
    required this.designation,
    required this.image,
    required this.rating,
    required this.comment,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  Testimonials copyWith({
    int? id,
    String? name,
    String? designation,
    String? image,
    String? rating,
    String? comment,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return Testimonials(
      id: id ?? this.id,
      name: name ?? this.name,
      designation: designation ?? this.designation,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'designation': designation,
      'image': image,
      'rating': rating,
      'comment': comment,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Testimonials.fromMap(Map<String, dynamic> map) {
    return Testimonials(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      designation: map['designation'] ?? '',
      image: map['image'] ?? '',
      rating: map['rating'] ?? '',
      comment: map['comment'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Testimonials.fromJson(String source) =>
      Testimonials.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      designation,
      image,
      rating,
      comment,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
