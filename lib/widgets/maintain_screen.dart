import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '/core/remote_urls.dart';
import '/modules/animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '/utils/constants.dart';
import '/widgets/custom_image.dart';

class MaintainScreen extends StatelessWidget {
  const MaintainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppSettingCubit, AppSettingState>(
        builder: (context, state) {
          if (state is AppSettingStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AppSettingStateError) {
            return Center(child: Text(state.meg));
          } else if (state is AppSettingStateLoaded) {
            final result = state.settingModel.maintainTextModel;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomImage(path: RemoteUrls.imageUrl(state.settingModel.maintainTextModel!.image)),
                    const SizedBox(height: 20.0),
                    Text(
                      result!.description,
                      style: GoogleFonts.jost(fontSize: 18.0, color: blackColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
