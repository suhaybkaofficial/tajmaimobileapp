import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/constants.dart';
import '../controller/app_setting_cubit/app_setting_cubit.dart';
import 'package:flutter/material.dart';

class SettingErrorWidget extends StatelessWidget {
  const SettingErrorWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(color: redColor, fontSize: 20),
          ),
          TextButton(
            onPressed: () {
              context.read<AppSettingCubit>().loadWebSetting();
            },
            child: const Icon(
              Icons.refresh_outlined,
              color: blackColor,
            ),
          )
        ],
      ),
    );
  }
}
