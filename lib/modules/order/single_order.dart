import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/constants.dart';
import '../../utils/language_string.dart';
import '../../utils/utils.dart';
import '../../widgets/capitalized_word.dart';
import '../../widgets/please_signin_widget.dart';
import '../../widgets/rounded_app_bar.dart';
import 'component/single_order_details_component.dart';
import 'controllers/order/order_cubit.dart';
import 'model/order_model.dart';

class SingleOrderDetails extends StatefulWidget {
  const SingleOrderDetails({Key? key, this.trackNumber}) : super(key: key);
  final String? trackNumber;

  @override
  State<SingleOrderDetails> createState() => _SingleOrderDetailsState();
}

class _SingleOrderDetailsState extends State<SingleOrderDetails> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<OrderCubit>().showOrderTracking(widget.trackNumber!));
  }

  @override
  Widget build(BuildContext context) {
    print('tracking-number ${widget.trackNumber}');
    return Scaffold(
      appBar: RoundedAppBar(titleText: Language.singleOrder.capitalizeByWord()),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderStateError) {
            if (state.statusCode == 401) {
              return const PleaseSigninWidget();
            }
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: redColor),
              ),
            );
          } else if (state is OrderSingleStateLoaded) {
            return LoadedList(singleOrder: state.singleOrder);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

List<StepperData> _steppers = [
  StepperData(
    title: StepperText('Pending'),
  ),
  StepperData(
    title: StepperText('Progress'),
  ),
  StepperData(
    title: StepperText('Delivered'),
  ),
];

class LoadedList extends StatelessWidget {
  const LoadedList({Key? key, required this.singleOrder}) : super(key: key);
  final OrderModel? singleOrder;

  @override
  Widget build(BuildContext context) {
    print('ORDER-STATUS ${singleOrder!.orderStatus}');
    int getTrackingIndex(int status) {
      if (status == 1) {
        return 1;
      } else if (status == 2 || status == 3) {
        return 2;
      }
      return 0;
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
                color: const Color(0xFFCBECFF),
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnotherStepper(
                  stepperList: _steppers,
                  stepperDirection: Axis.horizontal,
                  verticalGap: 60.0,
                  activeIndex: getTrackingIndex(singleOrder!.orderStatus),
                  activeBarColor: greenColor,
                  inActiveBarColor: primaryColor,
                  barThickness: 6.0,
                ),
                SizedBox(height: singleOrder!.orderStatus == 4 ? 10.0 : 0.0),
                Visibility(
                  visible: singleOrder!.orderStatus == 4,
                  child: const Text(
                    'Order is Declined',
                    style: TextStyle(
                        color: redColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: cardBgGreyColor,
            ),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    Utils.formatDate(singleOrder!.createdAt),
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Color(0xff85959E)),
                  ),
                ),
                ...List.generate(
                  singleOrder!.orderProducts.length,
                  (index) => Column(
                    children: [
                      SingleOrderDetailsComponent(
                        orderItem: singleOrder!.orderProducts[index],
                        isOrdered: true,
                      ),
                      const Divider(),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                OrderText(
                  title: Language.orderTrackingNumber.capitalizeByWord(),
                  text: singleOrder!.orderId,
                ),
                const SizedBox(height: 8),
                OrderText(
                  title: Language.orderNumber.capitalizeByWord(),
                  text: singleOrder!.id.toString(),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    Utils.orderStatus("${singleOrder!.orderStatus}"),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: "${singleOrder!.orderStatus}" == '4'
                            ? redColor
                            : greenColor),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OrderText extends StatelessWidget {
  const OrderText({Key? key, this.title, this.text}) : super(key: key);
  final String? title;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "$title:",
        style: const TextStyle(
            fontSize: 16,
            color: iconGreyColor,
            decoration: TextDecoration.underline,
            height: 1),
        children: [
          TextSpan(
            text: ' ${text!}',
            style: const TextStyle(
                color: blackColor,
                fontSize: 16,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
