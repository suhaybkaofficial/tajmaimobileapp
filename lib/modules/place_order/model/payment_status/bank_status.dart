// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class BankStatus extends Equatable {
  final int status;
  final int cashOnDeliveryStatus;
  final String accountInfo;
  // cash_on_delivery_status
  // account_info

  const BankStatus({
    required this.status,
    required this.cashOnDeliveryStatus,
    required this.accountInfo,
  });

  BankStatus copyWith({
    int? status,
    int? cashOnDeliveryStatus,
    String? accountInfo,
  }) {
    return BankStatus(
      status: status ?? this.status,
      cashOnDeliveryStatus: cashOnDeliveryStatus ?? this.cashOnDeliveryStatus,
      accountInfo: accountInfo ?? this.accountInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'cash_on_delivery_status': cashOnDeliveryStatus,
      'account_info': accountInfo,
    };
  }

  factory BankStatus.fromMap(Map<String, dynamic> map) {
    return BankStatus(
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      cashOnDeliveryStatus: map['cash_on_delivery_status'] != null
          ? int.parse(map['cash_on_delivery_status'].toString())
          : 0,
      accountInfo: map['account_info'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BankStatus.fromJson(String source) =>
      BankStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, cashOnDeliveryStatus, accountInfo];
}
