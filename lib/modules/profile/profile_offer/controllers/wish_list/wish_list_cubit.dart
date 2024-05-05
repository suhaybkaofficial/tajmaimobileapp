import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../authentication/controller/login/login_bloc.dart';
import '../../../controllers/repository/profile_repository.dart';
import '../../model/wish_list_model.dart';

part 'wish_list_state.dart';

class WishListCubit extends Cubit<WishListState> {
  WishListCubit({
    required LoginBloc loginBloc,
    required ProfileRepository profileRepository,
  })  : _loginBloc = loginBloc,
        _profileRepository = profileRepository,
        super(const WishListStateInitial());

  final LoginBloc _loginBloc;
  final ProfileRepository _profileRepository;

  List<WishListModel> wishList = [];

  List<int> selectedId = [];

  Future<void> getWishList() async {
    if (_loginBloc.userInfo == null) {
      emit(const WishListStateError("Please login first", 1000));
      return;
    }
    emit(const WishListStateLoading());

    final result =
        await _profileRepository.wishList(_loginBloc.userInfo!.accessToken);

    result.fold(
      (failure) {
        emit(WishListStateError(failure.message, failure.statusCode));
      },
      (wishList) {
        this.wishList = wishList;
        emit(WishListStateLoaded(wishList));
      },
    );
  }

  Future<Either<Failure, String>> removeWishList(WishListModel item) async {
    if (_loginBloc.userInfo == null) {
      return left(const ServerFailure("Please login first", 1000));
    }
    final result = await _profileRepository.removeWishList(
        item.wishId, _loginBloc.userInfo!.accessToken);

    result.fold((failure) {
      emit(WishListStateError(failure.message, failure.statusCode));
    }, (success) {
      // getWishList();
      wishList.removeWhere((element) => element.id==item.id);
      emit(WishListStateSuccess(success));
    });

    return result;
  }


  Future<void> clearWishList() async {
    if (_loginBloc.userInfo == null) {
      emit(const WishListStateError("Please login first", 1000));
      return;
    }
    emit(const WishListStateLoading());
    final result = await _profileRepository
        .clearWishList(_loginBloc.userInfo!.accessToken);

    result.fold(
      (failure) {
        emit(WishListStateError(failure.message, failure.statusCode));
      },
      (wishList) {
        this.wishList.clear();
        emit(const WishListStateLoaded([]));
      },
    );
  }
  Future<Either<Failure, String>> addWishList(int id) async {
    if (_loginBloc.userInfo == null) {
      return left(const ServerFailure("Please login first", 1000));
    }
    emit(const WishListStateLoading());
    final result = await _profileRepository.addWishList(
        id, _loginBloc.userInfo!.accessToken);

    result.fold((failure) {
      emit(WishListStateError(failure.message, failure.statusCode));
    }, (success) {
      getWishList();
      emit(WishListStateSuccess(success));
    });
    return result;
  }

/*  Future<void> addWishList(int id) async {
    bool isExists = false;
    WishListModel? item;
    if (_loginBloc.userInfo == null) {
      // return left(const ServerFailure("Please login first", 1000));
      return;
    }
    emit(const WishListStateLoading());
    for (var element in wishList) {
      print("Element id: ${element.id}");
      print(" id: $id");

      if (element.productId == id.toString()) {
        item = element;
        break;
      }
    }
    Either<Failure, String> result;
    Future.delayed(const Duration(microseconds: 00)).then((value) async {
      print('ITEM ID: $item');
      if (item != null) {
        result = await _profileRepository.removeWishList(
            item.wishId, _loginBloc.userInfo!.accessToken);
        print("Item Not Null is Calling");
      } else {
        result = await _profileRepository.addWishList(
            id, _loginBloc.userInfo!.accessToken);
        print("Item Else is Calling");
      }
      getWishList();
      result.fold((failure) {
        emit(WishListStateError(failure.message, failure.statusCode));
      }, (success) {
        emit(WishListStateSuccess(success));
      });
      return result;
    });
  }*/
}
