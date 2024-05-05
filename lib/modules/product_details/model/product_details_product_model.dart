import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../category/model/category_model.dart';
import '../../home/model/brand_model.dart';
import 'active_variant_model.dart';
import 'avg_review_model.dart';

class ProductDetailsProductModel extends Equatable {
  final int id;
  final String name;
  final String shortName;
  final String slug;
  final String thumbImage;
  final int vendorId;
  final int categoryId;
  final int subCategoryId;
  final int childCategoryId;
  final int brandId;
  final int qty;
  final String shortDescription;
  final String longDescription;
  final String videoLink;
  final String sku;
  final String seoTitle;
  final String seoDescription;
  final double price;
  final double offerPrice;
  final int isFeatured;
  final int status;
  final double averageRating;
  final List<ActiveVariantModel> activeVariantModel;
  final CategoriesModel? category;
  final BrandModel? brand;
  final List<AvgReviewModel> avgReview;

  const ProductDetailsProductModel({
    required this.id,
    required this.name,
    required this.shortName,
    required this.slug,
    required this.thumbImage,
    required this.vendorId,
    required this.categoryId,
    required this.subCategoryId,
    required this.childCategoryId,
    required this.brandId,
    required this.qty,
    required this.shortDescription,
    required this.longDescription,
    required this.videoLink,
    required this.sku,
    required this.seoTitle,
    required this.seoDescription,
    required this.price,
    required this.offerPrice,
    required this.isFeatured,
    required this.status,
    required this.averageRating,
    required this.activeVariantModel,
    required this.category,
    required this.brand,
    required this.avgReview,
  });

  ProductDetailsProductModel copyWith({
    int? id,
    String? name,
    String? shortName,
    String? slug,
    String? thumbImage,
    int? vendorId,
    int? categoryId,
    int? subCategoryId,
    int? childCategoryId,
    int? brandId,
    int? qty,
    String? shortDescription,
    String? longDescription,
    String? videoLink,
    String? sku,
    String? seoTitle,
    String? seoDescription,
    double? price,
    double? offerPrice,
    int? isFeatured,
    int? status,
    double? averageRating,
    List<ActiveVariantModel>? activeVariantModel,
    CategoriesModel? category,
    BrandModel? brand,
    List<AvgReviewModel>? avgReview,
  }) {
    return ProductDetailsProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      slug: slug ?? this.slug,
      thumbImage: thumbImage ?? this.thumbImage,
      vendorId: vendorId ?? this.vendorId,
      categoryId: categoryId ?? this.categoryId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      childCategoryId: childCategoryId ?? this.childCategoryId,
      brandId: brandId ?? this.brandId,
      qty: qty ?? this.qty,
      shortDescription: shortDescription ?? this.shortDescription,
      longDescription: longDescription ?? this.longDescription,
      videoLink: videoLink ?? this.videoLink,
      sku: sku ?? this.sku,
      seoTitle: seoTitle ?? this.seoTitle,
      seoDescription: seoDescription ?? this.seoDescription,
      price: price ?? this.price,
      offerPrice: offerPrice ?? this.offerPrice,
      isFeatured: isFeatured ?? this.isFeatured,
      status: status ?? this.status,
      averageRating: averageRating ?? this.averageRating,
      activeVariantModel: activeVariantModel ?? this.activeVariantModel,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      avgReview: avgReview ?? this.avgReview,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'short_name': shortName,
      'slug': slug,
      'thumb_image': thumbImage,
      'vendor_id': vendorId,
      'category_id': categoryId,
      'sub_category_id': subCategoryId,
      'child_category_id': childCategoryId,
      'brandId': brandId,
      'qty': qty,
      'short_description': shortDescription,
      'long_description': longDescription,
      'video_link': videoLink,
      'sku': sku,
      'seo_title': seoTitle,
      'seo_description': seoDescription,
      'price': price,
      'offer_price': offerPrice,
      'is_featured': isFeatured,
      'status': status,
      'averageRating': averageRating,
      'active_variants': activeVariantModel.map((x) => x.toMap()).toList(),
      'category': category!.toMap(),
      // 'brand': brand!.toMap(),
      'avg_review': avgReview.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductDetailsProductModel.fromMap(Map<String, dynamic> map) {
    return ProductDetailsProductModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      shortName: map['short_name'] ?? '',
      slug: map['slug'] ?? '',
      thumbImage: map['thumb_image'] ?? '',
      vendorId:
          map['vendor_id'] != null ? int.parse(map['vendor_id'].toString()) : 0,
      categoryId: map['category_id'] != null
          ? int.parse(map['category_id'].toString())
          : 0,
      subCategoryId: map['sub_category_id'] != null
          ? int.parse(map['sub_category_id'].toString())
          : 0,
      childCategoryId: map['brchild_category_idand_id'] != null
          ? int.parse(map['child_category_id'].toString())
          : 0,
      brandId:
          map['brand_id'] != null ? int.parse(map['brand_id'].toString()) : 0,
      qty: map['qty'] != null ? int.parse(map['qty'].toString()) : 0,
      shortDescription: map['short_description'] ?? '',
      longDescription: map['long_description'] ?? '',
      videoLink: map['video_link'] ?? '',
      sku: map['sku'] ?? '',
      seoTitle: map['seo_title'] ?? '',
      seoDescription: map['seo_description'] ?? '',
      price: map['price'] != null ? double.parse(map['price'].toString()) : 0,
      offerPrice: map['offer_price'] != null
          ? double.parse(map['offer_price'].toString())
          : 0.0,
      isFeatured: map['is_featured'] != null
          ? int.parse(map['is_featured'].toString())
          : 0,
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      averageRating: map['averageRating'] != null
          ? double.parse(map['averageRating'].toString())
          : 0,
      activeVariantModel: List<ActiveVariantModel>.from(
        (map['active_variants'] as List<dynamic>).map<ActiveVariantModel>(
          (x) => ActiveVariantModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      category: map['category'] != null
          ? CategoriesModel.fromMap(map['category'] as Map<String, dynamic>)
          : null,
      brand: map['brand'] != null
          ? BrandModel.fromMap(map['brand'] as Map<String, dynamic>)
          : null,
      avgReview: map['avg_review'] != null
          ? List<AvgReviewModel>.from(
              (map['avg_review'] as List<dynamic>).map<AvgReviewModel>(
                (x) => AvgReviewModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDetailsProductModel.fromJson(String source) =>
      ProductDetailsProductModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      shortName,
      slug,
      thumbImage,
      vendorId,
      categoryId,
      subCategoryId,
      childCategoryId,
      brandId,
      qty,
      shortDescription,
      longDescription,
      videoLink,
      sku,
      seoTitle,
      seoDescription,
      price,
      offerPrice,
      isFeatured,
      status,
      averageRating,
      activeVariantModel,
      category!,
      brand!,
      avgReview,
    ];
  }
}
