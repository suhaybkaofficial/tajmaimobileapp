import 'dart:convert';

import 'package:equatable/equatable.dart';

class BannerModel extends Equatable {
  final int id;
  final String link;
  final String image;
  final String bannerLocation;
  final String slug;
  final String titleOne;
  final String titleTwo;
  final int status;
  final String badge;

  const BannerModel({
    required this.id,
    required this.link,
    required this.image,
    required this.bannerLocation,
    required this.slug,
    required this.titleOne,
    required this.titleTwo,
    required this.status,
    required this.badge,
  });

  BannerModel copyWith({
    int? id,
    String? link,
    String? image,
    String? bannerLocation,
    String? slug,
    String? titleOne,
    String? titleTwo,
    int? status,
    String? badge,
  }) {
    return BannerModel(
      id: id ?? this.id,
      link: link ?? this.link,
      image: image ?? this.image,
      bannerLocation: bannerLocation ?? this.bannerLocation,
      status: status ?? this.status,
      badge: badge ?? this.badge,
      titleOne: titleOne ?? this.titleOne,
      titleTwo: titleTwo ?? this.titleTwo,
      slug: slug ?? this.slug,
    );
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id']?.toInt() ?? 0,
      link: map['link'] ?? '',
      image: map['image'] ?? '',
      bannerLocation: map['banner_location'],
      status: map['status']!=null ?  int.parse(map['status'].toString()) : 0,
      badge: map['badge'] ?? '',
      titleOne: map['title_one'] ?? '',
      titleTwo: map['title_two'] ?? '',
      slug: map['product_slug'] ?? '',
    );
  }

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SliderBannerModel(id: $id, link: $link, image: $image, banner_location: $bannerLocation)';
  }

  @override
  List<Object> get props => [
        id,
        link,
        image,
        bannerLocation,
        slug,
        titleOne,
        titleTwo,
        status,
        badge,
      ];
}
