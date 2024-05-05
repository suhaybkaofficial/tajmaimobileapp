import 'dart:convert';

import 'package:equatable/equatable.dart';

class OrderAddressModel extends Equatable {
  final int id;
  final int orderId;
  final String billingName;
  final String billingEmail;
  final String billingPhone;
  final String billingAddress;
  final String billingCountry;
  final String billingState;
  final String billingCity;
  final String billingAddressType;
  final String shippingName;
  final String shippingEmail;
  final String shippingPhone;
  final String shippingAddress;
  final String shippingCountry;
  final String shippingState;
  final String shippingCity;
  final String shippingAddressType;
  final String createdAt;
  final String updatedAt;

  const OrderAddressModel({
    required this.id,
    required this.orderId,
    required this.billingName,
    required this.billingEmail,
    required this.billingPhone,
    required this.billingAddress,
    required this.billingCountry,
    required this.billingState,
    required this.billingCity,
    required this.billingAddressType,
    required this.shippingName,
    required this.shippingEmail,
    required this.shippingPhone,
    required this.shippingAddress,
    required this.shippingCountry,
    required this.shippingState,
    required this.shippingCity,
    required this.shippingAddressType,
    required this.createdAt,
    required this.updatedAt,
  });

  OrderAddressModel copyWith({
    int? id,
    int? orderId,
    String? billingName,
    String? billingEmail,
    String? billingPhone,
    String? billingAddress,
    String? billingCountry,
    String? billingState,
    String? billingCity,
    String? billingAddressType,
    String? shippingName,
    String? shippingEmail,
    String? shippingPhone,
    String? shippingAddress,
    String? shippingCountry,
    String? shippingState,
    String? shippingCity,
    String? shippingAddressType,
    String? createdAt,
    String? updatedAt,
  }) {
    return OrderAddressModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      billingName: billingName ?? this.billingName,
      billingEmail: billingEmail ?? this.billingEmail,
      billingPhone: billingPhone ?? this.billingPhone,
      billingAddress: billingAddress ?? this.billingAddress,
      billingCountry: billingCountry ?? this.billingCountry,
      billingState: billingState ?? this.billingState,
      billingCity: billingCity ?? this.billingCity,
      billingAddressType: billingAddressType ?? this.billingAddressType,
      shippingName: shippingName ?? this.shippingName,
      shippingEmail: shippingEmail ?? this.shippingEmail,
      shippingPhone: shippingPhone ?? this.shippingPhone,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      shippingCountry: shippingCountry ?? this.shippingCountry,
      shippingState: shippingState ?? this.shippingState,
      shippingCity: shippingCity ?? this.shippingCity,
      shippingAddressType: shippingAddressType ?? this.shippingAddressType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order_id': orderId,
      'billing_name': billingName,
      'billing_email': billingEmail,
      'billing_phone': billingPhone,
      'billing_address': billingAddress,
      'billing_country': billingCountry,
      'billing_state': billingState,
      'billing_city': billingCity,
      'billing_address_type': billingAddressType,
      'shipping_name': shippingName,
      'shipping_email': shippingEmail,
      'shipping_phone': shippingPhone,
      'shipping_address': shippingAddress,
      'shipping_country': shippingCountry,
      'shipping_state': shippingState,
      'shipping_city': shippingCity,
      'shipping_address_type': shippingAddressType,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory OrderAddressModel.fromMap(Map<String, dynamic> map) {
    return OrderAddressModel(
      id: map['id'] ?? 0,
      orderId:
          map['order_id'] != null ? int.parse(map['order_id'].toString()) : 0,
      billingName: map['billing_name'] ?? '',
      billingEmail: map['billing_email'] ?? '',
      billingPhone: map['billing_phone'] ?? '',
      billingAddress: map['billing_address'] ?? '',
      billingCountry: map['billing_country'] ?? '',
      billingState: map['billing_state'] ?? '',
      billingCity: map['billing_city'] ?? '',
      billingAddressType: map['billing_address_type'] ?? '',
      shippingName: map['shipping_name'] ?? '',
      shippingEmail: map['shipping_email'] ?? '',
      shippingPhone: map['shipping_phone'] ?? '',
      shippingAddress: map['shipping_address'] ?? '',
      shippingCountry: map['shipping_country'] ?? '',
      shippingState: map['shipping_state'] ?? '',
      shippingCity: map['shipping_city'] ?? '',
      shippingAddressType: map['shipping_address_type'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderAddressModel.fromJson(String source) =>
      OrderAddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      orderId,
      billingName,
      billingEmail,
      billingPhone,
      billingAddress,
      billingCountry,
      billingState,
      billingCity,
      billingAddressType,
      shippingName,
      shippingEmail,
      shippingPhone,
      shippingAddress,
      shippingCountry,
      shippingState,
      shippingCity,
      shippingAddressType,
      createdAt,
      updatedAt,
    ];
  }
}
