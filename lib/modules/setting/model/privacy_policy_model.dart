import 'dart:convert';

import 'package:equatable/equatable.dart';

class PrivacyPolicyAndTermConditionModel extends Equatable {
  final int id;
  final String termsAndCondition;
  final String termsConditionBanner;
  final String privacyBanner;
  final String privacyPolicy;
  final String createdAt;
  final String updatedAt;
  const PrivacyPolicyAndTermConditionModel({
    required this.id,
    required this.termsAndCondition,
    required this.termsConditionBanner,
    required this.privacyBanner,
    required this.privacyPolicy,
    required this.createdAt,
    required this.updatedAt,
  });

  PrivacyPolicyAndTermConditionModel copyWith({
    int? id,
    String? termsAndCondition,
    String? termsConditionBanner,
    String? privacyBanner,
    String? privacyPolicy,
    String? createdAt,
    String? updatedAt,
  }) {
    return PrivacyPolicyAndTermConditionModel(
      id: id ?? this.id,
      termsAndCondition: termsAndCondition ?? this.termsAndCondition,
      termsConditionBanner: termsConditionBanner ?? this.termsConditionBanner,
      privacyBanner: privacyBanner ?? this.privacyBanner,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory PrivacyPolicyAndTermConditionModel.fromMap(Map<String, dynamic> map) {
    return PrivacyPolicyAndTermConditionModel(
      id: map['id']?.toInt() ?? 0,
      termsAndCondition: map['terms_and_condition'] ?? '',
      termsConditionBanner: map['terms_condition_banner'] ?? '',
      privacyBanner: map['privacy_banner'] ?? '',
      privacyPolicy: map['privacy_policy'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  factory PrivacyPolicyAndTermConditionModel.fromJson(String source) =>
      PrivacyPolicyAndTermConditionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PrivacyPolicy(id: $id, termsAndCondition: $termsAndCondition, termsConditionBanner: $termsConditionBanner, privacyBanner: $privacyBanner, privacyPolicy: $privacyPolicy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      termsAndCondition,
      termsConditionBanner,
      privacyBanner,
      privacyPolicy,
      createdAt,
      updatedAt,
    ];
  }
}
