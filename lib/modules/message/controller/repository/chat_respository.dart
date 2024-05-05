import 'package:dartz/dartz.dart';
import '../../../../core/data/datasources/remote_data_source.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../models/send_message_response_dto.dart';

import '../../models/seller_messages_dto.dart';

abstract class BaseChatRepository {
  Future<Either<Failure, List<SellerDto>>> getChats(String token);

  Future<Either<Failure, SendMessageResponseDto>> createChat(
      Map<String, dynamic> request, String token);

  // Future<AppResponse<ChatEntity?>> getSingleChat(int chatId);
}

class ChatRepository extends BaseChatRepository {
  final RemoteDataSource remoteDataSource;

  ChatRepository({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, SendMessageResponseDto>> createChat(
      Map<String, dynamic> request, String token) async {
    try {
      final result = await remoteDataSource.sendMessageToSeller(request, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<SellerDto>>> getChats(String token) async {
    try {
      final result = await remoteDataSource.getAllCharts(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

//   @override
//   Future<AppResponse<ChatEntity?>> getSingleChat(int chatId) async {

//   }
}
