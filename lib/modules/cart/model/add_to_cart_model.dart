import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../../product_details/model/active_variant_model.dart';

class AddToCartModel extends Equatable {
  final int quantity;
  final int productId;
  final String image;
  final String slug;
  final String token;
  final Set<ActiveVariantModel> variantItems;
  const AddToCartModel({
    required this.quantity,
    required this.productId,
    required this.image,
    required this.slug,
    required this.token,
    required this.variantItems,
  });

  AddToCartModel copyWith({
    int? quantity,
    int? productId,
    String? image,
    String? slug,
    String? token,
    Set<ActiveVariantModel>? variantItems,
  }) {
    return AddToCartModel(
      quantity: quantity ?? this.quantity,
      productId: productId ?? this.productId,
      image: image ?? this.image,
      slug: slug ?? this.slug,
      token: token ?? this.token,
      variantItems: variantItems ?? this.variantItems,
    );
  }

  Map<String, String> toMap() {
    final result = <String, String>{};

    result.addAll({'quantity': quantity.toString()});
    result.addAll({'product_id': productId.toString()});
    result.addAll({'image': image});
    result.addAll({'slug': slug});
    result.addAll({'token': token});

    variantItems.toList().asMap().forEach((k, element) {
      if (element.activeVariantsItems.isNotEmpty) {
        result.addAll({'variants[$k]': element.id.toString()});
        result.addAll(
          {'items[$k]': element.activeVariantsItems.first.id.toString()},
        );
      }
    });

    return result;
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map) {
    return AddToCartModel(
      quantity: map['quantity']?.toInt() ?? 0,
      productId: map['product_id']?.toInt() ?? 0,
      image: map['image'] ?? '',
      slug: map['slug'] ?? '',
      token: map['token'] ?? '',
      variantItems: const {},
    );
  }

  String toJson() => json.encode(toMap());

  factory AddToCartModel.fromJson(String source) =>
      AddToCartModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddToCartModel(quantity: $quantity, product_id: $productId, image: $image, slug: $slug, token: $token)';
  }

  @override
  List<Object> get props {
    return [
      quantity,
      productId,
      image,
      slug,
      token,
    ];
  }
}
