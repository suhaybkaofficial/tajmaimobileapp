import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/utils.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/rounded_app_bar.dart';
import 'controllers/change_password/change_password_cubit.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);
  // final _className = 'ChangePasswordWidget';

  @override
  Widget build(BuildContext context) {
    final changePassBloc = context.read<ChangePasswordCubit>();
    return Scaffold(
      appBar: RoundedAppBar(titleText: 'Change password'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<ChangePasswordCubit, ChangePasswordStateModel>(
          listener: (context, state) {
            final stateStatus = state.status;
            if (stateStatus is ChangePasswordStateError) {
              Utils.closeDialog(context);
              Utils.errorSnackBar(context, stateStatus.message);
            } else if (stateStatus is ChangePasswordStateLoaded) {
              Utils.closeDialog(context);
              Utils.showSnackBar(context, stateStatus.mesage);
            } else if (stateStatus is ChangePasswordStateLoading) {
              Utils.loadingDialog(context);
            }
          },
          builder: (context, state) {
            return Form(
              key: changePassBloc.formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: changePassBloc.currentPassCtr,
                    decoration:
                        const InputDecoration(hintText: 'Current password'),
                    onChanged: changePassBloc.currentPassChange,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Enter current password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: changePassBloc.passCtr,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(hintText: 'Password'),
                    onChanged: changePassBloc.paswordChange,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Enter password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: changePassBloc.passConfCtr,
                    keyboardType: TextInputType.visiblePassword,
                    decoration:
                        const InputDecoration(hintText: 'Re-enter password'),
                    onChanged: changePassBloc.paswordConfirmChange,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Re-enter password";
                      } else if (state.password != state.passwordConfirmation) {
                        return "Password dosen't match";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    text: 'Change password',
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      context.read<ChangePasswordCubit>().submitForm();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
