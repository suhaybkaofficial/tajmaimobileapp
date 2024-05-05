import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/modules/animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../controllers/country_state_by_id/country_state_by_id_cubit.dart';
import '../model/user_info/user_updated_info.dart';

class ProfileAppBar extends StatelessWidget {
  final double height;

  const ProfileAppBar({
    Key? key,
    this.height = 160,
    required this.userData,
    required this.logo,
  }) : super(key: key);
  final String logo;
  final UserProfileInfo userData;

  @override
  Widget build(BuildContext context) {
    context
        .read<CountryStateByIdCubit>()
        .stateLoadIdCountryId("${userData.updateUserInfo.countryId}");
    context
        .read<CountryStateByIdCubit>()
        .cityLoadIdStateId("${userData.updateUserInfo.stateId}");

    final List<Map<String, dynamic>> headerItem = [
      {
        "image": Kimages.profileOrderIcon,
        "title": Language.order.capitalizeByWord(),
        'onTap': () => Navigator.pushNamed(context, RouteNames.orderScreen)
      },
      {
        "image": Kimages.profileCartIcon,
        "title": Language.cart.capitalizeByWord(),
        'onTap': () => Navigator.pushNamed(context, RouteNames.cartScreen)
      },
      {
        "image": Kimages.profileofferIcon,
        "title": Language.offers.capitalizeByWord(),
        'onTap': () => Navigator.pushNamed(context, RouteNames.flashScreen)
      },
      {
        "image": Kimages.profileWishListIcon,
        "title": Language.wishlist.capitalizeByWord(),
        'onTap': () =>
            Navigator.pushNamed(context, RouteNames.wishlistOfferScreen)
      },
    ];

    return SafeArea(
      child: Material(
        color: Colors.white,
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Positioned(child: _buildUserInfo(context)),
              Positioned(
                bottom: 0,
                left: 20,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xff333333).withOpacity(.18),
                          blurRadius: 70),
                    ],
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        headerItem.length,
                        (index) => _headerItem(
                          headerItem[index]['image'],
                          headerItem[index]['title'],
                          headerItem[index]['onTap'],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerItem(String icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: const Color(0xffE8EEF2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(child: CustomImage(path: icon)),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: const TextStyle(fontSize: 13),
          )
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    final profile = userData.updateUserInfo.image.isNotEmpty
        ? RemoteUrls.imageUrl(userData.updateUserInfo.image)
        : RemoteUrls.imageUrl(userData.defaultImage!.image);
    return Container(
      padding: const EdgeInsets.all(20),
      height: height - 60,
      decoration: BoxDecoration(
        color: Utils.dynamicPrimaryColor(context),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImage(
              path: RemoteUrls.imageUrl(
                  context.read<AppSettingCubit>().settingModel!.setting.logo),
              height: 32,
              width: 128),
          Row(
            children: [
              Text(
                userData.updateUserInfo.name.split(" ").first,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.profileEditScreen);
                },
                child: _profileImage(profile),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget sizedBox() {
    return SizedBox(
      height: 45.0,
      width: 45.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: CustomImage(
          path: RemoteUrls.imageUrl(userData.defaultImage!.image),
        ),
      ),
    );
  }

  Widget _profileImage(String image) {
    return Container(
      height: 45.0,
      width: 45.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: CustomImage(path: image, fit: BoxFit.cover)),
    );
  }
}
