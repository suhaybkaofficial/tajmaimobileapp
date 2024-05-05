import 'dart:convert';

import 'package:equatable/equatable.dart';

class CountryModel extends Equatable {
  final int id;
  final String name;
  const CountryModel({
    required this.id,
    required this.name,
  });

  CountryModel copyWith({
    int? id,
    String? name,
  }) {
    return CountryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory CountryModel.fromMap(Map<String, dynamic> map) {
    return CountryModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryModel.fromJson(String source) =>
      CountryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name];
}
