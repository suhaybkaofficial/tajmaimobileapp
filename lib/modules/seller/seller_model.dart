// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../home/model/brand_model.dart';
import '../home/model/product_model.dart';
import '../home/model/home_seller_model.dart';
import '../product_details/model/active_variant_model.dart';

class SellerProductModel extends Equatable {
  final List<ActiveVariantModel> activeVariants;
  final HomeSellerModel singleSellerModel;
  final List<BrandModel> brands;
  final List<ProductModel> products;

  const SellerProductModel({
    required this.activeVariants,
    required this.singleSellerModel,
    required this.brands,
    required this.products,
  });

  SellerProductModel copyWith({
    List<ActiveVariantModel>? activeVariants,
    HomeSellerModel? singleSellerModel,
    List<BrandModel>? brands,
    List<ProductModel>? products,
  }) {
    return SellerProductModel(
      activeVariants: activeVariants ?? this.activeVariants,
      singleSellerModel: singleSellerModel ?? this.singleSellerModel,
      brands: brands ?? this.brands,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'activeVariants': activeVariants.map((x) => x.toMap()).toList(),
      'seller': singleSellerModel.toMap(),
      'brands': brands.map((x) => x.toMap()).toList(),
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory SellerProductModel.fromMap(Map<String, dynamic> map) {
    return SellerProductModel(
      activeVariants: List<ActiveVariantModel>.from(
        (map['activeVariants'] as List<dynamic>).map<ActiveVariantModel>(
          (x) => ActiveVariantModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      singleSellerModel:
          HomeSellerModel.fromMap(map['seller'] as Map<String, dynamic>),
      brands: List<BrandModel>.from(
        (map['brands'] as List<dynamic>).map<BrandModel>(
          (x) => BrandModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      products: List<ProductModel>.from(
        (map['products']['data'] as List<dynamic>).map<ProductModel>(
          (x) => ProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerProductModel.fromJson(String source) =>
      SellerProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props =>
      [activeVariants, singleSellerModel, brands, products];
}
