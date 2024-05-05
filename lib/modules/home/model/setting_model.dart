import 'dart:convert';

import 'package:equatable/equatable.dart';

class SettingModel extends Equatable {
  final String logo;
  final String favicon;
  final String timezone;
  final String defaultPhoneCode;
  final int enableUserRegister;
  final int phoneNumberRequired;
  final int enableMultivendor;
  final String topBarEmail;
  final String topBarPhone;
  final String currencyName;
  final String currencyIcon;
  final String sellerCondition;
  final String themeOne;
  final String themeTwo;

  const SettingModel({
    required this.logo,
    required this.favicon,
    required this.timezone,
    required this.defaultPhoneCode,
    required this.enableUserRegister,
    required this.phoneNumberRequired,
    required this.enableMultivendor,
    required this.topBarEmail,
    required this.topBarPhone,
    required this.currencyName,
    required this.currencyIcon,
    required this.sellerCondition,
    required this.themeOne,
    required this.themeTwo,
  });

  SettingModel copyWith({
    String? logo,
    String? favicon,
    String? timezone,
    String? defaultPhoneCode,
    int? enableUserRegister,
    int? phoneNumberRequired,
    int? enableMultivendor,
    String? topBarEmail,
    String? topBarPhone,
    String? currencyName,
    String? currencyIcon,
    String? sellerCondition,
    String? themeOne,
    String? themeTwo,
  }) {
    return SettingModel(
      logo: logo ?? this.logo,
      favicon: favicon ?? this.favicon,
      timezone: timezone ?? this.timezone,
      defaultPhoneCode: defaultPhoneCode ?? this.defaultPhoneCode,
      enableUserRegister: enableUserRegister ?? this.enableUserRegister,
      phoneNumberRequired: phoneNumberRequired ?? this.phoneNumberRequired,
      enableMultivendor: enableMultivendor ?? this.enableMultivendor,
      topBarEmail: topBarEmail ?? this.topBarEmail,
      topBarPhone: topBarPhone ?? this.topBarPhone,
      currencyName: currencyName ?? this.currencyName,
      currencyIcon: currencyIcon ?? this.currencyIcon,
      sellerCondition: sellerCondition ?? this.sellerCondition,
      themeOne: themeOne ?? this.themeOne,
      themeTwo: themeTwo ?? this.themeTwo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'logo': logo,
      'favicon': favicon,
      'timezone': timezone,
      'default_phone_code': defaultPhoneCode,
      'enable_user_register': enableUserRegister,
      'phone_number_required': phoneNumberRequired,
      'enable_multivendor': enableMultivendor,
      'topbar_email': topBarEmail,
      'topbar_phone': topBarPhone,
      'currency_name': currencyName,
      'currency_icon': currencyIcon,
      'seller_condition': sellerCondition,
      'theme_one': themeOne,
      'theme_two': themeTwo,
    };
  }

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      logo: map['logo'] ?? '',
      favicon: map['favicon'] ?? '',
      defaultPhoneCode: map['default_phone_code'] ?? 'BD',
      timezone: map['timezone'] ?? '',
      enableUserRegister: map['enable_user_register'] != null
          ? int.parse(map['enable_user_register'].toString())
          : 0,
      phoneNumberRequired: map['phone_number_required'] != null
          ? int.parse(map['phone_number_required'].toString())
          : 0,
      enableMultivendor: map['enable_multivendor'] != null
          ? int.parse(map['enable_multivendor'].toString())
          : 0,
      topBarEmail: map['topbar_email'] ?? '',
      topBarPhone: map['topbar_phone'] ?? '',
      currencyName: map['currency_name'] ?? '',
      currencyIcon: map['currency_icon'] ?? '',
      sellerCondition: map['seller_condition'] ?? '',
      themeOne: map['theme_one'] ?? '',
      themeTwo: map['theme_two'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingModel.fromJson(String source) =>
      SettingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      logo,
      favicon,
      timezone,
      defaultPhoneCode,
      enableUserRegister,
      phoneNumberRequired,
      enableMultivendor,
      topBarEmail,
      topBarPhone,
      currencyName,
      currencyIcon,
      sellerCondition,
      themeOne,
      themeTwo,
    ];
  }
}
