import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../home/model/product_model.dart';

class SearchResponseModel extends Equatable {
  final List<ProductModel> products;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final int from;
  final int to;
  final String prevPageUrl;
  final String? nextPageUrl;
  const SearchResponseModel({
    required this.products,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.from,
    required this.to,
    required this.prevPageUrl,
    required this.nextPageUrl,
  });

  SearchResponseModel copyWith({
    List<ProductModel>? products,
    int? currentPage,
    int? lastPage,
    int? perPage,
    int? total,
    int? from,
    int? to,
    String? prevPageUrl,
    String? nextPageUrl,
  }) {
    return SearchResponseModel(
      products: products ?? this.products,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage ?? this.perPage,
      total: total ?? this.total,
      from: from ?? this.from,
      to: to ?? this.to,
      prevPageUrl: prevPageUrl ?? this.prevPageUrl,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'products': products.map((x) => x.toMap()).toList()});
    result.addAll({'current_page': currentPage});
    result.addAll({'last_page': lastPage});
    result.addAll({'per_page': perPage});
    result.addAll({'total': total});
    result.addAll({'from': from});
    result.addAll({'to': to});
    result.addAll({'prev_page_url': prevPageUrl});
    result.addAll({'next_page_url': nextPageUrl});

    return result;
  }

  factory SearchResponseModel.fromMap(Map<String, dynamic> map) {
    return SearchResponseModel(
      products: map['data'] != null
          ? List<ProductModel>.from(
              map['data']?.map((x) => ProductModel.fromMap(x)))
          : [],
      currentPage: map['current_page'] != null
          ? int.parse(map['current_page'].toString())
          : 0,
      lastPage:
          map['last_page'] != null ? int.parse(map['last_page'].toString()) : 0,
      perPage:
          map['per_page'] != null ? int.parse(map['per_page'].toString()) : 0,
      total: map['total'] != null ? int.parse(map['total'].toString()) : 0,
      from: map['from'] != null ? int.parse(map['from'].toString()) : 0,
      to: map['to'] != null ? int.parse(map['to'].toString()) : 0,
      prevPageUrl: map['prev_page_url'] ?? '',
      nextPageUrl: map['next_page_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchResponseModel.fromJson(String source) =>
      SearchResponseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SearchResponseModel(products: $products, current_page: $currentPage, last_page: $lastPage, per_page: $perPage, total: $total, from: $from, to: $to, prev_page_url: $prevPageUrl, next_page_url: $nextPageUrl)';
  }

  @override
  List<Object> get props {
    return [
      products,
      currentPage,
      lastPage,
      perPage,
      total,
      from,
      to,
      prevPageUrl,
    ];
  }
}
