import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_o/widgets/action_dialog.dart';

import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../cart/controllers/cart/cart_cubit.dart';
import '../home/home_screen.dart';
import '../message/controller/bloc/bloc/chat_bloc.dart';
import '../order/order_screen.dart';
import '../profile/controllers/country_state_by_id/country_state_by_id_cubit.dart';
import '../profile/controllers/updated_info/updated_info_cubit.dart';
import '../profile/profile_offer/controllers/wish_list/wish_list_cubit.dart';
import '../profile/profile_screen.dart';
import 'component/bottom_navigation_bar.dart';
import 'main_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _homeController = MainController();

  late List<Widget> pageList;

  @override
  void initState() {
    super.initState();

    pageList = [
      const HomeScreen(),
      // const ChatListScreen(),
      const OrderScreen(),
      const ProfileScreen(),
    ];

    context.read<CountryStateByIdCubit>().countryListLoaded();
    context.read<UserProfileInfoCubit>().getUserProfileInfo();
    context.read<CartCubit>().getCartProducts();
    context.read<ChatBloc>().add(const ChatStarted());
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

  Widget popup() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: const BoxDecoration(
                  color: blackColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12))),
              child: Text(
                "${Language.exitApp.capitalizeByWord()}?",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: blackColor,
                    side: BorderSide(color: Utils.dynamicPrimaryColor(context)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(Language.cancel.capitalizeByWord()),
                  )),
              const SizedBox(width: 10),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: blackColor,
                    side: BorderSide(color: Utils.dynamicPrimaryColor(context)),
                  ),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(Language.yesExit.capitalizeByWord()),
                  )),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<CartCubit>().getCartProducts();
    context.read<WishListCubit>().getWishList();
    return WillPopScope(
      onWillPop: () async {
        exitDialog(context);
        return true;
      },
      child: Scaffold(
        extendBody: true,
        // key: _homeController.scaffoldKey,
        // drawer: const DrawerWidget(),
        body: StreamBuilder<int>(
          initialData: 0,
          stream: _homeController.naveListener.stream,
          builder: (context, AsyncSnapshot<int> snapshot) {
            int index = snapshot.data ?? 0;
            return pageList[index];
          },
        ),
        bottomNavigationBar: const MyBottomNavigationBar(),
      ),
    );
  }
}
