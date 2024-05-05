import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../authentication/controller/login/login_bloc.dart';
import '../payment_repository.dart';

part 'cash_on_payment_state.dart';

class CashOnPaymentCubit extends Cubit<CashPaymentState> {
  final LoginBloc _loginBloc;
  final PaymentRepository _paymentRepository;

  CashOnPaymentCubit({
    required LoginBloc loginBloc,
    required PaymentRepository paymentRepository,
  })  : _loginBloc = loginBloc,
        _paymentRepository = paymentRepository,
        super(const CashPaymentStateInitial());

  Future<void> cashOnDelivery(Map<String,dynamic> body) async {
    if (_loginBloc.userInfo == null) {
      emit(const CashPaymentStateError('Please login', 401));
      return;
    }

    emit(const CashPaymentStateLoading());


    // final uri = Uri.parse(RemoteUrls.cashOnDelivery).replace(
    //   queryParameters: {
    //     'token': _loginBloc.userInfo!.accessToken,
    //     'shipping_method': '1',
    //     ''
    //     'agree_terms_condition': '1',
    //   },
    // );

    final result = await _paymentRepository.cashOnDelivery(
        body, _loginBloc.userInfo!.accessToken);

    result.fold(
      (failure) {
        emit(CashPaymentStateError(failure.message, failure.statusCode));
      },
      (successData) {

        emit(CashPaymentStateLoaded(successData));
      },
    );
  }
}
