// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SellerDto extends Equatable {
  final int shopOwnerId;
  final String shopOwner;
  final String shopName;
  final int shopVendorId;
  final String shopSlug;
  final String shopLogo;
  final int unreadMessage;
  final List<MessagesDto> messages;

  const SellerDto({
    required this.shopOwnerId,
    required this.shopOwner,
    required this.shopName,
    required this.shopVendorId,
    required this.shopSlug,
    required this.shopLogo,
    required this.unreadMessage,
    required this.messages,
  });

  SellerDto copyWith({
    int? shopOwnerId,
    String? shopOwner,
    String? shopName,
    int? shopVendorId,
    String? shopSlug,
    String? shopLogo,
    int? unreadMessage,
    List<MessagesDto>? messages,
  }) {
    return SellerDto(
      shopOwnerId: shopOwnerId ?? this.shopOwnerId,
      shopOwner: shopOwner ?? this.shopOwner,
      shopName: shopName ?? this.shopName,
      shopVendorId: shopVendorId ?? this.shopVendorId,
      shopSlug: shopSlug ?? this.shopSlug,
      shopLogo: shopLogo ?? this.shopLogo,
      unreadMessage: unreadMessage ?? this.unreadMessage,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shop_owner_id': shopOwnerId,
      'shop_owner': shopOwner,
      'shop_name': shopName,
      'shop_or_vendor_id': shopVendorId,
      'shop_slug': shopSlug,
      'shop_logo': shopLogo,
      'unread_message': unreadMessage,
      'messages': messages.map((x) => x.toMap()).toList(),
    };
  }

  factory SellerDto.fromMap(Map<String, dynamic> map) {
    return SellerDto(
      shopOwnerId: map['shop_owner_id'] != null
          ? int.parse(map['shop_owner_id'].toString())
          : 0,
      shopOwner: map['shop_owner'] as String,
      shopName: map['shop_name'] as String,
      shopVendorId: map['shop_or_vendor_id'] != null
          ? int.parse(map['shop_or_vendor_id'].toString())
          : 0,
      shopSlug: map['shop_slug'] as String,
      shopLogo: map['shop_logo'] as String,
      unreadMessage: map['unread_message'] != null
          ? int.parse(map['unread_message'].toString())
          : -1,
      messages: List<MessagesDto>.from(
        (map['messages'] as List<dynamic>).map<MessagesDto>(
          (x) => MessagesDto.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerDto.fromJson(String source) =>
      SellerDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      shopOwnerId,
      shopOwner,
      shopName,
      shopVendorId,
      shopSlug,
      shopLogo,
      unreadMessage,
      messages,
    ];
  }
}

class MessagesDto extends Equatable {
  final int id;
  final int customerId;
  final int sellerId;
  final String message;
  final int productId;
  final int customerReadMsg;
  final int sellerReadMsg;
  final String sendBy;
  final String createdAt;
  final String updatedAt;
  final MessageProduct? product;

  const MessagesDto({
    required this.id,
    required this.customerId,
    required this.sellerId,
    required this.message,
    required this.productId,
    required this.customerReadMsg,
    required this.sellerReadMsg,
    required this.sendBy,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  MessagesDto copyWith({
    int? id,
    int? customerId,
    int? sellerId,
    String? message,
    int? productId,
    int? customerReadMsg,
    int? sellerReadMsg,
    String? sendBy,
    String? createdAt,
    String? updatedAt,
    MessageProduct? product,
  }) {
    return MessagesDto(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      sellerId: sellerId ?? this.sellerId,
      message: message ?? this.message,
      productId: productId ?? this.productId,
      customerReadMsg: customerReadMsg ?? this.customerReadMsg,
      sellerReadMsg: sellerReadMsg ?? this.sellerReadMsg,
      sendBy: sendBy ?? this.sendBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'customer_id': customerId,
      'seller_id': sellerId,
      'message': message,
      'product_id': productId,
      'customer_read_msg': customerReadMsg,
      'seller_read_msg': sellerReadMsg,
      'send_by': sendBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'product': product!.toMap(),
    };
  }

  factory MessagesDto.fromMap(Map<String, dynamic> map) {
    return MessagesDto(
      id: map['id'] as int,
      customerId: map['customer_id'] != null
          ? int.parse(map['customer_id'].toString())
          : 0,
      sellerId:
          map['seller_id'] != null ? int.parse(map['seller_id'].toString()) : 0,
      message: map['message'] ?? "",
      productId: map['product_id'] != null
          ? int.parse(map['product_id'].toString())
          : 0,
      customerReadMsg: map['customer_read_msg'] != null
          ? int.parse(map['customer_read_msg'].toString())
          : 0,
      sellerReadMsg: map['seller_read_msg'] != null
          ? int.parse(map['seller_read_msg'].toString())
          : 0,
      sendBy: map['send_by'] as String,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      product: map['product'] != null
          ? MessageProduct.fromMap(map['product'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessagesDto.fromJson(String source) =>
      MessagesDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      customerId,
      sellerId,
      message,
      productId,
      customerReadMsg,
      sellerReadMsg,
      sendBy,
      createdAt,
      updatedAt,
      // product!,
    ];
  }
}

class MessageProduct extends Equatable {
  final int id;
  final String name;
  final String shortName;
  final String slug;
  final String thumbImage;
  final double averageRating;
  final int totalSold;

  const MessageProduct({
    required this.id,
    required this.name,
    required this.shortName,
    required this.slug,
    required this.thumbImage,
    required this.averageRating,
    required this.totalSold,
  });

  MessageProduct copyWith({
    int? id,
    String? name,
    String? shortName,
    String? slug,
    String? thumbImage,
    double? averageRating,
    int? totalSold,
  }) {
    return MessageProduct(
      id: id ?? this.id,
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      slug: slug ?? this.slug,
      thumbImage: thumbImage ?? this.thumbImage,
      averageRating: averageRating ?? this.averageRating,
      totalSold: totalSold ?? this.totalSold,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'short_name': shortName,
      'slug': slug,
      'thumb_image': thumbImage,
      'averageRating': averageRating,
      'totalSold': totalSold,
    };
  }

  factory MessageProduct.fromMap(Map<String, dynamic> map) {
    return MessageProduct(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      shortName: map['short_name'] ?? '',
      slug: map['slug'] ?? '',
      thumbImage: map['thumb_image'] ?? '',
      averageRating: map['averageRating'] != null
          ? double.parse(map['averageRating'].toString())
          : 0,
      totalSold:
          map['totalSold'] != null ? int.parse(map['totalSold'].toString()) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageProduct.fromJson(String source) =>
      MessageProduct.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      shortName,
      slug,
      thumbImage,
      averageRating,
      totalSold,
    ];
  }
}
