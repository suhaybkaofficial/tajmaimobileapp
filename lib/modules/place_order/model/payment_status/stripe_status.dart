// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class StripeStatus extends Equatable {
  final int status;

  const StripeStatus({
    required this.status,
  });

  StripeStatus copyWith({
    int? status,
  }) {
    return StripeStatus(
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
    };
  }

  factory StripeStatus.fromMap(Map<String, dynamic> map) {
    return StripeStatus(
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory StripeStatus.fromJson(String source) =>
      StripeStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status];
}
