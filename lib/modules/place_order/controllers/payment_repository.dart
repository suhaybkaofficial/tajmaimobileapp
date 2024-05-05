import 'package:dartz/dartz.dart';

import '../../../core/data/datasources/local_data_source.dart';
import '../../../core/data/datasources/remote_data_source.dart';
import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../model/transaction_response.dart';
import 'payment/payment_service.dart';

abstract class PaymentRepository {
  Future<Either<dynamic, TransactionResponse>> makePayment(
      String amount, String currency);

  Future<Either<Failure, String>> cashOnDelivery(
      Map<String, dynamic> body, String token);

  Future<Either<Failure, String>> payWithPaypal(Uri uri);

  Future<Either<Failure, Map<String, dynamic>>> payWithRazor(Uri uri);

  Future<Either<Failure, String>> paypalSuccess(Uri uri);

  Future<Either<Failure, String>> stripePay(
      String token, Map<String, String> body);

  Future<Either<Failure, String>> bankPay(
      String token, Map<String, String> body);
}

class PaymentRepositoryImp extends PaymentRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  PaymentRepositoryImp(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<dynamic, TransactionResponse>> makePayment(
      String amount, String currency) async {
    late TransactionResponse result;
    try {
      final paymentIntentData =
          await remoteDataSource.createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        result = await PaymentService.paymentSheet(paymentIntentData);
      }

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, String>> cashOnDelivery(
      Map<String, dynamic> body, String token) async {
    try {
      final result = await remoteDataSource.cashOnDeliveryPayment(body, token);
      localDataSource.clearCoupon();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> payWithPaypal(Uri uri) async {
    try {
      final result = await remoteDataSource.payWithPaypal(uri);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> paypalSuccess(Uri uri) async {
    try {
      final result = await remoteDataSource.paypalSuccess(uri);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> stripePay(
    String token,
    Map<String, String> body,
  ) async {
    try {
      final result = await remoteDataSource.stripePay(token, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> payWithRazor(Uri uri) async {
    try {
      final result = await remoteDataSource.payWithRazor(uri);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> bankPay(
      String token, Map<String, String> body) async {
    try {
      final result = await remoteDataSource.bankPay(token, body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
