// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class VarientItemModel extends Equatable {
  final int id;
  final String productVariantName;
  final String name;

  final double price;

  const VarientItemModel({
    required this.id,
    required this.productVariantName,
    required this.name,
    required this.price,
  });

  VarientItemModel copyWith({
    int? id,
    String? productVariantName,
    String? name,
    double? price,
  }) {
    return VarientItemModel(
      id: id ?? this.id,
      productVariantName: productVariantName ?? this.productVariantName,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_variant_name': productVariantName,
      'name': name,
      'price': price,
    };
  }

  factory VarientItemModel.fromMap(Map<String, dynamic> map) {
    return VarientItemModel(
      id: map['id'] ?? 0,
      productVariantName: map['product_variant_name'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] != null ? double.parse(map['price'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory VarientItemModel.fromJson(String source) =>
      VarientItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, productVariantName, name, price];
}
