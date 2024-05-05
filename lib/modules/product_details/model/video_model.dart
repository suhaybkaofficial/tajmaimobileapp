import 'dart:convert';

import 'package:equatable/equatable.dart';

class VideoModel extends Equatable {
  final int id;
  final int productId;
  final String videoPath;
  final String videoThumbnail;
  final int status;
  final String createdAt;
  final String updatedAt;

  const VideoModel({
    required this.id,
    required this.productId,
    required this.videoPath,
    required this.videoThumbnail,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  VideoModel copyWith({
    int? id,
    int? productId,
    String? videoPath,
    String? videoThumbnail,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return VideoModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      videoPath: videoPath ?? this.videoPath,
      videoThumbnail: videoThumbnail ?? this.videoThumbnail,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_id': productId,
      'video_path': videoPath,
      'video_thumbnail': videoThumbnail,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] ?? 0,
      productId: map['product_id'] != null
          ? int.parse(map['product_id'].toString())
          : 0,
      videoPath: map['video_path'] ?? '',
      videoThumbnail: map['video_thumbnail'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      productId,
      videoPath,
      videoThumbnail,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
