import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'active_variant_items_model.dart';

class ActiveVariantModel extends Equatable {
  final int id;
  final String name;

  final List<ActiveVariantItemModel> activeVariantsItems;
  const ActiveVariantModel({
    required this.id,
    required this.name,
    required this.activeVariantsItems,
  });

  ActiveVariantModel copyWith({
    int? id,
    String? productId,
    String? name,
    List<ActiveVariantItemModel>? activeVariantsItems,
  }) {
    return ActiveVariantModel(
      id: id ?? this.id,
      name: name ?? this.name,
      activeVariantsItems: activeVariantsItems ?? this.activeVariantsItems,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});

    result.addAll(
        {'active_variant_items': activeVariantsItems.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ActiveVariantModel.fromMap(Map<String, dynamic> map) {
    return ActiveVariantModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      activeVariantsItems: map['active_variant_items'] != null
          ? List<ActiveVariantItemModel>.from(map['active_variant_items']
              ?.map((x) => ActiveVariantItemModel.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ActiveVariantModel.fromJson(String source) =>
      ActiveVariantModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductVariantModel(id: $id, name: $name, active_variant_items: $activeVariantsItems)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      activeVariantsItems,
    ];
  }
}
