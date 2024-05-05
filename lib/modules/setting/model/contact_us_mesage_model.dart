import 'dart:convert';

import 'package:equatable/equatable.dart';

class ContactUsMessageModel extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String subject;
  final String message;
  const ContactUsMessageModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.subject,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'phone': phone});
    result.addAll({'subject': subject});
    result.addAll({'message': message});

    return result;
  }

  ContactUsMessageModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? subject,
    String? message,
  }) {
    return ContactUsMessageModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      subject: subject ?? this.subject,
      message: message ?? this.message,
    );
  }

  factory ContactUsMessageModel.fromMap(Map<String, dynamic> map) {
    return ContactUsMessageModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      subject: map['subject'] ?? '',
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactUsMessageModel.fromJson(String source) =>
      ContactUsMessageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ContactUsMessageModel(name: $name, email: $email, phone: $phone, subject: $subject, message: $message)';
  }

  @override
  List<Object> get props => [name, email, phone, subject, message];
}
