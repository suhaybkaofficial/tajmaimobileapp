// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SslCommerzStatus extends Equatable {
  final int status;

  const SslCommerzStatus({
    required this.status,
  });

  SslCommerzStatus copyWith({
    int? status,
  }) {
    return SslCommerzStatus(
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
    };
  }

  factory SslCommerzStatus.fromMap(Map<String, dynamic> map) {
    return SslCommerzStatus(
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SslCommerzStatus.fromJson(String source) =>
      SslCommerzStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status];
}
