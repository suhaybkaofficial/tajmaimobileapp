import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_o/modules/order/controllers/order_tracking/order_tracking_cubit.dart';
import 'package:shop_o/utils/utils.dart';

import '/widgets/capitalized_word.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../utils/language_string.dart';
import '../../widgets/please_signin_widget.dart';
import '../../widgets/toggle_button_scroll_component.dart';
import 'component/empty_order_component.dart';
import 'component/ordered_list_component.dart';
import 'controllers/order/order_cubit.dart';
import 'model/order_model.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<OrderCubit>().getOrderList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderList = context.read<OrderCubit>();
    print('order-length ${orderList.orderList.length}');
    return Scaffold(
      body: BlocListener<OrderTrackingCubit, OrderTrackingState>(
        listener: (context, state) {
          if (state is OrderStateTrackingLoading) {
            Utils.loadingDialog(context);
          } else {
            Utils.closeDialog(context);
            if (state is OrderTrackingStateError) {
              Utils.errorSnackBar(context, state.message);
            } else if (state is OrderStateTrackingLoaded) {
              Navigator.pushNamed(
                context,
                RouteNames.orderTrackingScreen,
                arguments: state.singleOrder,
              );
            }
          }
        },
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state is OrderStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrderStateError) {
              if (state.statusCode == 401) {
                return const PleaseSigninWidget();
              } else if (state.statusCode == 503) {
                return OrderLoadedWidget(orderedList: orderList.orderList);
              }
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: redColor),
                ),
              );
            } else if (state is OrderStateLoaded ||
                state is OrderSingleStateLoaded) {
              final orderList = context.read<OrderCubit>().orderList;
              return OrderLoadedWidget(orderedList: orderList);
            } else {
              return const SizedBox();
            }
          },
          // buildWhen: (previous, current) {
          //   print('previous-state $previous');
          //   print('current-state $current');
          //   return previous == current;
          // },
        ),
      ),
    );
  }
}

class OrderLoadedWidget extends StatefulWidget {
  final List<OrderModel> orderedList;

  const OrderLoadedWidget({
    Key? key,
    required this.orderedList,
  }) : super(key: key);

  @override
  State<OrderLoadedWidget> createState() => _OrderLoadedWidgetState();
}

class _OrderLoadedWidgetState extends State<OrderLoadedWidget> {
  List<OrderModel> orderedList = [];
  int _currentIndex = 0;

  void _filtering(int index) {
    orderedList.clear();
    _currentIndex = index;

    for (var element in widget.orderedList) {
      if (element.orderStatus == index) {
        orderedList.add(element);
      }
    }
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    _filtering(_currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final list = [
      context.read<OrderCubit>().orderStatusWithLenght(0),
      context.read<OrderCubit>().orderStatusWithLenght(1),
      context.read<OrderCubit>().orderStatusWithLenght(2),
      context.read<OrderCubit>().orderStatusWithLenght(3),
      context.read<OrderCubit>().orderStatusWithLenght(4),
    ];

    final routeName = ModalRoute.of(context)?.settings.name ?? '';

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          titleSpacing: routeName != RouteNames.mainPage ? 0 : null,
          automaticallyImplyLeading: routeName != RouteNames.mainPage,
          titleTextStyle: const TextStyle(
              color: blackColor, fontSize: 18, fontWeight: FontWeight.w600),
          title: Text(Language.totalOrders.capitalizeByWord()),
        ),
        SliverToBoxAdapter(
          child: ToggleButtonScrollComponent(
            textList: list,
            initialLabelIndex: _currentIndex,
            onChange: _filtering,
          ),
        ),
        if (orderedList.isEmpty) ...[
          const SliverToBoxAdapter(child: EmptyOrderComponent()),
        ] else ...[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // return Text(orderedList[index].id.toString());
                return OrderedListComponent(orderedItem: orderedList[index]);
              },
              childCount: orderedList.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
        routeName == RouteNames.mainPage
            ? const SliverToBoxAdapter(child: SizedBox(height: 65))
            : const SliverToBoxAdapter(),
      ],
    );
  }
}
