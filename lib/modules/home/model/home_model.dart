import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';

import '../../category/model/category_model.dart';
import 'banner_model.dart';
import 'brand_model.dart';
import 'flash_sale_model.dart';
import 'home_category_model.dart';
import 'home_seller_model.dart';
import 'product_model.dart';
import 'section_title_model.dart';
import 'slider_model.dart';

class HomeModel extends Equatable {
  final List<CategoriesModel> popularCategories;
  final List<SectionTitle> sectionTitle;
  final FlashSaleModel flashSale;

  final BannerModel? sliderBannerOne;
  final BannerModel? sliderBannerTwo;
  final BannerModel? flashSaleSidebarBanner;
  final BannerModel? twoColumnBannerOne;
  final BannerModel? twoColumnBannerTwo;
  final BannerModel? singleBannerOne;

  final String? popularCategorySidebarBanner;
  final BannerModel? singleBannerTwo;
  final List<SliderModel> sliders;
  final List<ProductModel> popularCategoryProducts;
  final List<ProductModel> featuredCategoryProducts;
  final List<ProductModel> topRatedProducts;
  final List<ProductModel> newArrivalProducts;
  final List<ProductModel> bestProducts;
  final List<BrandModel> brands;
  final List<HomeSellerModel> sellers;
  final List<HomePageCategoriesModel> homePageCategory;
  final dynamic sliderVisibilty;
  final dynamic popularCategoryVisibilty;
  final dynamic brandVisibility;
  final dynamic topRatedVisibility;
  final dynamic sellerVisibility;
  final dynamic featuredProductVisibility;
  final dynamic newArrivalProductVisibility;
  final dynamic bestProductVisibility;

  const HomeModel({
    required this.popularCategories,
    required this.sectionTitle,
    required this.flashSale,
    required this.sliders,
    required this.featuredCategoryProducts,
    required this.newArrivalProducts,
    required this.topRatedProducts,
    required this.popularCategoryProducts,
    required this.bestProducts,
    required this.brands,
    required this.sellers,
    required this.homePageCategory,
    required this.sliderVisibilty,
    required this.popularCategoryVisibilty,
    required this.brandVisibility,
    required this.topRatedVisibility,
    required this.sellerVisibility,
    required this.featuredProductVisibility,
    required this.newArrivalProductVisibility,
    required this.bestProductVisibility,
    this.singleBannerTwo,
    this.singleBannerOne,
    this.twoColumnBannerTwo,
    this.twoColumnBannerOne,
    this.flashSaleSidebarBanner,
    this.sliderBannerOne,
    this.sliderBannerTwo,
    this.popularCategorySidebarBanner,
  });

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    log(map['featuredProducts'].toString(), name: "test");
    return HomeModel(
      popularCategories: map['popularCategories'] != null
          ? List<CategoriesModel>.from(map['popularCategories']
              .map((x) => CategoriesModel.fromMap(x['category'])))
          : [],
      sectionTitle: map['section_title'] != null
          ? List<SectionTitle>.from(
              map['section_title'].map((x) => SectionTitle.fromMap(x)))
          : [],
      flashSale: FlashSaleModel.fromMap(map['flashSale']),
      sliders: map['sliders'] != null
          ? List<SliderModel>.from(
              map['sliders'].map((x) => SliderModel.fromMap(x)))
          : [],
      featuredCategoryProducts: map['featuredCategoryProducts'] != null
          ? List<ProductModel>.from(map['featuredCategoryProducts']
              .map((x) => ProductModel.fromMap(x)))
          : [],
      newArrivalProducts: map['newArrivalProducts'] != null
          ? List<ProductModel>.from(
              map['newArrivalProducts'].map((x) => ProductModel.fromMap(x)))
          : [],
      topRatedProducts: map['topRatedProducts'] != null
          ? List<ProductModel>.from(
              map['topRatedProducts'].map((x) => ProductModel.fromMap(x)))
          : [],
      bestProducts: map['bestProducts'] != null
          ? List<ProductModel>.from(
              map['bestProducts'].map((x) => ProductModel.fromMap(x)))
          : [],
      popularCategoryProducts: map['popularCategoryProducts'] != null
          ? List<ProductModel>.from(map['popularCategoryProducts']
              .map((x) => ProductModel.fromMap(x)))
          : [],
      brands: map['brands'] != null
          ? List<BrandModel>.from(
              map['brands'].map((x) => BrandModel.fromMap(x)))
          : [],
      sellers: map['sellers'] != null
          ? List<HomeSellerModel>.from(
              map['sellers'].map((x) => HomeSellerModel.fromMap(x)))
          : [],
      homePageCategory: map['homepage_categories'] != null
          ? List<HomePageCategoriesModel>.from(map['homepage_categories']
              .map((x) => HomePageCategoriesModel.fromMap(x)))
          : [],
      singleBannerTwo: map['singleBannerTwo'] != null
          ? BannerModel.fromMap(map['singleBannerTwo'])
          : null,
      singleBannerOne: map['singleBannerOne'] != null
          ? BannerModel.fromMap(map['singleBannerOne'])
          : null,
      twoColumnBannerTwo: map['twoColumnBannerTwo'] != null
          ? BannerModel.fromMap(map['twoColumnBannerTwo'])
          : null,
      twoColumnBannerOne: map['twoColumnBannerOne'] != null
          ? BannerModel.fromMap(map['twoColumnBannerOne'])
          : null,
      flashSaleSidebarBanner: map['flashSaleSidebarBanner'] != null
          ? BannerModel.fromMap(map['flashSaleSidebarBanner'])
          : null,
      popularCategorySidebarBanner: map['popularCategorySidebarBanner'] ?? "",
      sliderVisibilty: map['sliderVisibilty'] ?? false,
      popularCategoryVisibilty: map['popularCategoryVisibilty'] ?? false,
      brandVisibility: map['brandVisibility'] ?? false,
      topRatedVisibility: map['topRatedVisibility'] ?? false,
      sellerVisibility: map['sellerVisibility'] ?? false,
      featuredProductVisibility: map['featuredProductVisibility'] ?? false,
      newArrivalProductVisibility: map['newArrivalProductVisibility'] ?? false,
      bestProductVisibility: map['bestProductVisibility'] ?? false,
    );
  }

  factory HomeModel.fromJson(String source) =>
      HomeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HomeModel(productCategories: $popularCategories, section_title: $sectionTitle, flashSale: $flashSale, sliders: $sliders, flashDealProducts: $featuredCategoryProducts, newProducts: $newArrivalProducts, topProducts: $topRatedProducts, brands: $brands )';
  }

  @override
  List<Object> get props {
    return [
      popularCategories,
      sectionTitle,
      flashSale,
      sliders,
      featuredCategoryProducts,
      newArrivalProducts,
      topRatedProducts,
      brands,
      sellers,
      sliderVisibilty,
      popularCategoryVisibilty,
      brandVisibility,
      topRatedVisibility,
      sellerVisibility,
      featuredProductVisibility,
      newArrivalProductVisibility,
      bestProductVisibility,
    ];
  }
}
