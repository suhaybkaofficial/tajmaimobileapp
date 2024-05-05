// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AboutUsModel extends Equatable {
  final int id;
  final String aboutUs;
  final String bannerImage;
  final String createdAt;
  final String updatedAt;
  final String iconOne;
  final String titleOne;
  final String titleTwo;
  final String titleThree;
  final String iconTwo;
  final String iconThree;
  final String descriptionOne;
  final String descriptionTwo;
  final String descriptionThree;

  const AboutUsModel({
    required this.id,
    required this.aboutUs,
    required this.bannerImage,
    required this.createdAt,
    required this.updatedAt,
    required this.iconOne,
    required this.titleOne,
    required this.titleTwo,
    required this.titleThree,
    required this.iconTwo,
    required this.iconThree,
    required this.descriptionOne,
    required this.descriptionTwo,
    required this.descriptionThree,
  });

  AboutUsModel copyWith({
    int? id,
    String? aboutUs,
    String? bannerImage,
    String? createdAt,
    String? updatedAt,
    String? iconOne,
    String? iconTwo,
    String? iconThree,
    String? descriptionOne,
    String? descriptionTwo,
    String? descriptionThree,
    String? titleOne,
    String? titleTwo,
    String? titleThree,
  }) {
    return AboutUsModel(
      id: id ?? this.id,
      aboutUs: aboutUs ?? this.aboutUs,
      bannerImage: bannerImage ?? this.bannerImage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      iconOne: iconOne ?? this.iconOne,
      iconTwo: iconTwo ?? this.iconTwo,
      iconThree: iconThree ?? this.iconThree,
      descriptionOne: descriptionOne ?? this.descriptionOne,
      descriptionTwo: descriptionTwo ?? this.descriptionTwo,
      descriptionThree: descriptionThree ?? this.descriptionThree,
      titleOne: titleOne ?? this.titleOne,
      titleTwo: titleTwo ?? this.titleTwo,
      titleThree: titleThree ?? this.titleThree,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'about_us': aboutUs,
      'banner_image': bannerImage,
      'create_at': createdAt,
      'update_at': updatedAt,
      'iconOne': iconOne,
      'title_one': titleOne,
      'title_two': titleTwo,
      'title_three': titleThree,
      'icon_two': iconTwo,
      'icon_three': iconThree,
      'description': descriptionOne,
      'description_two': descriptionTwo,
      'description_three': descriptionThree,
    };
  }

  factory AboutUsModel.fromMap(Map<String, dynamic> map) {
    return AboutUsModel(
      id: map['id'] ?? 0,
      aboutUs: map['about_us'] ?? '',
      bannerImage: map['banner_image'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      iconOne: map['icon_one'] ?? '',
      titleOne: map['title_one'] ?? '',
      titleTwo: map['title_two'] ?? '',
      titleThree: map['title_three'] ?? '',
      iconTwo: map['icon_two'] ?? '',
      iconThree: map['icon_three'] ?? '',
      descriptionOne: map['description'] ?? '',
      descriptionTwo: map['description_two'] ?? '',
      descriptionThree: map['description_three'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AboutUsModel.fromJson(String source) =>
      AboutUsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AboutUsModel('
        'id: $id, about_us: $aboutUs,'
        ' bannerImage: $bannerImage,'
        ' createdAt: $createdAt, updatedAt: $updatedAt,titleOne: $titleOne,icon:$iconOne,descriptionOne:$descriptionOne,titleTwo: $titleTwo,iconTwo:$iconTwo,descriptionTwo:$descriptionTwo,titleThree: $titleThree,iconThree:$iconThree,descriptionThree:$descriptionThree)';
  }

  @override
  List<Object> get props {
    return [
      id,
      aboutUs,
      bannerImage,
      createdAt,
      updatedAt,
      iconOne,
      titleOne,
      titleTwo,
      titleThree,
      iconTwo,
      iconThree,
      descriptionOne,
      descriptionTwo,
      descriptionThree,
    ];
  }

  @override
  bool get stringify => true;
}
