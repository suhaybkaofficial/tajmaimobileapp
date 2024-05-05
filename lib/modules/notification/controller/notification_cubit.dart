import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/remote_urls.dart';
import '../../authentication/controller/login/login_bloc.dart';
import '../../authentication/repository/auth_repository.dart';
import 'notification_state_model.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final AuthRepository _repository;
  final LoginBloc _loginBloc;

  NotificationCubit(
      {required AuthRepository repository, required LoginBloc loginBloc})
      : _repository = repository,
        _loginBloc = loginBloc,
        super(const NotificationInitial());

  Future<void> updateUserForPushNotification(NotificationModel model) async {
    emit(NotificationLoading());
    String route = RemoteUrls.updateUserForPushNotification(
        _loginBloc.userInfo!.accessToken);

    final uri = Uri.parse(route).replace(queryParameters: {
      'user_id': model.userId,
      'device_token': model.deviceToken,
    });
    debugPrint('notification-url $uri');
    final result = await _repository.updateUserForPushNotification(uri);
    result.fold(
      (failure) {
        emit(NotificationError(failure.message, failure.statusCode));
      },
      (success) {
        emit(NotificationLoaded(success));
      },
    );
  }
}
