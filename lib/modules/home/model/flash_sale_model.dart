import 'dart:convert';

import 'package:equatable/equatable.dart';

class FlashSaleModel extends Equatable {
  final int id;
  final String title;
  final String homepageImage;
  final String flashsalePageImage;
  final String description;
  final int offer;
  final String endTime;
  final int status;
  final String createdAt;
  final String updatedAt;
  const FlashSaleModel({
    required this.id,
    required this.title,
    required this.homepageImage,
    required this.flashsalePageImage,
    required this.offer,
    required this.endTime,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
  });

  FlashSaleModel copyWith({
    int? id,
    String? title,
    String? homepageImage,
    String? flashsalePageImage,
    int? offer,
    String? endTime,
    int? status,
    String? createdAt,
    String? updatedAt,
    String? description,
  }) {
    return FlashSaleModel(
      id: id ?? this.id,
      title: title ?? this.title,
      homepageImage: homepageImage ?? this.homepageImage,
      flashsalePageImage: flashsalePageImage ?? this.flashsalePageImage,
      offer: offer ?? this.offer,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'homepage_image': homepageImage});
    result.addAll({'flashsale_page_image': flashsalePageImage});
    result.addAll({'offer': offer});
    result.addAll({'end_time': endTime});
    result.addAll({'status': status});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});
    result.addAll({'description': description});
    return result;
  }

  factory FlashSaleModel.fromMap(Map<String, dynamic> map) {
    return FlashSaleModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      homepageImage: map['homepage_image'] ?? '',
      flashsalePageImage: map['flashsale_page_image'] ?? '',
      offer: map['offer'] != null ? int.parse(map['offer'].toString()) : 0,
      endTime: map['end_time'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FlashSaleModel.fromJson(String source) =>
      FlashSaleModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FlashSaleModel(id: $id, title: $title, homepageImage: $homepageImage, flashsalePageImage: $flashsalePageImage, offer: $offer, endTime: $endTime, status: $status, createdAt: $createdAt, updatedAt: $updatedAt,description: $description)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      homepageImage,
      flashsalePageImage,
      offer,
      endTime,
      status,
      createdAt,
      updatedAt,
      description
    ];
  }
}
