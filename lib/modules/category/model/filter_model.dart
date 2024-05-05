// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class FilterModelDto extends Equatable {
  final List<int> brands;
  final List<String> variantItems;
  final double minPrice;
  final double maxPrice;
  const FilterModelDto({
    required this.brands,
    required this.variantItems,
    required this.minPrice,
    required this.maxPrice,
  });

  FilterModelDto copyWith({
    List<int>? brands,
    List<String>? variantItems,
    double? minPrice,
    double? maxPrice,
  }) {
    return FilterModelDto(
      brands: brands ?? this.brands,
      variantItems: variantItems ?? this.variantItems,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, String>{};
    // return <String, dynamic>{
    //   'brands': brands,
    //   'variantItems': variantItems,
    //   'min_price': minPrice,
    //   'max_price': maxPrice,

    // };

    brands.toList().asMap().forEach((k, element) {
      if (element != -1) {
        result.addAll({'brands[$k]': element.toString()});
      }
    });

    variantItems.toList().asMap().forEach((k, element) {
      if (element.isNotEmpty) {
        result.addAll({'variantItems[$k]': element.toString()});
      }
    });
    result.addAll({'min_price': minPrice.toString()});
    result.addAll({'max_price': maxPrice.toString()});

    return result;
  }

  factory FilterModelDto.fromMap(Map<String, dynamic> map) {
    return FilterModelDto(
      brands: List<int>.from(map['brands'] as List<int>),
      variantItems: List<String>.from(map['variantItems'] as List<String>),
      minPrice: map['min_price'] ?? 0,
      maxPrice: map['max_price'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterModelDto.fromJson(String source) =>
      FilterModelDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [brands, variantItems, minPrice, maxPrice];
}
