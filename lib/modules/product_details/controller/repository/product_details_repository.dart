import 'package:dartz/dartz.dart';
import '../../../../core/data/datasources/remote_data_source.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../model/product_details_model.dart';

abstract class ProductDetailsRepository {
  Future<Either<Failure, ProductDetailsModel>> getProductDetails(String slug);
}

class ProductDetailsRepositoryImp extends ProductDetailsRepository {
  final RemoteDataSource remoteDataSource;
  ProductDetailsRepositoryImp({required this.remoteDataSource});
  @override
  Future<Either<Failure, ProductDetailsModel>> getProductDetails(
      String slug) async {
    try {
      final result = await remoteDataSource.getProductDetails(slug);
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
