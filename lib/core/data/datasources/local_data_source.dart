import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../modules/cart/model/cart_calculation_model.dart';
import '../../../modules/cart/model/coupon_response_model.dart';
import '../../../../core/error/exception.dart';
import '../../../modules/authentication/models/user_login_response_model.dart';
import '../../../modules/authentication/models/user_prfile_model.dart';
import '../../../modules/setting/model/website_setup_model.dart';
import '../../../utils/k_strings.dart';

abstract class LocalDataSource {
  /// Gets the cached [UserLoginResponseModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  UserLoginResponseModel getUserResponseModel();

  Future<bool> cacheUserResponse(UserLoginResponseModel userLoginResponseModel);

  Future<bool> cacheUserProfile(UserProfileModel userProfileModel);

  Future<bool> clearUserProfile();
  Future<bool> clearCoupon();

  bool checkOnBoarding();

  Future<bool> cacheOnBoarding();

  Future<bool> cacheCouponResponse(CouponResponseModel couponResponseModel);

  CouponResponseModel getCouponResponse();

  Future<bool> cacheCartCalculation(CartCalculation value);

  CartCalculation getCartCalculation();

  Future<bool> cacheWebsiteSetting(WebsiteSetupModel result);

  WebsiteSetupModel getWebsiteSetting();



}

class LocalDataSourceImpl implements LocalDataSource {
  final _className = 'LocalDataSourceImpl';
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  UserLoginResponseModel getUserResponseModel() {
    final jsonString =
        sharedPreferences.getString(KStrings.cachedUserResponseKey);
    if (jsonString != null) {
      return UserLoginResponseModel.fromJson(jsonString);
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<bool> cacheUserResponse(
      UserLoginResponseModel userLoginResponseModel) {
    return sharedPreferences.setString(
      KStrings.cachedUserResponseKey,
      userLoginResponseModel.toJson(),
    );
  }

  @override
  Future<bool> cacheUserProfile(UserProfileModel userProfileModel) {
    final user = getUserResponseModel();
    user.user != userProfileModel;
    return cacheUserResponse(user);
  }

  @override
  Future<bool> clearUserProfile() {
    return sharedPreferences.remove(KStrings.cachedUserResponseKey);
  }

  @override
  bool checkOnBoarding() {
    final jsonString = sharedPreferences.getBool(KStrings.cachOnboardingKey);
    if (jsonString != null) {
      return true;
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<bool> cacheOnBoarding() {
    return sharedPreferences.setBool(KStrings.cachOnboardingKey, true);
  }

  @override
  Future<bool> cacheWebsiteSetting(WebsiteSetupModel settingModel) async {
    log(settingModel.toJson(), name: _className);
    return sharedPreferences.setString(
        KStrings.cachedWebSettingKey, settingModel.toJson());
  }

  @override
  WebsiteSetupModel getWebsiteSetting() {
    final jsonString =
        sharedPreferences.getString(KStrings.cachedWebSettingKey);
    log(jsonString.toString(), name: _className);
    if (jsonString != null) {
      return WebsiteSetupModel.fromJson(jsonString);
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<bool> cacheCouponResponse(CouponResponseModel couponResponseModel) {
    return sharedPreferences.setString(
      KStrings.cacheCouponResponse,
      couponResponseModel.toJson(),
    );
  }

  @override
  CouponResponseModel getCouponResponse() {
    final jsonString =
        sharedPreferences.getString(KStrings.cacheCouponResponse);
    if (jsonString != null) {
      return CouponResponseModel.fromJson(jsonString);
    } else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<bool> cacheCartCalculation(CartCalculation value) {
    return sharedPreferences.setString(
        KStrings.cacheCartCalculation, value.toJson());
  }

  @override
  CartCalculation getCartCalculation() {
    final jsonString =
    sharedPreferences.getString(KStrings.cacheCartCalculation);
    if(jsonString !=null){
      return CartCalculation.fromJson(jsonString);
    }else {
      throw const DatabaseException('Not cached yet');
    }
  }

  @override
  Future<bool> clearCoupon() {
    return sharedPreferences.remove(KStrings.cacheCouponResponse);
  }

}
