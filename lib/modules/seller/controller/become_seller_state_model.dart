import 'package:equatable/equatable.dart';

import '/modules/seller/controller/become_seller_cubit.dart';

class BecomeSellerStateModel extends Equatable {
  final String shopName;
  final String email;
  final String phone;
  final String address;
  final String openAt;
  final String closeAt;
  final String agreeTermsAndCondition;
  final String logo;
  final String bannerImage;
  final BecomeSellerState sellerState;

  const BecomeSellerStateModel({
    this.shopName = '',
    this.email = '',
    this.phone = '',
    this.address = '',
    this.openAt = '',
    this.closeAt = '',
    this.agreeTermsAndCondition = '0',
    this.logo = '',
    this.bannerImage = '',
    this.sellerState = const BecomeSellerInitial(),
  });

  BecomeSellerStateModel copyWith({
    String? shopName,
    String? email,
    String? phone,
    String? address,
    String? openAt,
    String? closeAt,
    String? agreeTermsAndCondition,
    String? logo,
    String? bannerImage,
    BecomeSellerState? sellerState,
  }) {
    return BecomeSellerStateModel(
      shopName: shopName ?? this.shopName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      openAt: openAt ?? this.openAt,
      closeAt: closeAt ?? this.closeAt,
      agreeTermsAndCondition:
          agreeTermsAndCondition ?? this.agreeTermsAndCondition,
      logo: logo ?? this.logo,
      bannerImage: bannerImage ?? this.bannerImage,
      sellerState: sellerState ?? this.sellerState,
    );
  }

  Map<String, String> toMap() {
    return {
      'shop_name': shopName,
      'email': email,
      'phone': phone,
      'address': address,
      'open_at': openAt,
      'closed_at': closeAt,
      'agree_terms_condition': agreeTermsAndCondition,
      //'logo': logo,
      //'banner_image': bannerImage,
    };
  }

  BecomeSellerStateModel clear() {
    return const BecomeSellerStateModel(
      shopName: '',
      email: '',
      phone: '',
      address: '',
      openAt: '',
      closeAt: '',
      agreeTermsAndCondition: '0',
      logo: '',
      bannerImage: '',
      sellerState: BecomeSellerInitial(),
    );
  }

  // factory BecomeSellerStateModel.fromMap(Map<String, dynamic> map) {
  //   return BecomeSellerStateModel(
  //     shopName: map['shopName'] ?? '',
  //     email: map['email'] ?? '',
  //     phone: map['phone'] ?? '',
  //     address: map['address'] ?? '',
  //     openAt: map['openAt'] ?? '',
  //     closeAt: map['closeAt'] ?? '',
  //     agreeTermsAndCondition: map['agreeTermsAndCondition'] ?? '',
  //     logo: map['logo'] ?? '',
  //     bannerImage: map['bannerImage'] ?? '',
  //   );
  // }

  // String toJson() => json.encode(toMap());
  //
  // factory BecomeSellerStateModel.fromJson(String source) => BecomeSellerStateModel.fromMap(json.decode(source));

  // @override
  // String toString() {
  //   return 'BecomeSellerStateModel(shopName: $shopName, email: $email, phone: $phone, address: $address, openAt: $openAt, closeAt: $closeAt, agreeTermsAndCondition: $agreeTermsAndCondition, logo: $logo, bannerImage: $bannerImage, sellerState: $sellerState)';
  // }

  @override
  List<Object> get props {
    return [
      shopName,
      email,
      phone,
      address,
      openAt,
      closeAt,
      agreeTermsAndCondition,
      logo,
      bannerImage,
      sellerState,
    ];
  }
}
