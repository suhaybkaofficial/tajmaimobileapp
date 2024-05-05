// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'varient_item_model.dart';

class VarientModel extends Equatable {
  final int id;
  final int shoppingCartId;
  final int variantId;
  final int variantItemId;
  final String createdAt;
  final String updatedAt;
  final VarientItemModel? varientItem;

  const VarientModel({
    required this.id,
    required this.shoppingCartId,
    required this.variantId,
    required this.variantItemId,
    required this.createdAt,
    required this.updatedAt,
    required this.varientItem,
  });

  VarientModel copyWith({
    int? id,
    int? shoppingCartId,
    int? variantId,
    int? variantItemId,
    String? createdAt,
    String? updatedAt,
    VarientItemModel? varientItem,
  }) {
    return VarientModel(
      id: id ?? this.id,
      shoppingCartId: shoppingCartId ?? this.shoppingCartId,
      variantId: variantId ?? this.variantId,
      variantItemId: variantItemId ?? this.variantItemId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      varientItem: varientItem ?? this.varientItem,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'shopping_cart_id': shoppingCartId,
      'variant_id': variantId,
      'variant_item_id': variantItemId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'variant_item': varientItem,
    };
  }

  factory VarientModel.fromMap(Map<String, dynamic> map) {
    return VarientModel(
      id: map['id'] as int,
      shoppingCartId: map['shopping_cart_id'] != null
          ? int.parse(map['shopping_cart_id'].toString())
          : 0,
      variantId: map['variant_id'] != null
          ? int.parse(map['variant_id'].toString())
          : 0,
      variantItemId: map['variant_item_id'] != null
          ? int.parse(map['variant_item_id'].toString())
          : 0,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
      varientItem: map['variant_item'] != null
          ? VarientItemModel.fromMap(
              map['variant_item'] as Map<String, dynamic>)
          : null,
      //VarientItemModel.fromMap(map['variant_item'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory VarientModel.fromJson(String source) =>
      VarientModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      shoppingCartId,
      variantId,
      variantItemId,
      createdAt,
      updatedAt,
      //varientItem!,
    ];
  }
}
