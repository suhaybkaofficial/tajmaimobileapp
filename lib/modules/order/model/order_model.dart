// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/modules/order/model/product_order_model.dart';
import 'order_address_model.dart';

class OrderModel extends Equatable {
  final int id;
  final String orderId;
  final int userId;
  final int status;
  final String message;
  final double totalAmount;
  final int productQty;
  final String paymentMethod;
  final int paymentStatus;
  final String paymentApprovalDate;
  final String shippingMethod;
  final double shippingCost;
  final double couponCoast;
  final int orderStatus;
  final String orderApprovalDate;
  final String orderDeliveredDate;
  final String orderCompletedDate;
  final String orderDeclinedDate;
  final int cashOnDelivery;
  final String additionalInfo;
  final String createdAt;
  final String updatedAt;
  final List<OrderedProductModel> orderProducts;
  final OrderAddressModel? orderAddress;

  const OrderModel({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.status,
    required this.message,
    required this.totalAmount,
    required this.productQty,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.paymentApprovalDate,
    required this.shippingMethod,
    required this.shippingCost,
    required this.couponCoast,
    required this.orderStatus,
    required this.orderApprovalDate,
    required this.orderDeliveredDate,
    required this.orderCompletedDate,
    required this.orderDeclinedDate,
    required this.cashOnDelivery,
    required this.additionalInfo,
    required this.createdAt,
    required this.updatedAt,
    required this.orderProducts,
    required this.orderAddress,
  });

  OrderModel copyWith({
    int? id,
    String? orderId,
    int? userId,
    int? status,
    String? message,
    double? totalAmount,
    int? productQty,
    String? paymentMethod,
    int? paymentStatus,
    String? paymentApprovalDate,
    String? shippingMethod,
    double? shippingCost,
    double? couponCoast,
    int? orderStatus,
    String? orderApprovalDate,
    String? orderDeliveredDate,
    String? orderCompletedDate,
    String? orderDeclinedDate,
    int? cashOnDelivery,
    String? additionalInfo,
    String? createdAt,
    String? updatedAt,
    List<OrderedProductModel>? orderProducts,
    OrderAddressModel? orderAddress,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      status: status ?? this.status,
      message: message ?? this.message,
      userId: userId ?? this.userId,
      totalAmount: totalAmount ?? this.totalAmount,
      productQty: productQty ?? this.productQty,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentApprovalDate: paymentApprovalDate ?? this.paymentApprovalDate,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      shippingCost: shippingCost ?? this.shippingCost,
      couponCoast: couponCoast ?? this.couponCoast,
      orderStatus: orderStatus ?? this.orderStatus,
      orderApprovalDate: orderApprovalDate ?? this.orderApprovalDate,
      orderDeliveredDate: orderDeliveredDate ?? this.orderDeliveredDate,
      orderCompletedDate: orderCompletedDate ?? this.orderCompletedDate,
      orderDeclinedDate: orderDeclinedDate ?? this.orderDeclinedDate,
      cashOnDelivery: cashOnDelivery ?? this.cashOnDelivery,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      orderProducts: orderProducts ?? this.orderProducts,
      orderAddress: orderAddress ?? this.orderAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order_id': orderId,
      'status': status,
      'message': message,
      'user_id': userId,
      'total_amount': totalAmount,
      'product_qty': productQty,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'payment_approval_date': paymentApprovalDate,
      'shipping_method': shippingMethod,
      'shipping_cost': shippingCost,
      'coupon_coast': couponCoast,
      'order_status': orderStatus,
      'order_approval_date': orderApprovalDate,
      'order_delivered_date': orderDeliveredDate,
      'order_completed_date': orderCompletedDate,
      'order_declined_date': orderDeclinedDate,
      'cash_on_delivery': cashOnDelivery,
      'additional_info': additionalInfo,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'order_products': orderProducts,
      'order_address': orderAddress,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? 0,
      orderId: map['order_id'] ?? "",
      userId: map['user_id'] != null ? int.parse(map['user_id'].toString()) : 0,
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      message: map['message'] ?? '',
      totalAmount: map['total_amount'] != null
          ? double.parse(map['total_amount'].toString())
          : 0,
      productQty: map['product_qty'] != null
          ? int.parse(map['product_qty'].toString())
          : 0,
      paymentMethod: map['payment_method'] ?? "",
      paymentStatus: map['payment_status'] != null
          ? int.parse(map['payment_status'].toString())
          : 0,
      paymentApprovalDate: map['payment_approval_date'] ?? "",
      shippingMethod: map['shipping_method'] ?? "",
      shippingCost: map['shipping_cost'] != null
          ? double.parse(map['shipping_cost'].toString())
          : 0,
      couponCoast: map['coupon_coast'] != null
          ? double.parse(map['coupon_coast'].toString())
          : 0,
      orderStatus: map['order_status'] != null
          ? int.parse(map['order_status'].toString())
          : 0,
      orderApprovalDate: map['order_approval_date'] ?? "",
      orderDeliveredDate: map['order_delivered_date'] ?? "",
      orderCompletedDate: map['order_completed_date'] ?? "",
      orderDeclinedDate: map['order_declined_date'] ?? "",
      cashOnDelivery: map['cash_on_delivery'] != null
          ? int.parse(map['cash_on_delivery'].toString())
          : 0,
      additionalInfo: map['additional_info'] ?? "",
      createdAt: map['created_at'] ?? "",
      updatedAt: map['updated_at'] ?? "",
      orderProducts: map['order_products'] != null
          ? List<OrderedProductModel>.from(
              (map['order_products'] as List<dynamic>).map<OrderedProductModel>(
                (x) => OrderedProductModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      orderAddress: map['order_address'] != null
          ? OrderAddressModel.fromMap(map['order_address'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      orderId,
      status,
      message,
      userId,
      totalAmount,
      productQty,
      paymentMethod,
      paymentStatus,
      paymentApprovalDate,
      shippingMethod,
      shippingCost,
      couponCoast,
      orderStatus,
      orderApprovalDate,
      orderDeliveredDate,
      orderCompletedDate,
      orderDeclinedDate,
      cashOnDelivery,
      additionalInfo,
      createdAt,
      updatedAt,
      orderProducts,
    ];
  }
}
