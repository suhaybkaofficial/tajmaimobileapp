import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'cart_product_model.dart';

class CartResponseModel extends Equatable {
  final List<CartProductModel> cartProducts;

  const CartResponseModel({
    required this.cartProducts,
  });

  CartResponseModel copyWith({
    List<CartProductModel>? cartProducts,
  }) {
    return CartResponseModel(
      cartProducts: cartProducts ?? this.cartProducts,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result
        .addAll({'cartProducts': cartProducts.map((x) => x.toMap()).toList()});

    return result;
  }

  factory CartResponseModel.fromMap(Map<String, dynamic> map) {
    return CartResponseModel(
      cartProducts: List<CartProductModel>.from(
          map['cartProducts']?.map((x) => CartProductModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartResponseModel.fromJson(String source) =>
      CartResponseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartResponseModel(cartProducts: $cartProducts, )';
  }

  @override
  List<Object> get props {
    return [
      cartProducts,
    ];
  }
}
