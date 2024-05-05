import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/privacy_policy_model.dart';
import '../repository/setting_repository.dart';
part 'privacy_and_term_condition_cubit_state.dart';

class PrivacyAndTermConditionCubit
    extends Cubit<PrivacyTermConditionCubitState> {
  PrivacyAndTermConditionCubit(this.settingRepository)
      : super(TermConditionCubitStateLoading());

  final SettingRepository settingRepository;

  Future<void> getTermsAndConditionData() async {
    emit(TermConditionCubitStateLoading());

    final result = await settingRepository.getTermsAndCondition();
    result.fold(
      (failuer) {
        emit(TermConditionCubitStateError(errorMessage: failuer.message));
      },
      (data) {
        emit(
          TermConditionCubitStateLoaded(
            privacyPolicyAndTermConditionModel: data,
          ),
        );
      },
    );
  }

  Future<void> getPrivacyPolicyData() async {
    emit(TermConditionCubitStateLoading());

    final result = await settingRepository.getPrivacyPolicy();
    result.fold(
      (failuer) {
        emit(TermConditionCubitStateError(errorMessage: failuer.message));
      },
      (data) {
        emit(
          TermConditionCubitStateLoaded(
            privacyPolicyAndTermConditionModel: data,
          ),
        );
      },
    );
  }
}
