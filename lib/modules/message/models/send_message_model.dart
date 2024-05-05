// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SendMsgModel extends Equatable {
  final String sellerId;
  final String message;
  final String productId;
  const SendMsgModel({
    required this.sellerId,
    required this.message,
    required this.productId,
  });
  

  SendMsgModel copyWith({
    String? sellerId,
    String? message,
    String? productId,
  }) {
    return SendMsgModel(
      sellerId: sellerId ?? this.sellerId,
      message: message ?? this.message,
      productId: productId ?? this.productId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'seller_id': sellerId,
      'message': message,
      'product_id': productId,
    };
  }

  factory SendMsgModel.fromMap(Map<String, dynamic> map) {
    return SendMsgModel(
      sellerId: map['seller_id'] as String,
      message: map['message'] as String,
      productId: map['product_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendMsgModel.fromJson(String source) => SendMsgModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [sellerId, message, productId];
}
