import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/widgets/capitalized_word.dart';
import '../../../utils/k_images.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../main_controller.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = MainController();
    return SizedBox(
      // height: Platform.isAndroid ?  80 : 100,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: StreamBuilder(
          initialData: 0,
          stream: _controller.naveListener.stream,
          builder: (_, AsyncSnapshot<int> index) {
            int _selectedIndex = index.data ?? 0;
            return BottomNavigationBar(
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedLabelStyle: TextStyle(
                  fontSize: 14, color: Utils.dynamicPrimaryColor(context)),
              unselectedLabelStyle:
                  const TextStyle(fontSize: 14, color: Color(0xff85959E)),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(Kimages.homeIcon),
                  activeIcon: SvgPicture.asset(Kimages.homeActive,
                  ),
                  label: Language.home.capitalizeByWord(),
                ),
                // BottomNavigationBarItem(
                //   icon: SvgPicture.asset(Kimages.inboxIcon),
                //   activeIcon: SvgPicture.asset(Kimages.inboxActive),
                //   label: 'Inbox',
                // ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(Kimages.orderIcon),
                  activeIcon: SvgPicture.asset(Kimages.orderActive),
                  label: Language.order.capitalizeByWord(),
                ),
                BottomNavigationBarItem(
                  tooltip: Language.profile.capitalizeByWord(),
                  activeIcon: SvgPicture.asset(Kimages.profileActive),
                  icon: SvgPicture.asset(Kimages.profileIcon),
                  label: Language.profile.capitalizeByWord(),
                ),
              ],
              // type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: (int index) {
                _controller.naveListener.sink.add(index);
              },
            );
          },
        ),
      ),
    );
  }
}
