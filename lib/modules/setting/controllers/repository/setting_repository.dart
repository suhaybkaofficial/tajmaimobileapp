/*
import 'package:dartz/dartz.dart';
import '../../../../core/data/datasources/remote_data_source.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../model/all_about_model.dart';
import '../../model/contact_us_mesage_model.dart';
import '../../model/contact_us_mode.dart';
import '../../model/faq_model.dart';
import '../../model/privacy_policy_model.dart';

abstract class SettingRepository {
  Future<Either<Failure, AboutInformationModel>> getAboutUs();

  Future<Either<Failure, List<FaqModel>>> getFaqList();

  Future<Either<Failure, PrivacyPolicyAndTermConditionModel>>
      getPrivacyPolicy();

  Future<Either<Failure, PrivacyPolicyAndTermConditionModel>>
      getTermsAndCondition();

  Future<Either<Failure, ContactUsModel>> getContactUsContent();

  Future<Either<Failure, bool>> getContactUsMessageSend(
      ContactUsMessageModel body);
}

class SettingRepositoryImp extends SettingRepository {
  final RemoteDataSource remoteDataSource;

  SettingRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, bool>> getContactUsMessageSend(
      ContactUsMessageModel body) async {
    try {
      final result = await remoteDataSource.getContactUsMessageSend(body);
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ContactUsModel>> getContactUsContent() async {
    try {
      final result = await remoteDataSource.getContactUsContent();
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, AboutInformationModel>> getAboutUs() async {
    try {
      final result = await remoteDataSource.getAboutUsData();
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<FaqModel>>> getFaqList() async {
    try {
      final result = await remoteDataSource.getFaqList();
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, PrivacyPolicyAndTermConditionModel>>
      getPrivacyPolicy() async {
    try {
      final result = await remoteDataSource.getPrivacyPolicy();
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, PrivacyPolicyAndTermConditionModel>>
      getTermsAndCondition() async {
    try {
      final result = await remoteDataSource.getTermsAndCondition();
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
*/

import 'package:dartz/dartz.dart';
import '../../../../core/data/datasources/remote_data_source.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../model/all_about_model.dart';
import '../../model/contact_us_mesage_model.dart';
import '../../model/contact_us_mode.dart';
import '../../model/faq_model.dart';
import '../../model/privacy_policy_model.dart';

abstract class SettingRepository {
  Future<Either<Failure, AboutInformationModel>> getAboutUs();

  Future<Either<Failure, List<FaqModel>>> getFaqList();

  Future<Either<Failure, PrivacyPolicyAndTermConditionModel>>
  getPrivacyPolicy();

  Future<Either<Failure, PrivacyPolicyAndTermConditionModel>>
  getTermsAndCondition();

  Future<Either<Failure, ContactUsModel>> getContactUsContent();

  Future<Either<dynamic, bool>> getContactUsMessageSend(
      ContactUsMessageModel body);
}

class SettingRepositoryImp extends SettingRepository {
  final RemoteDataSource remoteDataSource;

  SettingRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<dynamic, bool>> getContactUsMessageSend(
      ContactUsMessageModel body) async {
    try {
      final result = await remoteDataSource.getContactUsMessageSend(body);
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message, e.statusCode));
    }on InvalidAuthData catch (e){
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, ContactUsModel>> getContactUsContent() async {
    try {
      final result = await remoteDataSource.getContactUsContent();
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, AboutInformationModel>> getAboutUs() async {
    try {
      final result = await remoteDataSource.getAboutUsData();
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<FaqModel>>> getFaqList() async {
    try {
      final result = await remoteDataSource.getFaqList();
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, PrivacyPolicyAndTermConditionModel>>
  getPrivacyPolicy() async {
    try {
      final result = await remoteDataSource.getPrivacyPolicy();
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, PrivacyPolicyAndTermConditionModel>>
  getTermsAndCondition() async {
    try {
      final result = await remoteDataSource.getTermsAndCondition();
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
