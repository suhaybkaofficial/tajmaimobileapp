// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CouponResponseModel extends Equatable {
  final int id;
  final String name;
  final String code;
  final int offerType;
  final int discount;
  final int maxQuantity;
  final int minPurchasePrice;
  final String expiredDate;
  final int applyQty;
  final int status;
  final String createdAt;
  final String updatedAt;

  const CouponResponseModel({
    required this.id,
    required this.name,
    required this.code,
    required this.offerType,
    required this.discount,
    required this.maxQuantity,
    required this.minPurchasePrice,
    required this.expiredDate,
    required this.applyQty,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  CouponResponseModel copyWith({
    int? id,
    String? name,
    String? code,
    int? offerType,
    int? discount,
    int? maxQuantity,
    int? minPurchasePrice,
    String? expiredDate,
    int? applyQty,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return CouponResponseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      offerType: offerType ?? this.offerType,
      discount: discount ?? this.discount,
      maxQuantity: maxQuantity ?? this.maxQuantity,
      minPurchasePrice: minPurchasePrice ?? this.minPurchasePrice,
      expiredDate: expiredDate ?? this.expiredDate,
      applyQty: applyQty ?? this.applyQty,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'code': code,
      'offer_type': offerType,
      'discount': discount,
      'max_quantity': maxQuantity,
      'min_purchase_price': minPurchasePrice,
      'expired_date': expiredDate,
      'apply_qty': applyQty,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory CouponResponseModel.fromMap(Map<String, dynamic> map) {
    return CouponResponseModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
      code: map['code'] ?? "",
      offerType: map['offer_type'] != null
          ? int.parse(map['offer_type'].toString())
          : 0,
      discount:
          map['discount'] != null ? int.parse(map['discount'].toString()) : 0,
      maxQuantity: map['max_quantity'] != null
          ? int.parse(map['max_quantity'].toString())
          : 0,
      minPurchasePrice: map['min_purchase_price'] != null
          ? int.parse(map['min_purchase_price'].toString())
          : 0,
      expiredDate: map['expired_date'] ?? "",
      applyQty:
          map['apply_qty'] != null ? int.parse(map['apply_qty'].toString()) : 0,
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? "",
      updatedAt: map['updated_at'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory CouponResponseModel.fromJson(String source) =>
      CouponResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      code,
      offerType,
      discount,
      maxQuantity,
      minPurchasePrice,
      expiredDate,
      applyQty,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
