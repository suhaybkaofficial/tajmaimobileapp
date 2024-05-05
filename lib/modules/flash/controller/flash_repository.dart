import 'package:dartz/dartz.dart';
import '/core/error/failure.dart';
import '/modules/flash/model/flash_model.dart';

import '../../../core/data/datasources/remote_data_source.dart';
import '../../../core/error/exception.dart';

abstract class FlashRepository {
  Future<Either<Failure,FlashModel>> getFlashSale();
}

class FlashRepositoryImp extends FlashRepository {

  final RemoteDataSource remoteDataSource;

  FlashRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, FlashModel>> getFlashSale() async{
    try {
      final result = await remoteDataSource.getFlashSale();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
