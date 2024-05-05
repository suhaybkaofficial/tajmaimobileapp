import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';
import '../../category/model/category_model.dart';
import '../../product_details/model/active_variant_model.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;
  final String shortName;
  final String slug;
  final String weight;
  final String thumbImage;
  final int vendorId;
  final int categoryId;
  final int brandId;
  final int qty;
  final String shortDescription;
  final String longDescription;
  final String videoLink;
  final String sku;
  final double price;
  final double offerPrice;
  final int taxId;
  final int isCashDelivery;
  final int isReturn;
  final int isWarranty;
  final int isFeatured;
  final int status;
  final double rating;
  final List<GalleryModel> gallery;
  final CategoriesModel? category;
  final List<ActiveVariantModel> productVariants;

  const ProductModel({
    required this.id,
    required this.name,
    required this.shortName,
    required this.slug,
    required this.weight,
    required this.thumbImage,
    required this.vendorId,
    required this.categoryId,
    required this.brandId,
    required this.qty,
    required this.shortDescription,
    required this.longDescription,
    required this.videoLink,
    required this.sku,
    required this.price,
    required this.offerPrice,
    required this.taxId,
    required this.isCashDelivery,
    required this.isReturn,
    required this.isWarranty,
    required this.isFeatured,
    required this.status,
    required this.gallery,
    required this.category,
    required this.productVariants,
    required this.rating,
  });

  ProductModel copyWith({
    int? id,
    String? name,
    String? shortName,
    String? slug,
    String? weight,
    String? thumbImage,
    int? vendorId,
    int? categoryId,
    int? brandId,
    int? qty,
    String? shortDescription,
    String? longDescription,
    String? videoLink,
    String? sku,
    double? price,
    double? offerPrice,
    int? taxId,
    int? isCashDelivery,
    int? isReturn,
    int? isWarranty,
    int? isFeatured,
    int? status,
    double? rating,
    List<GalleryModel>? gallery,
    CategoriesModel? category,
    List<ActiveVariantModel>? productVariants,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      slug: slug ?? this.slug,
      weight: weight ?? this.weight,
      thumbImage: thumbImage ?? this.thumbImage,
      vendorId: vendorId ?? this.vendorId,
      categoryId: categoryId ?? this.categoryId,
      brandId: brandId ?? this.brandId,
      qty: qty ?? this.qty,
      shortDescription: shortDescription ?? this.shortDescription,
      longDescription: longDescription ?? this.longDescription,
      videoLink: videoLink ?? this.videoLink,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      offerPrice: offerPrice ?? this.offerPrice,
      taxId: taxId ?? this.taxId,
      isCashDelivery: isCashDelivery ?? this.isCashDelivery,
      isReturn: isReturn ?? this.isReturn,
      isWarranty: isWarranty ?? this.isWarranty,
      isFeatured: isFeatured ?? this.isFeatured,
      status: status ?? this.status,
      gallery: gallery ?? this.gallery,
      category: category ?? this.category,
      productVariants: productVariants ?? this.productVariants,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'short_name': shortName});
    result.addAll({'slug': slug});
    result.addAll({'weight': weight});
    result.addAll({'thumb_image': thumbImage});
    result.addAll({'vendor_id': vendorId});
    result.addAll({'category_id': categoryId});
    result.addAll({'brand_id': brandId});
    result.addAll({'qty': qty});
    result.addAll({'short_description': shortDescription});
    result.addAll({'long_description': longDescription});
    result.addAll({'video_link': videoLink});
    result.addAll({'sku': sku});
    result.addAll({'price': price});
    result.addAll({'offer_price': offerPrice});
    result.addAll({'tax_id': taxId});
    result.addAll({'is_cash_delivery': isCashDelivery});
    result.addAll({'is_return': isReturn});
    result.addAll({'is_warranty': isWarranty});
    result.addAll({'is_featured': isFeatured});
    result.addAll({'status': status});
    result.addAll({'gallery': gallery.map((x) => x.toMap()).toList()});
    if (category != null) {
      result.addAll({'category': category!.toMap()});
    }
    result.addAll(
        {'active_variants': productVariants.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      shortName: map['short_name'] ?? '',
      slug: map['slug'] ?? '',
      weight: map['weight'] ?? '',
      thumbImage: map['thumb_image'] ?? '',
      vendorId:
          map['vendor_id'] != null ? int.parse(map['vendor_id'].toString()) : 0,
      categoryId: map['category_id'] != null
          ? int.parse(map['category_id'].toString())
          : 0,
      brandId:
          map['brand_id'] != null ? int.parse(map['brand_id'].toString()) : 0,
      qty: map['qty'] != null ? int.parse(map['qty'].toString()) : 0,
      shortDescription: map['short_description'] ?? '',
      longDescription: map['long_description'] ?? '',
      videoLink: map['video_link'] ?? '',
      sku: map['sku'] ?? '',
      price: map['price'] != null ? double.parse(map['price'].toString()) : 0,
      offerPrice: map['offer_price'] != null
          ? double.parse(map['offer_price'].toString())
          : 0,
      taxId: map['tax_id'] != null ? int.parse(map['tax_id'].toString()) : 0,
      isCashDelivery: map['is_cash_delivery'] != null
          ? int.parse(map['is_cash_delivery'].toString())
          : 0,
      isReturn:
          map['is_return'] != null ? int.parse(map['is_return'].toString()) : 0,
      isWarranty: map['is_warranty'] != null
          ? int.parse(map['is_warranty'].toString())
          : 0,
      isFeatured: map['is_featured'] != null
          ? int.parse(map['is_featured'].toString())
          : 0,
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      rating: Utils.toDouble(map['averageRating']?.toString()),
      gallery: map['gallery'] != null
          ? List<GalleryModel>.from(
              map['gallery']?.map((x) => GalleryModel.fromMap(x)))
          : [],
      category: map['category'] != null
          ? CategoriesModel.fromMap(map['category'])
          : null,
      productVariants: map['active_variants'] != null
          ? List<ActiveVariantModel>.from(
              (map['active_variants'] as List<dynamic>).map<ActiveVariantModel>(
                (x) => ActiveVariantModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, short_name: $shortName, slug: $slug,weight: $weight, thumb_image: $thumbImage, vendor_id: $vendorId, category_id: $categoryId, brand_id: $brandId, qty: $qty, short_description: $shortDescription, long_description: $longDescription, video_link: $videoLink, sku: $sku, price: $price, offer_price: $offerPrice, tax_id: $taxId, is_cash_delivery: $isCashDelivery, is_return: $isReturn, is_warranty: $isWarranty, is_featured: $isFeatured, status: $status, gallery: $gallery, category: $category, active_variants: $productVariants)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      shortName,
      slug,
      weight,
      thumbImage,
      vendorId,
      categoryId,
      brandId,
      qty,
      shortDescription,
      longDescription,
      videoLink,
      sku,
      price,
      offerPrice,
      taxId,
      isCashDelivery,
      isReturn,
      isWarranty,
      isFeatured,
      status,
      gallery,
      productVariants,
    ];
  }
}

class GalleryModel extends Equatable {
  final int id;
  final int productId;
  final String image;
  final int status;
  final String createdAt;
  final String updatedAt;

  const GalleryModel({
    required this.id,
    required this.productId,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  GalleryModel copyWith({
    int? id,
    int? productId,
    String? image,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return GalleryModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      image: image ?? this.image,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'product_id': productId});
    result.addAll({'image': image});
    result.addAll({'status': status});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});

    return result;
  }

  factory GalleryModel.fromMap(Map<String, dynamic> map) {
    return GalleryModel(
      id: map['id']?.toInt() ?? 0,
      productId: map['product_id'] != null
          ? int.parse(map['product_id'].toString())
          : 0,
      image: map['image'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  factory GalleryModel.fromJson(String source) =>
      GalleryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GalleryModel(id: $id, product_id: $productId, image: $image, status: $status, created_at: $createdAt, updated_at: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      productId,
      image,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
