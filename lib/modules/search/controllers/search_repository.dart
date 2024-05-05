import 'package:dartz/dartz.dart';
import '../../../core/data/datasources/remote_data_source.dart';
import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../model/search_response_model.dart';

abstract class SearchRepository {
  Future<Either<Failure, SearchResponseModel>> search(Uri uri);
}

class SearchRepositoryImp extends SearchRepository {
  final RemoteDataSource _remoteDataSource;

  SearchRepositoryImp({
    required RemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, SearchResponseModel>> search(Uri uri) async {
    try {
      final result = await _remoteDataSource.searchProduct(uri);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
