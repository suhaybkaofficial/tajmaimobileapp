import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/rounded_app_bar.dart';
import 'model/order_model.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key, required this.orders});

  final OrderModel orders;

  @override
  Widget build(BuildContext context) {
    // 0 - pending
    // 1 - progress
    // 2 - declined
    // 3 - completed
    // 4 - declined
    print('STATUS ${orders.orderStatus}');

    int getTrackingIndex(int status) {
      if (status == 1) {
        return 1;
      } else if (status == 2) {
        return 2;
      } else if (status == 3) {
        return 3;
      }
      // else if (status == 4) {
      //   return 4;
      // }
      return 0;
    }

    List<StepperData> steppers = [
      StepperData(
        title: StepperText('Pending'),
        iconWidget: _buildDot(),
      ),
      StepperData(
        title: StepperText('Progress'),
        iconWidget: _buildDot(
            activeColor: orders.orderStatus == 0 ? grayColor : greenColor),
      ),
      StepperData(
        title: StepperText('Delivered'),
        iconWidget: _buildDot(
            activeColor: orders.orderStatus == 0 || orders.orderStatus == 1
                ? grayColor
                : greenColor),
      ),
      StepperData(
        title: StepperText('Completed'),
        iconWidget: _buildDot(
            activeColor: orders.orderStatus == 0 ||
                    orders.orderStatus == 1 ||
                    orders.orderStatus == 2
                ? grayColor
                : greenColor),
      ),
      // StepperData(
      //   title: StepperText('Declined'),
      //   iconWidget: _buildDot(),
      // ),
    ];

    return Scaffold(
      appBar: RoundedAppBar(titleText: 'Order Details'),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        shrinkWrap: true,
        children: [
          orders.orderStatus == 4
              ? declinedOrderWidget(context)
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: const Color(0xFFCBECFF),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: AnotherStepper(
                    stepperList: steppers,
                    stepperDirection: Axis.vertical,
                    verticalGap: 40.0,
                    activeIndex: getTrackingIndex(orders.orderStatus),
                    activeBarColor: greenColor,
                    inActiveBarColor: primaryColor,
                    barThickness: 6.0,
                  ),
                ),
        ],
      ),
    );
  }

  Widget declinedOrderWidget(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height * 0.7,
      width: size.width,
      alignment: Alignment.center,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Order has been Declined',
            style: TextStyle(
                fontSize: 20.0, fontWeight: FontWeight.w600, color: redColor),
          ),
          SizedBox(height: 20.0),
          CustomImage(path: Kimages.orderDeclined)
        ],
      ),
    );
  }
}

Widget _buildDot({Color activeColor = greenColor}) {
  return Container(
    height: 30.0,
    width: 30.0,
    padding: const EdgeInsets.all(3.0),
    decoration: BoxDecoration(
      border: Border.all(color: activeColor),
      shape: BoxShape.circle,
    ),
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: activeColor,
        shape: BoxShape.circle,
      ),
    ),
  );
}
