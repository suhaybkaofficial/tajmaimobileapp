import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../authentication/controller/login/login_bloc.dart';
import '../../../model/add_to_cart_model.dart';
import '../../cart_repository.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit({
    required LoginBloc loginBloc,
    required CartRepository cartRepository,
  })  : _loginBloc = loginBloc,
        _cartRepository = cartRepository,
        super(const AddToCartStateInitial());

  final LoginBloc _loginBloc;
  final CartRepository _cartRepository;

  Future<void> addToCart(AddToCartModel dataModel) async {
    if (_loginBloc.userInfo == null) {
      emit(const AddToCartStateError("Please login first", 401));
      return;
    }

    emit(const AddToCartStateLoading());

    dataModel = dataModel.copyWith(token: _loginBloc.userInfo!.accessToken);
    // await Future.delayed(const Duration(seconds: 1));
    final result = await _cartRepository.addToCart(dataModel);

    result.fold(
      (failure) {
        emit(AddToCartStateError(failure.message, failure.statusCode));
      },
      (successData) {
        emit(AddToCartStateAdded(successData));
      },
    );
  }
}
