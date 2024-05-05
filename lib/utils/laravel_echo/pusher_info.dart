// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class PusherInfo extends Equatable {
  final int id;
  final String appId;
  final String appkey;
  final String appSecret;
  final String appCluster;
  const PusherInfo({
    required this.id,
    required this.appId,
    required this.appkey,
    required this.appSecret,
    required this.appCluster,
  });

  PusherInfo copyWith({
    int? id,
    String? appId,
    String? appkey,
    String? appSecret,
    String? appCluster,
  }) {
    return PusherInfo(
      id: id ?? this.id,
      appId: appId ?? this.appId,
      appkey: appkey ?? this.appkey,
      appSecret: appSecret ?? this.appSecret,
      appCluster: appCluster ?? this.appCluster,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'app_id': appId,
      'app_key': appkey,
      'app_secret': appSecret,
      'app_cluster': appCluster,
    };
  }

  factory PusherInfo.fromMap(Map<String, dynamic> map) {
    return PusherInfo(
      id: map['id'] as int,
      appId: map['app_id'] as String,
      appkey: map['app_key'] as String,
      appSecret: map['app_secret'] as String,
      appCluster: map['app_cluster'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PusherInfo.fromJson(String source) =>
      PusherInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      appId,
      appkey,
      appSecret,
      appCluster,
    ];
  }
}
