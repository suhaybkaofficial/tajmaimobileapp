import 'dart:convert';

import 'package:equatable/equatable.dart';

class HomeSellerModel extends Equatable {
  final int id;
  final String bannerImage;
  final String logo;
  final String shopName;
  final String slug;
  final String openAt;
  final String closedAt;
  final String address;
  final String email;
  final String phone;
  final String seoDescription;
  final String seoTitle;
  final double averageRating;

  const HomeSellerModel({
    required this.id,
    required this.bannerImage,
    required this.logo,
    required this.shopName,
    required this.slug,
    required this.openAt,
    required this.closedAt,
    required this.address,
    required this.email,
    required this.phone,
    required this.seoDescription,
    required this.seoTitle,
    required this.averageRating,
  });

  HomeSellerModel copyWith({
    int? id,
    String? bannerImage,
    String? logo,
    String? shopName,
    String? slug,
    String? openAt,
    String? closedAt,
    String? address,
    String? email,
    String? phone,
    String? seoDescription,
    String? seoTitle,
    double? averageRating,
  }) {
    return HomeSellerModel(
      id: id ?? this.id,
      bannerImage: bannerImage ?? this.bannerImage,
      logo: logo ?? this.logo,
      shopName: shopName ?? this.shopName,
      slug: slug ?? this.slug,
      openAt: openAt ?? this.openAt,
      closedAt: closedAt ?? this.closedAt,
      address: address ?? this.address,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      seoDescription: seoDescription ?? this.seoDescription,
      seoTitle: seoTitle ?? this.seoTitle,
      averageRating: averageRating ?? this.averageRating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'banner_image': bannerImage,
      'logo': logo,
      'shop_name': shopName,
      'slug': slug,
      'open_at': openAt,
      'closed_at': closedAt,
      'address': address,
      'email': email,
      'phone': phone,
      'seo_description': seoDescription,
      'seo_title': seoTitle,
      'averageRating': averageRating,
    };
  }

  factory HomeSellerModel.fromMap(Map<String, dynamic> map) {
    return HomeSellerModel(
      id: map['id'] ?? 0,
      bannerImage: map['banner_image'] ?? '',
      logo: map['logo'] ?? '',
      shopName: map['shop_name'] ?? '',
      slug: map['slug'] ?? '',
      openAt: map['open_at'] ?? '',
      closedAt: map['closed_at'] ?? '',
      address: map['address'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      seoDescription: map['seo_description'] ?? '',
      seoTitle: map['seo_title'] ?? '',
      averageRating: map['averageRating'] != null ? double.parse(map['averageRating'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeSellerModel.fromJson(String source) =>
      HomeSellerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      bannerImage,
      logo,
      shopName,
      slug,
      openAt,
      closedAt,
      address,
      email,
      phone,
      seoDescription,
      seoTitle,
      averageRating,
    ];
  }
}
