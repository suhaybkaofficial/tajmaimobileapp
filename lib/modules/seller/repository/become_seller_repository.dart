import 'package:dartz/dartz.dart';
import 'package:shop_o/core/data/datasources/remote_data_source.dart';
import 'package:shop_o/core/error/failure.dart';

import '../../../core/error/exception.dart';
import '../controller/become_seller_state_model.dart';

abstract class BecomeSellerRequestRepository {
  Future<Either<dynamic, String>> becomeSellerRequest(
      String token, BecomeSellerStateModel body);
}

class BecomeSellerRequestRepositoryImpl
    implements BecomeSellerRequestRepository {
  RemoteDataSource remoteDataSource;

  BecomeSellerRequestRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> becomeSellerRequest(
      String token, BecomeSellerStateModel body) async {
    try {
      final result = await remoteDataSource.becomeSellerRequest(token, body);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }
}
