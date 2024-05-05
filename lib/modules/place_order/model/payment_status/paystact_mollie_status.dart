// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class PayStackAndMollieStatus extends Equatable {
  // final "mollie_status": "1",
  // "paystack_status": "1",
  final int mollieStatus;
  final int payStackStatus;

  const PayStackAndMollieStatus({
    required this.mollieStatus,
    required this.payStackStatus,
  });

  PayStackAndMollieStatus copyWith({
    int? mollieStatus,
    int? payStackStatus,
  }) {
    return PayStackAndMollieStatus(
      mollieStatus: mollieStatus ?? this.mollieStatus,
      payStackStatus: payStackStatus ?? this.payStackStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mollie_status': mollieStatus,
      'paystack_status': payStackStatus,
    };
  }

  factory PayStackAndMollieStatus.fromMap(Map<String, dynamic> map) {
    return PayStackAndMollieStatus(
      mollieStatus: map['mollie_status'] != null
          ? int.parse(map['mollie_status'].toString())
          : 0,
      payStackStatus: map['paystack_status'] != null
          ? int.parse(map['paystack_status'].toString())
          : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PayStackAndMollieStatus.fromJson(String source) =>
      PayStackAndMollieStatus.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [mollieStatus, payStackStatus];
}
