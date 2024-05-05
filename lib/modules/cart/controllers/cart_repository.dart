import 'package:dartz/dartz.dart';
import '../model/cart_calculation_model.dart';
import '../model/coupon_response_model.dart';
import '../../../core/data/datasources/local_data_source.dart';
import '../../../core/data/datasources/remote_data_source.dart';
import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../model/add_to_cart_model.dart';
import '../model/cart_response_model.dart';
import '../model/checkout_response_model.dart';

abstract class CartRepository {
  Future<Either<Failure, CartResponseModel>> getCartProducts(String token);

  Future<Either<Failure, CheckoutResponseModel>> getCheckoutData(
      String token, String couponCode);

  Future<Either<Failure, String>> removerCartItem(
      String productId, String token);

  Future<Either<Failure, String>> incrementQuantity(
      String productId, String token);

  Future<Either<Failure, String>> decrementQuantity(
      String productId, String token);

  Future<Either<Failure, CouponResponseModel>> applyCoupon(
      String coupon, String token);

  Either<Failure, CouponResponseModel> getAppliedCoupon();

  Future<Either<Failure, String>> addToCart(AddToCartModel dataModel);

  void saveCartCalculation(CartCalculation cartCalculation);

  CartCalculation getCartCalculation();
}

class CartRepositoryImp extends CartRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  CartRepositoryImp(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, CartResponseModel>> getCartProducts(
      String token) async {
    try {
      final result = await remoteDataSource.getCartProducts(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CheckoutResponseModel>> getCheckoutData(
      String token, String couponCode) async {
    try {
      final result = await remoteDataSource.getCheckoutData(token, couponCode);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> removerCartItem(
      String productId, String token) async {
    try {
      final result = await remoteDataSource.removerCartItem(productId, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> incrementQuantity(
      String productId, String token) async {
    try {
      final result = await remoteDataSource.incrementQuantity(productId, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> decrementQuantity(
      String productId, String token) async {
    try {
      final result = await remoteDataSource.decrementQuantity(productId, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, CouponResponseModel>> applyCoupon(
      String coupon, String token) async {
    try {
      final result = await remoteDataSource.applyCoupon(coupon, token);
      localDataSource.cacheCouponResponse(result);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> addToCart(AddToCartModel dataModel) async {
    try {
      final result = await remoteDataSource.addToCart(dataModel);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Either<Failure, CouponResponseModel> getAppliedCoupon() {
    try {
      final result = localDataSource.getCouponResponse();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  void saveCartCalculation(CartCalculation cartCalculation) async {
    try {
      localDataSource.cacheCartCalculation(cartCalculation);
    } on DatabaseException {
      rethrow;
    }
  }

  @override
  CartCalculation getCartCalculation() {
    try {
      return localDataSource.getCartCalculation();
    } catch (e) {
      rethrow;
    }
  }
}
