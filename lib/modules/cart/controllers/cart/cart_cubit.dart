import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../authentication/controller/login/login_bloc.dart';
import '../../model/cart_calculation_model.dart';
import '../../model/cart_response_model.dart';
import '../../model/coupon_response_model.dart';
import '../cart_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _cartRepository;

  final LoginBloc _loginBloc;

  int cartCount = 0;

  CartCubit({
    required LoginBloc loginBloc,
    required CartRepository cartRepository,
  })  : _cartRepository = cartRepository,
        _loginBloc = loginBloc,
        super(const CartStateInitial()) {
    getCoupon();
  }

  CartResponseModel? cartResponseModel;
  CouponResponseModel? couponResponseModel;
  String? incDecMessage;

  Future<void> getCartProducts() async {
    if (_loginBloc.userInfo == null) {
      emit(const CartStateError("Please login first", 401));
      return;
    }

    emit(const CartStateLoading());

    final result =
        await _cartRepository.getCartProducts(_loginBloc.userInfo!.accessToken);

    result.fold(
      (failure) {
        emit(CartStateError(failure.message, failure.statusCode));
      },
      (successData) {
        cartResponseModel = successData;
        cartCount = cartResponseModel!.cartProducts.length;
        emit(CartStateLoaded(successData));
        // cartCalculation(successData);
      },
    );
  }

  bool isExistInCart(int id) {

      for (var e in cartResponseModel!.cartProducts) {
        if (e.product.id == id) {
          return true;
        }
      }

    return false;
  }

  Future<Either<Failure, String>> removerCartItem(String productId) async {
    if (_loginBloc.userInfo == null) {
      emit(const CartStateError("Please login first", 401));
      return left(const ServerFailure("Please login first", 1000));
    }

    emit(const CartStateDecIncrementLoading());

    final result = await _cartRepository.removerCartItem(
        productId, _loginBloc.userInfo!.accessToken);

    result.fold(
      (failure) {
        emit(CartStateDecIncError(failure.message, failure.statusCode));
        return false;
      },
      (successData) {
        cartResponseModel!.cartProducts
            .removeWhere((element) => element.productId == productId);
        cartCount = cartCount - 1;
        emit(CartStateRemove(successData));
        return true;
      },
    );
    return result;
  }

  Future<Either<Failure, String>> incrementQuantity(String productId) async {
    if (_loginBloc.userInfo == null) {
      emit(const CartStateDecIncError("Please login first", 401));
      return left(const ServerFailure("Please login first", 1000));
    }
    emit(const CartStateDecIncrementLoading());

    final result = await _cartRepository.incrementQuantity(
        productId, _loginBloc.userInfo!.accessToken);

    result.fold(
      (failure) {
        emit(CartStateDecIncError(failure.message, failure.statusCode));
      },
      (successData) {
        incDecMessage = successData;
        emit(CartDecIncState(successData));
      },
    );
    return result;
  }

  Future<Either<Failure, String>> decrementQuantity(String productId) async {
    if (_loginBloc.userInfo == null) {
      emit(const CartStateDecIncError("Please login first", 401));
      return left(const ServerFailure("Please login first", 1000));
    }
    emit(const CartStateDecIncrementLoading());

    final result = await _cartRepository.decrementQuantity(
        productId, _loginBloc.userInfo!.accessToken);

    result.fold(
      (failure) {
        emit(CartStateDecIncError(failure.message, failure.statusCode));
      },
      (successData) {
        incDecMessage = successData;

        emit(CartDecIncState(successData));
      },
    );
    return result;
  }

  Future<void> applyCoupon(String coupon) async {
    if (_loginBloc.userInfo == null) {
      emit(const CartStateDecIncError("Please login first", 401));
      return;
    }
    emit(const CartStateDecIncrementLoading());

    final result = await _cartRepository.applyCoupon(
        coupon, _loginBloc.userInfo!.accessToken);

    result.fold(
      (failure) {
        emit(CartStateDecIncError(failure.message, failure.statusCode));
      },
      (successData) {
        couponResponseModel = successData;

        emit(CartCouponStateLoaded(successData));
      },
    );
  }

  Future<void> getCoupon() async {
    emit(const CartStateDecIncrementLoading());
    final result = _cartRepository.getAppliedCoupon();
    result.fold(
      (failure) {
        emit(CartStateDecIncError(failure.message, failure.statusCode));
      },
      (successData) {
        couponResponseModel = successData;

        emit(CartCouponStateLoaded(successData));
      },
    );
  }

  void saveCartCalculation(CartCalculation cartCalculation) {
    _cartRepository.saveCartCalculation(cartCalculation);
  }

  CartCalculation getCartCalculation() {
    return _cartRepository.getCartCalculation();
  }
}
