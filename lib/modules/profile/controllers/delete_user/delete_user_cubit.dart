import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/controller/login/login_bloc.dart';
import '../repository/profile_repository.dart';

part 'delete_user_state.dart';

class DeleteUserCubit extends Cubit<DeleteUserState> {
  final LoginBloc _loginBloc;
  final ProfileRepository _profileRepository;

  DeleteUserCubit({
    required LoginBloc loginBloc,
    required ProfileRepository profileRepository,
  })  : _loginBloc = loginBloc,
        _profileRepository = profileRepository,
        super(const DeleteUserInitial());

  Future<void> deleteUserAccount() async {
    emit(const DeleteUserLoading());
    final delete = await _profileRepository
        .deleteUserAccount(_loginBloc.userInfo!.accessToken);
    delete.fold((l) {
      emit(DeleteUserError(l.message, l.statusCode));
    }, (r) {
      emit(DeleteUserLoaded(r));
    });
  }
}
