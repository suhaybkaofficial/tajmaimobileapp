import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/remote_urls.dart';
import '../../../authentication/controller/login/login_bloc.dart';
import '../../model/transaction_response.dart';
import '../payment_repository.dart';
part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepository _paymentRepository;

  final LoginBloc _loginBloc;

  PaymentCubit({
    required LoginBloc loginBloc,
    required PaymentRepository paymentRepository,
  })  : _paymentRepository = paymentRepository,
        _loginBloc = loginBloc,
        super(const PaymentInitial());

  Future<void> makePayment(double amount) async {
    final _amount = (amount * 100).toInt();
    String totalAmount = _amount.toString();

    if (_loginBloc.userInfo == null) {
      emit(const PaymentError("Please login first", 401));
      return;
    }

    emit(const PaymentLoading());
    final result = await _paymentRepository.makePayment(totalAmount, 'usd');

    result.fold((failure) {
      emit(PaymentError(failure.message, failure.statusCode));
    }, (successData) {
      emit(PaymentLoaded(successData));
    });
  }

  Future<void> payWithPaypel(double amount) async {
    if (_loginBloc.userInfo == null) {
      emit(const PaymentError("Please login first", 401));
      return;
    }

    emit(const PaymentLoading());

    final uri = Uri.parse(RemoteUrls.payWithPaypal).replace(
      queryParameters: {
        'token': _loginBloc.userInfo!.accessToken,
        'shipping_method': '1',
        'agree_terms_condition': '1',
      },
    );

    final result = await _paymentRepository.payWithPaypal(uri);

    result.fold((failure) {
      emit(PaymentError(failure.message, failure.statusCode));
    }, (successData) {});
  }
}
