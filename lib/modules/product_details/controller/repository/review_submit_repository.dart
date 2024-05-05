import 'package:dartz/dartz.dart';
import '../../../../core/data/datasources/remote_data_source.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../model/submit_review_response.dart';

abstract class SubmitReviewRepository {
  Future<Either<dynamic, SubmitReviewResponseModel>> submitReview(
      Map<String, dynamic> body,
      {required token});
}

class SubmitReviewRepositoryImp extends SubmitReviewRepository {
  final RemoteDataSource remoteDataSource;
  SubmitReviewRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<dynamic, SubmitReviewResponseModel>> submitReview(
      Map<String, dynamic> body,
      {required token}) async {
    try {
      final result = await remoteDataSource.submitReivew(body, token);
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch(e){
      return Left(InvalidAuthData(e.errors));
    }
  }
}
