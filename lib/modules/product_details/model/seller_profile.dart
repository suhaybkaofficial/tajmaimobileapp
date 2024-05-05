// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../authentication/models/user_prfile_model.dart';

class SellerInfoProfile extends Equatable {
  final int id;
  final int sellerUserId;
  final double totalAmount;
  final String bannerImage;
  final String logo;
  final String phone;
  final String shopName;
  final String email;
  final String slug;
  final String closeAt;
  final String openAt;
  final String address;
  final int status;
  final int isFeatured;
  final int topRated;
  final String greetingMsg;
  final String createdAt;
  final String updateAt;
  final String averageRating;
  final UserProfileModel? user;

  const SellerInfoProfile({
    required this.id,
    required this.sellerUserId,
    required this.totalAmount,
    required this.bannerImage,
    required this.logo,
    required this.phone,
    required this.shopName,
    required this.email,
    required this.slug,
    required this.closeAt,
    required this.openAt,
    required this.address,
    required this.status,
    required this.isFeatured,
    required this.topRated,
    required this.greetingMsg,
    required this.createdAt,
    required this.updateAt,
    required this.averageRating,
    required this.user,
  });

  SellerInfoProfile copyWith({
    int? id,
    int? sellerUserId,
    double? totalAmount,
    String? bannerImage,
    String? logo,
    String? phone,
    String? shopName,
    String? email,
    String? slug,
    String? closeAt,
    String? openAt,
    String? address,
    int? status,
    int? isFeatured,
    int? topRated,
    String? greetingMsg,
    String? createdAt,
    String? updateAt,
    String? averageRating,
    UserProfileModel? user,
  }) {
    return SellerInfoProfile(
      id: id ?? this.id,
      sellerUserId: sellerUserId ?? this.sellerUserId,
      totalAmount: totalAmount ?? this.totalAmount,
      bannerImage: bannerImage ?? this.bannerImage,
      logo: logo ?? this.logo,
      phone: phone ?? this.phone,
      shopName: shopName ?? this.shopName,
      email: email ?? this.email,
      slug: slug ?? this.slug,
      closeAt: closeAt ?? this.closeAt,
      openAt: openAt ?? this.openAt,
      address: address ?? this.address,
      status: status ?? this.status,
      isFeatured: isFeatured ?? this.isFeatured,
      topRated: topRated ?? this.topRated,
      greetingMsg: greetingMsg ?? this.greetingMsg,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      averageRating: averageRating ?? this.averageRating,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': sellerUserId,
      'total_amount': totalAmount,
      'banner_image': bannerImage,
      'logo': logo,
      'phone': phone,
      'shop_name': shopName,
      'email': email,
      'slug': slug,
      'closed_at': closeAt,
      'open_at': openAt,
      'address': address,
      'status': status,
      'is_featured': isFeatured,
      'top_rated': topRated,
      'greeting_msg': greetingMsg,
      'created_at': createdAt,
      'updated_at': updateAt,
      'averageRating': averageRating,
      'user': user!.toMap(),
    };
  }

  factory SellerInfoProfile.fromMap(Map<String, dynamic> map) {
    return SellerInfoProfile(
      id: map['id'] ?? 0,
      sellerUserId:
          map['user_id'] != null ? int.parse(map['user_id'].toString()) : 0,
      totalAmount: map['total_amount'] != null
          ? double.parse(map['total_amount'].toString())
          : 0.0,
      bannerImage: map['banner_image'] ?? "",
      logo: map['logo'] ?? "",
      phone: map['phone'] ?? "",
      shopName: map['shop_name'] ?? "",
      email: map['email'] ?? "",
      slug: map['slug'] ?? "",
      closeAt: map['closed_at'] ?? "",
      openAt: map['open_at'] ?? "",
      address: map['address'] ?? "",
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      isFeatured: map['is_featured'] != null
          ? int.parse(map['is_featured'].toString())
          : 0,
      topRated:
          map['top_rated'] != null ? int.parse(map['top_rated'].toString()) : 0,
      greetingMsg: map['greeting_msg'] ?? "",
      createdAt: map['created_at'] ?? "",
      updateAt: map['updated_at'] ?? "",
      averageRating: map['averageRating'] ?? "",
      user: map['user'] != null
          ? UserProfileModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerInfoProfile.fromJson(String source) =>
      SellerInfoProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      sellerUserId,
      totalAmount,
      bannerImage,
      logo,
      phone,
      shopName,
      email,
      slug,
      closeAt,
      openAt,
      address,
      status,
      isFeatured,
      topRated,
      greetingMsg,
      createdAt,
      updateAt,
      averageRating,
      user!,
    ];
  }
}
