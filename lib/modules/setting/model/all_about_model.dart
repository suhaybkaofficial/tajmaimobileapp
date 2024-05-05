// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'about_us_model.dart';
import 'services_model.dart';
import 'testimonials_model.dart';

class AboutInformationModel extends Equatable {
  final AboutUsModel aboutUsModel;
  final List<Testimonials> testimonials;
  final List<Services> service;

  const AboutInformationModel({
    required this.aboutUsModel,
    required this.testimonials,
    required this.service,
  });

  @override
  List<Object> get props => [aboutUsModel, testimonials, service];

  AboutInformationModel copyWith({
    AboutUsModel? aboutUsModel,
    List<Testimonials>? testimonials,
    List<Services>? service,
  }) {
    return AboutInformationModel(
      aboutUsModel: aboutUsModel ?? this.aboutUsModel,
      testimonials: testimonials ?? this.testimonials,
      service: service ?? this.service,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'aboutUs': aboutUsModel.toMap(),
      'testimonials': testimonials.map((x) => x.toMap()).toList(),
      'services': service.map((x) => x.toMap()).toList(),
    };
  }

  factory AboutInformationModel.fromMap(Map<String, dynamic> map) {
    return AboutInformationModel(
      aboutUsModel:
          AboutUsModel.fromMap(map['aboutUs'] as Map<String, dynamic>),
      testimonials: List<Testimonials>.from(
        (map['testimonials'] as List<dynamic>).map<Testimonials>(
          (x) => Testimonials.fromMap(x as Map<String, dynamic>),
        ),
      ),
      service: List<Services>.from(
        (map['services'] as List<dynamic>).map<Services>(
          (x) => Services.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AboutInformationModel.fromJson(String source) =>
      AboutInformationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
