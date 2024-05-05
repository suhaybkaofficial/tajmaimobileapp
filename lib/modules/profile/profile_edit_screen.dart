import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../../widgets/rounded_app_bar.dart';
import 'component/profile_edit_form.dart';
import 'controllers/updated_info/updated_info_cubit.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(titleText: Language.editProfile.capitalizeByWord()),
      body: BlocBuilder<UserProfileInfoCubit, UserProfileInfoState>(
        builder: (context, state) {
          if (state is UpdatedLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UpdatedError) {
            // Utils.closeDialog(context);
            // Utils.errorSnackBar(context, state.message);
            return Center(child: Text(state.message));
          } else if (state is UpdatedLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: ProfileEditForm(userData: state.updatedInfo),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
