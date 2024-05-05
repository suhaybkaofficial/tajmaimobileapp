import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'delivery_man_cubit.dart';

class DeliveryManStateModel extends Equatable {
  final String firstName;
  final String lastName;
  final String manImage;
  final String idnImage;
  final String email;
  final String manType;
  final String idnType;
  final String idnNumber;
  final String phone;
  final String password;
  bool? showPassword;
  final String confirmPassword;
  bool? showConfirmPassword;
  final DeliveryManState deliveryState;

  DeliveryManStateModel({
    this.firstName = '',
    this.lastName = '',
    this.manImage = '',
    this.idnImage = '',
    this.email = '',
    this.manType = '',
    this.idnType = '',
    this.idnNumber = '',
    this.phone = '',
    this.password = '',
    this.showPassword = true,
    this.confirmPassword = '',
    this.showConfirmPassword = true,
    this.deliveryState = const DeliveryManInitial(),
  });

  DeliveryManStateModel copyWith({
    String? firstName,
    String? lastName,
    String? manImage,
    String? idnImage,
    String? email,
    String? manType,
    String? idnType,
    String? idnNumber,
    String? phone,
    String? password,
    bool? showPassword,
    bool? showConfirmPassword,
    String? confirmPassword,
    DeliveryManState? deliveryState,
  }) {
    return DeliveryManStateModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      manImage: manImage ?? this.manImage,
      idnImage: idnImage ?? this.idnImage,
      manType: manType ?? this.manType,
      idnType: idnType ?? this.idnType,
      idnNumber: idnNumber ?? this.idnNumber,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      deliveryState: deliveryState ?? this.deliveryState,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'fname': firstName,
      'lname': lastName,
      'man_image': manImage,
      'idn_image': idnImage,
      'email': email,
      'man_type': manType,
      'idn_type': idnType,
      'idn_num': idnNumber,
      'phone': phone,
      'password': password,
      'c_password': confirmPassword,
    };
  }

  DeliveryManStateModel clear() {
    return DeliveryManStateModel(
      firstName: '',
      lastName: '',
      manImage: '',
      idnImage: '',
      email: '',
      manType: '',
      idnType: '',
      idnNumber: '',
      phone: '',
      password: '',
      confirmPassword: '',
      deliveryState: const DeliveryManInitial(),
    );
  }

  factory DeliveryManStateModel.fromMap(Map<String, dynamic> map) {
    return DeliveryManStateModel(
      firstName: map['fname'] ?? '',
      lastName: map['lname'] ?? '',
      manImage: map['man_image'] ?? '',
      idnImage: map['idn_image'] ?? '',
      email: map['email'] ?? '',
      manType: map['man_type'] ?? '',
      idnType: map['idn_type'] ?? '',
      idnNumber: map['idn_num'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      confirmPassword: map['c_password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryManStateModel.fromJson(String source) =>
      DeliveryManStateModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      firstName,
      lastName,
      email,
      manType,
      idnType,
      idnNumber,
      phone,
      password,
      showPassword!,
      confirmPassword,
      showConfirmPassword!,
      manImage,
      idnImage,
      deliveryState,
    ];
  }
}
