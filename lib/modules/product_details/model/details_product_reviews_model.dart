import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../authentication/models/user_prfile_model.dart';

class DetailsProductReviewModel extends Equatable {
  final UserProfileModel user;
  final int id;
  final double rating;
  final int status;
  final String review;
  final int userId;
  final String createdAt;
  final String updatedAt;
  final int productId;
  final int productVendorId;

  const DetailsProductReviewModel({
    required this.id,
    required this.rating,
    required this.status,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.productId,
    required this.productVendorId,
    required this.user,
    required this.review,
  });

  DetailsProductReviewModel copyWith({
    int? id,
    double? rating,
    int? status,
    int? userId,
    String? createdAt,
    String? updatedAt,
    int? productId,
    int? productVendorId,
    String? review,
    UserProfileModel? user,
  }) {
    return DetailsProductReviewModel(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      status: status ?? this.status,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      productId: productId ?? this.productId,
      review: review ?? this.review,
      productVendorId: productVendorId ?? this.productVendorId,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'rating': rating});
    result.addAll({'status': status});
    result.addAll({'user_id': userId});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});
    result.addAll({'product_id': productId});
    result.addAll({'review': review});
    result.addAll({'product_vendor_id': productVendorId});
    result.addAll({'user': user.toMap()});

    return result;
  }

  factory DetailsProductReviewModel.fromMap(Map<String, dynamic> map) {
    return DetailsProductReviewModel(
      id: map['id']?.toInt() ?? 0,
      rating:
          map['rating'] != null ? double.parse(map['rating'].toString()) : 0.0,
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      userId: map['user_id'] != null ? int.parse(map['user_id'].toString()) : 0,
      review: map['review'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      productId: map['product_id'] != null
          ? int.parse(map['product_id'].toString())
          : 0,
      productVendorId: map['product_vendor_id'] != null
          ? int.parse(map['product_vendor_id'].toString())
          : 0,
      user: UserProfileModel.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailsProductReviewModel.fromJson(String source) =>
      DetailsProductReviewModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReviewsModel(id: $id, rating: $rating, status: $status, userId: $userId, createdAt: $createdAt, review: $review, updatedAt: $updatedAt, productId: $productId, productVendorId: $productVendorId)';
  }

  @override
  List<Object> get props {
    return [
      id,
      rating,
      status,
      userId,
      createdAt,
      updatedAt,
      productId,
      review,
      productVendorId
    ];
  }
}
