import 'dart:convert';

import 'package:equatable/equatable.dart';

class SearchProductModel extends Equatable {
  final String search;
  const SearchProductModel({
    required this.search,
  });

  SearchProductModel copyWith({
    String? search,
  }) {
    return SearchProductModel(
      search: search ?? this.search,
    );
  }

  Map<String, String> toMap() {
    final result = <String, String>{};

    result.addAll({'search': search});

    return result;
  }

  factory SearchProductModel.fromMap(Map<String, dynamic> map) {
    return SearchProductModel(
      search: map['search'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchProductModel.fromJson(String source) =>
      SearchProductModel.fromMap(json.decode(source));

  @override
  String toString() => 'SearchProductModel(search: $search)';

  @override
  List<Object> get props => [search];
}
