// import 'dart:convert';

// import 'package:equatable/equatable.dart';

// class ShippingMethodModel extends Equatable {
//   final int id;
//   final String title;
//   final String fee;
//   final String isFree;
//   final String minimumOrder;
//   final String status;
//   final String description;
//   final String createdAt;
//   final String updatedAt;
//   const ShippingMethodModel({
//     required this.id,
//     required this.title,
//     required this.fee,
//     required this.isFree,
//     required this.minimumOrder,
//     required this.status,
//     required this.description,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   ShippingMethodModel copyWith({
//     int? id,
//     String? title,
//     String? fee,
//     String? isFree,
//     String? minimumOrder,
//     String? status,
//     String? description,
//     String? createdAt,
//     String? updatedAt,
//   }) {
//     return ShippingMethodModel(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       fee: fee ?? this.fee,
//       isFree: isFree ?? this.isFree,
//       minimumOrder: minimumOrder ?? this.minimumOrder,
//       status: status ?? this.status,
//       description: description ?? this.description,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     final result = <String, dynamic>{};

//     result.addAll({'id': id});
//     result.addAll({'title': title});
//     result.addAll({'fee': fee});
//     result.addAll({'is_free': isFree});
//     result.addAll({'minimum_order': minimumOrder});
//     result.addAll({'status': status});
//     result.addAll({'description': description});
//     result.addAll({'created_at': createdAt});
//     result.addAll({'updated_at': updatedAt});

//     return result;
//   }

//   factory ShippingMethodModel.fromMap(Map<String, dynamic> map) {
//     return ShippingMethodModel(
//       id: map['id']?.toInt() ?? 0,
//       title: map['title'] ?? '',
//       fee: map['fee'] ?? '',
//       isFree: map['is_free'] ?? '',
//       minimumOrder: map['minimum_order'] ?? '',
//       status: map['status'] ?? '',
//       description: map['description'] ?? '',
//       createdAt: map['created_at'] ?? '',
//       updatedAt: map['updated_at'] ?? '',
//     );

    
//   }

//   String toJson() => json.encode(toMap());

//   factory ShippingMethodModel.fromJson(String source) =>
//       ShippingMethodModel.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'ShippingMethodModel(id: $id, title: $title, fee: $fee, is_free: $isFree, minimum_order: $minimumOrder, status: $status, description: $description, created_at: $createdAt, updated_at: $updatedAt)';
//   }

//   @override
//   List<Object> get props {
//     return [
//       id,
//       title,
//       fee,
//       isFree,
//       minimumOrder,
//       status,
//       description,
//       createdAt,
//       updatedAt,
//     ];
//   }
// }
