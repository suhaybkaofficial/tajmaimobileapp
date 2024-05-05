// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'address_model.dart';

class AddressBook extends Equatable {
  final List<AddressModel> addresses;

  const AddressBook({required this.addresses});

  AddressBook copyWith({
    List<AddressModel>? addresses,
  }) {
    return AddressBook(
      addresses: addresses ?? this.addresses,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addresses': addresses.map((x) => x.toMap()).toList(),
    };
  }

  factory AddressBook.fromMap(Map<String, dynamic> map) {
    return AddressBook(
      addresses: List<AddressModel>.from(
        (map['addresses'] as List<dynamic>).map<AddressModel>(
          (x) => AddressModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressBook.fromJson(String source) =>
      AddressBook.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [addresses];
}
