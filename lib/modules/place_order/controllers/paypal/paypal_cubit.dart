import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/remote_urls.dart';
import '../../../authentication/controller/login/login_bloc.dart';
import '../payment_repository.dart';

part 'paypal_state.dart';

class PaypalCubit extends Cubit<PaypalState> {
  final LoginBloc _loginBloc;
  final PaymentRepository _paymentRepository;

  PaypalCubit({
    required LoginBloc loginBloc,
    required PaymentRepository paymentRepository,
  })  : _loginBloc = loginBloc,
        _paymentRepository = paymentRepository,
        super(const PaypalStateInitial());

  Future<void> payWithPaypal(Map<String, dynamic> body) async {
    if (_loginBloc.userInfo == null) {
      emit(const PaypalStateError('Please login', 401));
      return;
    }

    emit(const PaypalStateLoading());

    final uri = Uri.parse(RemoteUrls.payWithPaypal).replace(
      queryParameters: {
        'token': _loginBloc.userInfo!.accessToken,
        'shipping_address_id': body['shipping_address_id'],
        'billing_address_id': body['billing_address_id'],
        'shipping_method_id': body['shipping_method_id'],
        'agree_terms_condition': '1',
      },
    );

    final result = await _paymentRepository.payWithPaypal(uri);

    result.fold(
      (failure) {
        emit(PaypalStateError(failure.message, failure.statusCode));
      },
      (successData) {
        emit(PaypalStateLoaded(successData));
      },
    );
  }
}
