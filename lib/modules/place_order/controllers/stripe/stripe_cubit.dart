import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../authentication/controller/login/login_bloc.dart';
import '../payment_repository.dart';

part 'stripe_state.dart';

class StripeCubit extends Cubit<StripeState> {
  final PaymentRepository _paymentRepository;

  final LoginBloc _loginBloc;

  StripeCubit({
    required LoginBloc loginBloc,
    required PaymentRepository paymentRepository,
  })  : _paymentRepository = paymentRepository,
        _loginBloc = loginBloc,
        super(const StripeInitial());

  Future<void> callStripe(Map<String, String> body) async {
    emit(const StripeLoading());
    final result = await _paymentRepository.stripePay(
        _loginBloc.userInfo!.accessToken, body);

    result.fold((failure) {
      emit(StripeError(failure.message, failure.statusCode));
    }, (data) {
      emit(StripeLoaded(data));
    });
  }
}
