import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '/modules/profile/controllers/updated_info/updated_info_cubit.dart';
import '/utils/language_string.dart';
import '/utils/utils.dart';
import '/widgets/action_dialog.dart';
import '/widgets/capitalized_word.dart';
import '../../core/remote_urls.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/please_signin_widget.dart';
import '../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../authentication/controller/login/login_bloc.dart';
import 'component/profile_app_bar.dart';
import 'controllers/delete_user/delete_user_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // final _className = 'ProfileScreen';

  @override
  Widget build(BuildContext context) {
    final userData = context.read<LoginBloc>().userInfo;
    final settingModel = context.read<AppSettingCubit>().settingModel;
    const double appBarHeight = 180;
    final routeName = ModalRoute.of(context)?.settings.name ?? '';
    // context.read<UserProfileInfoCubit>().getUserProfileInfo();
    // context.read<CountryStateByIdCubit>().countryListLoaded();
// print('countryList: ${context.read<CountryStateByIdCubit>().countryListLoaded()}');
    if (userData == null) {
      return const PleaseSigninWidget();
    }

    return Scaffold(
      // backgroundColor: screenBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight: appBarHeight,
            // iconTheme: const IconThemeData(color: appPrimaryColor),
            automaticallyImplyLeading: routeName != RouteNames.mainPage,
            expandedHeight: appBarHeight,
            systemOverlayStyle: const SystemUiOverlayStyle(
                // statusBarColor: appPrimaryColor,
                ),
            flexibleSpace:
                BlocBuilder<UserProfileInfoCubit, UserProfileInfoState>(
              builder: (context, state) {
                if (state is UpdatedLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is UpdatedLoaded) {
                  return ProfileAppBar(
                    height: appBarHeight,
                    logo: RemoteUrls.imageUrl(settingModel?.setting.logo ?? ''),
                    userData: state.updatedInfo,
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          _buildProfileOptions(context),
          const SliverToBoxAdapter(child: SizedBox(height: 65)),
        ],
      ),
    );
  }

  SliverPadding _buildProfileOptions(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            ElementTile(
              title: Language.message.capitalizeByWord(),
              press: () {
                Navigator.pushNamed(context, RouteNames.chatListScreen);
              },
              iconPath: Kimages.profileChatIcon,
            ),
            ElementTile(
              title: Language.yourAddress.capitalizeByWord(),
              press: () {
                Navigator.pushNamed(context, RouteNames.addressScreen);
              },
              iconPath: Kimages.profileLocationIcon,
            ),
            ElementTile(
              title: Language.allCategories.capitalizeByWord(),
              press: () {
                Navigator.pushNamed(context, RouteNames.allCategoryListScreen);
              },
              iconPath: Kimages.profileCategoryIcon,
            ),
            ElementTile(
              title: Language.termsCon.capitalizeByWord(),
              press: () {
                Navigator.pushNamed(context, RouteNames.termsConditionScreen);
              },
              iconPath: Kimages.profileTermsConditionIcon,
            ),
            ElementTile(
              title: Language.privacyPolicy.capitalizeByWord(),
              press: () {
                Navigator.pushNamed(context, RouteNames.privacyPolicyScreen);
              },
              iconPath: Kimages.profilePrivacyIcon,
            ),
            ElementTile(
              title: Language.faq,
              press: () {
                Navigator.pushNamed(context, RouteNames.faqScreen);
              },
              iconPath: Kimages.profileFaqIcon,
            ),
            ElementTile(
              title: Language.aboutUs.capitalizeByWord(),
              press: () {
                Navigator.pushNamed(context, RouteNames.aboutUsScreen);
              },
              iconPath: Kimages.profileAboutUsIcon,
            ),
            ElementTile(
              title: Language.contactUs.capitalizeByWord(),
              press: () {
                Navigator.pushNamed(context, RouteNames.contactUsScreen);
              },
              iconPath: Kimages.profileContactIcon,
            ),
            ElementTile(
              title: Language.becomeSeller,
              press: () =>
                  Navigator.pushNamed(context, RouteNames.becomeSellerScreen),
              iconPath: Kimages.becomeSellerIcon,
            ),
            // ElementTile(
            //   title: 'Delivery Man Register',
            //   press: () => Navigator.pushNamed(
            //       context, RouteNames.deliveryManRegistrationScreen),
            //   iconPath: Kimages.becomeSellerIcon,
            // ),
            ElementTile(
              title: Language.appInfo.capitalizeByWord(),
              press: () {
                Utils.appInfoDialog(context);
              },
              iconPath: Kimages.profileAppInfoIcon,
            ),
            BlocListener<DeleteUserCubit, DeleteUserState>(
              listener: (context, state) {
                if (state is DeleteUserLoading) {
                  Utils.loadingDialog(context);
                } else {
                  Utils.closeDialog(context);
                  if (state is DeleteUserError) {
                    // Navigator.of(context).pop();
                    Utils.errorSnackBar(context, state.message);
                  } else if (state is DeleteUserLoaded) {
                    //Navigator.of(context).pop();
                    //Utils.showSnackBar(context, state.message);
                    Navigator.pushNamedAndRemoveUntil(context,
                        RouteNames.authenticationScreen, (route) => false);
                  }
                }
              },
              child: ElementTile(
                title: Language.deleteAccount,
                press: () {
                  showDialog(
                    context: context,
                    builder: (context) => ActionDialog(
                      title: Language.doYouWantToDeleteAccount,
                      image: Kimages.deleteIcon,
                      onTap: () {
                        Navigator.of(context).pop();
                        context.read<DeleteUserCubit>().deleteUserAccount();
                      },
                      textSize: 20.0,
                      bgColor: redColor,
                      textColor: primaryColor,
                      deleteText: Language.delete,
                    ),
                  );
                },
                iconPath: Kimages.deleteIcon,
              ),
            ),
            BlocListener<LoginBloc, LoginModelState>(
              listener: (context, state) {
                final logout = state.state;
                if (logout is LoginStateLogOutLoading) {
                  Utils.loadingDialog(context);
                } else {
                  Utils.closeDialog(context);
                  if (logout is LoginStateSignOutError) {
                    Utils.errorSnackBar(context, logout.errorMsg);
                  } else if (logout is LoginStateLogOut) {
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(context,
                        RouteNames.authenticationScreen, (route) => false);
                    Utils.showSnackBar(context, logout.msg);
                  }
                }
              },
              child: ElementTile(
                title: Language.logout.capitalizeByWord(),
                press: () {
                  showDialog(
                    context: context,
                    builder: (context) => ActionDialog(
                      title: "${Language.areYouSureYouWantToLogOut}?",
                      image: Kimages.logout,
                      deleteText: Language.logout,
                      textColor: primaryColor,
                      onTap: () {
                        loginBloc.add(const LoginEventLogout());
                      },
                    ),
                  );
                },
                iconPath: Kimages.profileLogOutIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ElementTile extends StatelessWidget {
  const ElementTile({
    super.key,
    this.title,
    this.press,
    this.iconPath,
  });
  final String? title;
  final VoidCallback? press;
  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      onTap: press,
      contentPadding: EdgeInsets.zero,
      leading: CustomImage(
        path: iconPath!,
        height: 20.0,
        color: Utils.dynamicPrimaryColor(context),
      ),
      title: Text(
        title!,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
