import 'package:dartz/dartz.dart';

import '/modules/profile/model/address_model.dart';
import '/modules/profile/model/country_model.dart';
import '../../../../core/data/datasources/local_data_source.dart';
import '../../../../core/data/datasources/remote_data_source.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../model/billing_shipping_model.dart';
import '../../model/city_model.dart';
import '../../model/country_state_model.dart';
import '../../model/edit_address_model.dart';
import '../../model/user_info/user_updated_info.dart';
import '../../model/user_with_country_response.dart';
import '../../profile_offer/model/wish_list_model.dart';
import '../change_password/change_password_cubit.dart';
import '../profile_edit/profile_edit_cubit.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserWithCountryResponse>> userProfile(String token);

  Future<Either<Failure, String>> passwordChange(
    ChangePasswordStateModel changePassData,
    String token,
  );

  Future<Either<dynamic, String>> profileUpdate(
    ProfileEditStateModel user,
    String token,
  );
  Future<Either<Failure, UserProfileInfo>> getUserProfileInfo(
    String token,
  );

  Future<Either<Failure, String>> updateProfileInformation(
    String token,
    Map<String, String> dataMap,
  );

  Future<Either<Failure, List<CountryModel>>> countryList(String token);

  Future<Either<Failure, List<CountryStateModel>>> statesByCountryId(
      String countryID, String token);

  Future<Either<Failure, List<CityModel>>> citiesByStateId(
      String stateID, String token);

  Future<Either<Failure, AddressBook>> getAddress(String token);

  Future<Either<dynamic, String>> updateAddress(
      String id, Map<String, String> dataMap, String token);

  Future<Either<Failure, String>> billingUpdate(
    Map<String, String> dataMap,
    String token,
  );

  Future<Either<dynamic, String>> addAddress(
    Map<String, String> dataMap,
    String token,
  );

  Future<Either<Failure, AddressModel>> getSingleAddress(
      String id, String token);

  Future<Either<Failure, EditAddressModel>> editAddress(
      String id, String token);

  Future<Either<Failure, String>> deleteAddress(String id, String token);

  Future<Either<Failure, String>> shippingUpdate(
    Map<String, String> dataMap,
    String token,
  );

  Future<bool> clearUserProfile();

  Future<Either<Failure, List<WishListModel>>> wishList(String token);

  Future<Either<Failure, String>> removeWishList(int id, String token);

  // Future<Either<Failure, String>> removeSingleItem(int itemId,String token);

  Future<Either<Failure, String>> clearWishList(String token);
  Future<Either<Failure, String>> deleteUserAccount(String token);

  Future<Either<Failure, String>> addWishList(int id, String token);
}

class ProfileRepositoryImp extends ProfileRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  ProfileRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserWithCountryResponse>> userProfile(
      String token) async {
    try {
      final result = await remoteDataSource.userProfile(token);
      localDataSource.cacheUserProfile(result.user);
      return Right(result);
    } on ServerException catch (e) {
      if (e.statusCode == 401) localDataSource.clearUserProfile();
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<bool> clearUserProfile() {
    return localDataSource.clearUserProfile();
  }

  @override
  Future<Either<Failure, String>> passwordChange(
    ChangePasswordStateModel changePassData,
    String token,
  ) async {
    try {
      final result =
          await remoteDataSource.passwordChange(changePassData, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> profileUpdate(
    ProfileEditStateModel user,
    String token,
  ) async {
    try {
      final result = await remoteDataSource.profileUpdate(user, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, List<CityModel>>> citiesByStateId(
      String stateID, String token) async {
    try {
      final result = await remoteDataSource.citiesByStateId(stateID, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<CountryStateModel>>> statesByCountryId(
      String countryID, String token) async {
    try {
      final result = await remoteDataSource.statesByCountryId(countryID, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, String>> addAddress(
      Map<String, String> dataMap, String token) async {
    try {
      final result = await remoteDataSource.addAddress(dataMap, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, AddressBook>> getAddress(String token) async {
    try {
      final result = await remoteDataSource.getShipingAndBillingAddress(token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  // ignore: todo
  ///TODO: added below section
  @override
  Future<Either<Failure, UserProfileInfo>> getUserProfileInfo(
      String token) async {
    try {
      final result = await remoteDataSource.getProfileInfo(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure('UPDATED ERROR ${e.message}', e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, String>> updateAddress(
      String id, Map<String, String> dataMap, String token) async {
    try {
      final result = await remoteDataSource.updateAddress(id, dataMap, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  ///below code is added..
  @override
  Future<Either<Failure, String>> updateProfileInformation(
      String token, Map<String, String> dataMap) async {
    try {
      final result =
          await remoteDataSource.updateProfileInformation(dataMap, token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> billingUpdate(
      Map<String, String> dataMap, String token) async {
    try {
      final result = await remoteDataSource.billingUpdate(dataMap, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> shippingUpdate(
      Map<String, String> dataMap, String token) async {
    try {
      final result = await remoteDataSource.shippingUpdate(dataMap, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<WishListModel>>> wishList(String token) async {
    try {
      final result = await remoteDataSource.wishList(token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> removeWishList(int id, String token) async {
    try {
      final result = await remoteDataSource.removeWishList(id, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  //
  // @override
  // Future<Either<Failure, String>> removeSingleItem(
  //     int itemId, String token) async {
  //   try {
  //     final result = await remoteDataSource.removeSingleItem(itemId, token);
  //     return Right(result);
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(e.message, e.statusCode));
  //   }
  // }

  @override
  Future<Either<Failure, String>> clearWishList(String token) async {
    try {
      final result = await remoteDataSource.clearWishList(token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> addWishList(int id, String token) async {
    try {
      final result = await remoteDataSource.addWishList(id, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, AddressModel>> getSingleAddress(
      String id, String token) async {
    try {
      final result = await remoteDataSource.getSingleAddress(id, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, EditAddressModel>> editAddress(
      String id, String token) async {
    try {
      final result = await remoteDataSource.editAddress(id, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> deleteAddress(String id, String token) async {
    try {
      final result = await remoteDataSource.deleteAddress(id, token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<CountryModel>>> countryList(String token) async {
    try {
      final result = await remoteDataSource.getCountryList(token);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> deleteUserAccount(String token) async {
    try {
      final result = await remoteDataSource.deleteUserAccount(token);
      localDataSource.clearUserProfile();
      localDataSource.clearCoupon();
      localDataSource.clearCoupon();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
