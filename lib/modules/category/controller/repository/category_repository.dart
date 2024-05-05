import 'package:dartz/dartz.dart';
import '../../../home/model/home_category_model.dart';
import '/modules/category/model/filter_model.dart';
import '/modules/category/model/sub_category_model.dart';
import '/modules/home/model/product_model.dart';

import '../../../../core/data/datasources/remote_data_source.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../seller/seller_model.dart';
import '../../model/child_category_model.dart';
import '../../model/product_categories_model.dart';

abstract class CategoryRepository {
  Future<Either<Failure, ProductCategoriesModel>> getCategoryProducts(
      String slug, int page);

  Future<Either<Failure, List<ProductModel>>> getFilterProducts(
      FilterModelDto filterModelDto);

  Future<Either<Failure, List<HomePageCategoriesModel>>> getCategoryList();
  // Future<Either<Failure, List<CategoriesModel>>> getCategoryList();
  Future<Either<Failure, SellerProductModel>> getSellerList(String slug);

  Future<Either<Failure, List<SubCategoryModel>>> getSubCategoryList(String id);

  Future<Either<Failure, List<ProductModel>>> getSubCategoryProducts(
      String slug);

  Future<Either<Failure, List<ChildCategoryModel>>> getChildCategoryList(
      String id);
  Future<Either<Failure, List<ProductModel>>> getBrandProducts(String slug);
}

class CategoryRepositoryImp extends CategoryRepository {
  final RemoteDataSource remoteDataSource;

  CategoryRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, ProductCategoriesModel>> getCategoryProducts(
      String slug, page) async {
    try {
      final result = await remoteDataSource.getCategoryProducts(slug, page);
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<HomePageCategoriesModel>>>
      getCategoryList() async {
    try {
      final result = await remoteDataSource.getCategoryLists();
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, SellerProductModel>> getSellerList(String slug) async {
    try {
      final result = await remoteDataSource.getSellerProductLists(slug);
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<SubCategoryModel>>> getSubCategoryList(
      String id) async {
    try {
      final result = await remoteDataSource.getSubCategoryLists(id);
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<ChildCategoryModel>>> getChildCategoryList(
      String id) async {
    try {
      final result = await remoteDataSource.getChildCategoryLists(id);
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getSubCategoryProducts(
      String slug) async {
    try {
      final result = await remoteDataSource.getSubCategoryProducts(slug);
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getFilterProducts(
      FilterModelDto filterModelDto) async {
    try {
      final result = await remoteDataSource.filterProducts(filterModelDto);
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getBrandProducts(
      String slug) async {
    try {
      final result = await remoteDataSource.getBrandProducts(slug);
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
