// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/modules/home/model/product_model.dart';

import '../../home/model/flash_sale_model.dart';

class FlashModel extends Equatable {
  final FlashSaleModel flashSale;
  final List<ProductModel> products;
  const FlashModel({
    required this.flashSale,
    required this.products,
  });

  FlashModel copyWith({
    FlashSaleModel? flashSale,
    List<ProductModel>? products,
  }) {
    return FlashModel(
      flashSale: flashSale ?? this.flashSale,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'flashSale': flashSale.toMap(),
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory FlashModel.fromMap(Map<String, dynamic> map) {
    return FlashModel(
      flashSale: FlashSaleModel.fromMap(map['flashSale'] as Map<String,dynamic>),
      products: List<ProductModel>.from((map['products']['data'] as List<dynamic>).map<ProductModel>((x) => ProductModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory FlashModel.fromJson(String source) => FlashModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [flashSale, products];
}
