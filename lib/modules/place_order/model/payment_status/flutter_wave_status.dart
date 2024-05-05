// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class FlutterWaveStatus extends Equatable {
  final int status;

  const FlutterWaveStatus({
    required this.status,
  });

  FlutterWaveStatus copyWith({
    int? status,
  }) {
    return FlutterWaveStatus(
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
    };
  }

  factory FlutterWaveStatus.fromMap(Map<String, dynamic> map) {
    return FlutterWaveStatus(
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory FlutterWaveStatus.fromJson(String source) =>
      FlutterWaveStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status];
}
