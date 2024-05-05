part of 'profile_edit_cubit.dart';

class ProfileEditStateModel extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String countryCode;

  // final String zipCode;
  final String address;
  final String image;
  final String country;
  final String state;
  final String city;
  final ProfileEditState stateStatus;

  const ProfileEditStateModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.countryCode,
    // required this.zipCode,
    required this.address,
    required this.image,
    required this.country,
    required this.state,
    required this.city,
    required this.stateStatus,
  });

  factory ProfileEditStateModel.init(UserProfileModel user) {
    return ProfileEditStateModel(
      address: user.address ?? '',
      city: user.cityId.toString(),
      email: user.email,
      country: user.countryId.toString(),
      state: user.stateId.toString(),
      countryCode: '',
      image: '',
      name: user.name,
      phone: user.phone ?? '',
      // zipCode: user.zipCode ?? '',
      stateStatus: const ProfileEditStateInitial(),
    );
  }

  ProfileEditStateModel copyWith({
    String? name,
    String? phone,
    String? phoneCode,
    String? zipCode,
    String? address,
    String? image,
    String? country,
    String? state,
    String? city,
    String? email,
    ProfileEditState? stateStatus,
  }) {
    return ProfileEditStateModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      countryCode: phoneCode ?? countryCode,
      // zipCode: zipCode ?? this.zipCode,
      address: address ?? this.address,
      image: image ?? this.image,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      stateStatus: stateStatus ?? this.stateStatus,
    );
  }

  Map<String, String> toMap() {
    final result = <String, String>{};

    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'phone': countryCode + phone});
    // result.addAll({'zip_code': zipCode});
    result.addAll({'address': address});
    // result.addAll({'image': image});
    result.addAll({'country': country});
    result.addAll({'state': state});
    result.addAll({'city': city});

    return result;
  }

  factory ProfileEditStateModel.fromMap(Map<String, dynamic> map) {
    return ProfileEditStateModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      countryCode: map['countryCode'] ?? '',
      // zipCode: map['zip_code'] ?? '',
      address: map['address'] ?? '',
      image: map['image'] ?? '',
      country: map['country'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      stateStatus: const ProfileEditStateInitial(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileEditStateModel.fromJson(String source) =>
      ProfileEditStateModel.fromMap(json.decode(source));

  // zip_code: $zipCode,
  @override
  String toString() {
    return 'ProfiltEditStateModel(name: $name, email: $email, phone: $phone, countryCode: $countryCode, address: $address, image: $image, country: $country, state: $state, city: $city, status: $stateStatus)';
  }

  @override
  List<Object> get props {
    return [
      name,
      phone,
      countryCode,
      // zipCode,
      address,
      image,
      country,
      state,
      city,
      stateStatus,
      stateStatus,
    ];
  }
}

abstract class ProfileEditState extends Equatable {
  const ProfileEditState();

  @override
  List<Object> get props => [];
}

class ProfileEditStateInitial extends ProfileEditState {
  const ProfileEditStateInitial();
}

class ProfileEditStateLoading extends ProfileEditState {
  const ProfileEditStateLoading();
}

class ProfileEditStateLoaded extends ProfileEditState {
  final String message;

  const ProfileEditStateLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileEditFormValidState extends ProfileEditState {
  final Errors errors;

  const ProfileEditFormValidState(this.errors);

  @override
  List<Object> get props => [errors];
}

class ProfileEditStateError extends ProfileEditState {
  final String message;
  final int statusCode;

  const ProfileEditStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
