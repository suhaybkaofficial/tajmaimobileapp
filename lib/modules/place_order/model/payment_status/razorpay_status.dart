// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class RazorPayStatus extends Equatable {
  final int status;

  const RazorPayStatus({
    required this.status,
  });

  RazorPayStatus copyWith({
    int? status,
  }) {
    return RazorPayStatus(
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
    };
  }

  factory RazorPayStatus.fromMap(Map<String, dynamic> map) {
    return RazorPayStatus(
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RazorPayStatus.fromJson(String source) =>
      RazorPayStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status];
}
