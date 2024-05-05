import 'dart:convert';

import 'package:equatable/equatable.dart';

class AvgReviewModel extends Equatable {
  final int id;
  final int productId;
  final int userId;
  final int productVendorId;
  final double review;
  final int status;
  final String createdAt;
  final String updatedAt;

  const AvgReviewModel({
    required this.id,
    required this.productId,
    required this.userId,
    required this.productVendorId,
    required this.review,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  AvgReviewModel copyWith({
    int? id,
    int? productId,
    int? userId,
    int? productVendorId,
    double? review,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return AvgReviewModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      productVendorId: productVendorId ?? this.productVendorId,
      review: review ?? this.review,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'userId': userId,
      'productVendorId': productVendorId,
      'review': review,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory AvgReviewModel.fromMap(Map<String, dynamic> map) {
    return AvgReviewModel(
      id: map['id'] ?? 0,
      productId: map['product_id'] != null
          ? int.parse(map['product_id'].toString())
          : 0,
      userId: map['user_id'] != null ? int.parse(map['user_id'].toString()) : 0,
      productVendorId: map['product_vendor_id'] != null
          ? int.parse(map['product_vendor_id'].toString())
          : 0,
      review:
          map['review'] != null ? double.parse(map['status'].toString()) : 0.0,
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AvgReviewModel.fromJson(String source) =>
      AvgReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      productId,
      userId,
      productVendorId,
      review,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
