import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/remote_urls.dart';
import '../../../authentication/controller/login/login_bloc.dart';
import '../payment_repository.dart';

part 'razorpay_state.dart';

class RazorpayCubit extends Cubit<RazorpayState> {
  final LoginBloc _loginBloc;
  final PaymentRepository _paymentRepository;

  RazorpayCubit({
    required LoginBloc loginBloc,
    required PaymentRepository paymentRepository,
  })  : _loginBloc = loginBloc,
        _paymentRepository = paymentRepository,
        super(const RazorpayStateInitial());

  Future<void> payWithRazor(Map<String, dynamic> body) async {
    if (_loginBloc.userInfo == null) {
      emit(const RazorStateError('Please login', 401));
      return;
    }

    emit(const RazorStateLoading());

    final uri = Uri.parse(RemoteUrls.razorOrder).replace(
      queryParameters: {
        'token': _loginBloc.userInfo!.accessToken,
        'shipping_address_id': body['shipping_address_id'],
        'billing_address_id': body['billing_address_id'],
        'shipping_method_id': body['shipping_method_id'],
        'agree_terms_condition': '1',
      },
    );

    final result = await _paymentRepository.payWithRazor(uri);

    result.fold(
      (failure) {
        emit(RazorStateError(failure.message, failure.statusCode));
      },
      (successData) {
        emit(RazorStateLoaded(successData));
      },
    );
  }
}
