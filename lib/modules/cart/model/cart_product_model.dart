// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/modules/home/model/product_model.dart';

import 'varient_model.dart';

class CartProductModel extends Equatable {
  final int id;
  final int productId;
  final int qty;
  final ProductModel product;

  final List<VarientModel> variants;
  const CartProductModel({
    required this.id,
    required this.productId,
    required this.qty,
    required this.product,
    required this.variants,
  });

  CartProductModel copyWith({
    int? id,
    int? productId,
    int? qty,
    ProductModel? product,
    List<VarientModel>? variants,
  }) {
    return CartProductModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
      product: product ?? this.product,
      variants: variants ?? this.variants,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_id': productId,
      'qty': qty,
      'product': product.toMap(),
      'variants': variants.map((x) => x.toMap()).toList(),
    };
  }

  factory CartProductModel.fromMap(Map<String, dynamic> map) {
    return CartProductModel(
      id: map['id'] as int,
      productId: map['product_id']!=null ? int.parse(map['product_id'].toString()) : 0,
      qty:map['qty']!=null ? int.parse(map['qty'].toString()) : 0,
      product: ProductModel.fromMap(map['product'] as Map<String, dynamic>),
      variants: List<VarientModel>.from(
        (map['variants'] as List<dynamic>).map<VarientModel>(
          (x) => VarientModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartProductModel.fromJson(String source) =>
      CartProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      productId,
      qty,
      product,
      variants,
    ];
  }
}
