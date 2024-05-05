import 'dart:convert';

import 'package:equatable/equatable.dart';

class SubmitReviewResponseModel extends Equatable {
  final int status;
  final String message;

  const SubmitReviewResponseModel({
    required this.status,
    required this.message,
  });

  SubmitReviewResponseModel copyWith({
    int? status,
    String? message,
  }) {
    return SubmitReviewResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'status': status});
    result.addAll({'message': message});

    return result;
  }

  factory SubmitReviewResponseModel.fromMap(Map<String, dynamic> map) {
    return SubmitReviewResponseModel(
      status: map['status']?.toInt() ?? 0,
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SubmitReviewResponseModel.fromJson(String source) =>
      SubmitReviewResponseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubmitReviewResponseModel(status: $status, message: $message)';
  }

  @override
  List<Object> get props => [status, message];
}
