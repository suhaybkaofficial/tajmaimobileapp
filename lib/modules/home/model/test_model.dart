// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TestModel extends Equatable {
  final int id;
  final String name;
  final String city;
  const TestModel({
    required this.id,
    required this.name,
    required this.city,
  });
  

  TestModel copyWith({
    int? id,
    String? name,
    String? city,
  }) {
    return TestModel(
      id: id ?? this.id,
      name: name ?? this.name,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'city': city,
    };
  }

  factory TestModel.fromMap(Map<String, dynamic> map) {
    return TestModel(
      id: map['id'] as int,
      name: map['name'] as String,
      city: map['city'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TestModel.fromJson(String source) => TestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, city];
}
