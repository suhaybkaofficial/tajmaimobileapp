// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CartCalculation extends Equatable {
  final double subTotal;
  final String coupon;
  final double total;
  const CartCalculation({
    required this.subTotal,
    required this.coupon,
    required this.total,
  });

  CartCalculation copyWith({
    double? subTotal,
    String? coupon,
    double? total,
  }) {
    return CartCalculation(
      subTotal: subTotal ?? this.subTotal,
      coupon: coupon ?? this.coupon,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subTotal': subTotal,
      'coupon': coupon,
      'total': total,
    };
  }

  factory CartCalculation.fromMap(Map<String, dynamic> map) {
    return CartCalculation(
      subTotal: map['subTotal'] ?? "",
      coupon: map['coupon'] ?? "",
      total: map['total'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory CartCalculation.fromJson(String source) =>
      CartCalculation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [subTotal, coupon, total];
}
