import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/remote_urls.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../../utils/language_string.dart';
import '../../utils/utils.dart';
import '../../widgets/action_dialog.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/primary_button.dart';
import '../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import 'controllers/order_tracking/order_tracking_cubit.dart';

class OrderTrackingFormScreen extends StatelessWidget {
  const OrderTrackingFormScreen({super.key});

  Widget verticalSpace({double height = 20.0}) {
    return SizedBox(height: height);
  }

  @override
  Widget build(BuildContext context) {
    final trackCubit = context.read<OrderTrackingCubit>();
    final setting = context.read<AppSettingCubit>();
    return WillPopScope(
      onWillPop: () async {
        exitDialog(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: appBgColor,
          title: const Text('Tracking Order'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            verticalSpace(height: 60.0),
            Center(
              child: CustomImage(
                  path:
                      RemoteUrls.imageUrl(setting.settingModel!.setting.logo)),
            ),
            verticalSpace(),
            const Text(
              'Track Your Order',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  color: blackColor),
            ),
            const Text(
              'Enter your order number for tracking your order.',
              style: TextStyle(fontSize: 16.0, color: blackColor),
            ),
            verticalSpace(),
            Form(
              key: trackCubit.trackingKey,
              child: TextFormField(
                controller: trackCubit.orderIdNumberController,
                validator: (String? id) =>
                    id!.isNotEmpty ? null : 'Order number is required',
                decoration: const InputDecoration(hintText: 'Enter Order Id'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.deny('a'),
                ],
              ),
            ),
            verticalSpace(),
            BlocConsumer<OrderTrackingCubit, OrderTrackingState>(
              listener: (context, state) {
                if (state is OrderTrackingStateError) {
                  Utils.errorSnackBar(context, state.message);
                } else if (state is OrderStateTrackingLoaded) {
                  //print('message ${state.singleOrder.message}');
                  if (state.singleOrder.message.isEmpty) {
                    //print('null message');
                    Navigator.pushNamed(context, RouteNames.orderTrackingScreen,
                        arguments: state.singleOrder);
                    trackCubit.orderIdNumberController.clear();
                  } else {
                    //print('not null message');
                    Utils.errorSnackBar(context, state.singleOrder.message);
                  }
                }
              },
              builder: (context, state) {
                if (state is OrderStateTrackingLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return PrimaryButton(
                  text: 'Track Order',
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    if (trackCubit.trackingKey.currentState!.validate()) {
                      trackCubit.trackingOrderResponse();
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Future exitDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return ActionDialog(
            image: Kimages.exitApp,
            title: Language.exitApp,
            deleteText: Language.yesExit,
            onTap: () => SystemNavigator.pop(),
          );
        });
  }
}
