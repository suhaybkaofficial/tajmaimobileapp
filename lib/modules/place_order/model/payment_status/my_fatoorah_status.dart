import 'dart:convert';

import 'package:equatable/equatable.dart';

class MyFatoorahStatus extends Equatable {
  final int status;

  const MyFatoorahStatus({
    required this.status,
  });

  MyFatoorahStatus copyWith({
    int? status,
  }) {
    return MyFatoorahStatus(
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
    };
  }

  factory MyFatoorahStatus.fromMap(Map<String, dynamic> map) {
    return MyFatoorahStatus(
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyFatoorahStatus.fromJson(String source) =>
      MyFatoorahStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status];
}
