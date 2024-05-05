

import 'dart:convert';

import 'package:equatable/equatable.dart';

class SectionTitle extends Equatable {
  final String key;
  final String? dDefault;
  final String? custom;
  const SectionTitle({
    required this.key,
    required this.dDefault,
    required this.custom,
  });

  SectionTitle copyWith({
    String? key,
    String? dDefault,
    String? custom,
  }) {
    return SectionTitle(
      key: key ?? this.key,
      dDefault: dDefault ?? this.dDefault,
      custom: custom ?? this.custom,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'key': key,
      'default': dDefault,
      'custom': custom,
    };
  }

  factory SectionTitle.fromMap(Map<String, dynamic> map) {
    return SectionTitle(
      key: map['key'] as String,
      dDefault: map['default'] as String,
      custom: map['custom'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SectionTitle.fromJson(String source) => SectionTitle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [key, dDefault!, custom!];
}
