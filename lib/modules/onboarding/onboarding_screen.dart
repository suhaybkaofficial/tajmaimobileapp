import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_o/utils/utils.dart';

import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/primary_button.dart';
import '../animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import 'model/onbording_data.dart';
import 'widgets/dot_indicator_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late int _numPages;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _numPages = onBoardingList.length;
    _pageController = PageController(initialPage: _currentPage);
  }

  Widget getContent() {
    final item = onBoardingList[_currentPage];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      key: ValueKey('$_currentPage'),
      children: [
        Text(
          item.title,
          style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 18),
        Text(
          item.paragraph,
          style: TextStyle(
            fontSize: 16,
            color: blackColor.withOpacity(.5),
          ),
        ),
      ],
    );
  }

  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    Utils.dynamicPrimaryColor(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildImagesSlider(),
              _buildBottomContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: kDuration,
            transitionBuilder: (Widget child, Animation<double> anim) {
              return FadeTransition(opacity: anim, child: child);
            },
            child: getContent(),
          ),
          const SizedBox(height: 25),
          if (_currentPage == _numPages - 1) ...[
            PrimaryButton(
              text: Language.enabledLocation.capitalizeByWord(),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.authenticationScreen, (route) => false);
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.authenticationScreen, (route) => false);
              },
              child: Text(
                Language.notNow.capitalizeByWord(),
                style: const TextStyle(
                  color: Color(0xff797979),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ] else ...[
            _buildBottomButtonIndicator(),
          ]
        ],
      ),
    );
  }

  Widget _buildBottomButtonIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DotIndicatiorWidget(
          currentIndex: _currentPage,
          dotNumber: _numPages,
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            minimumSize: const Size(80, 80),
            backgroundColor: Utils.dynamicPrimaryColor(context),
            shape: const CircleBorder(),
          ),
          onPressed: () {
            if (_currentPage == _numPages - 1) {
              context.read<AppSettingCubit>().cachOnBoarding();
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.authenticationScreen, (route) => false);
              return;
            }
            _pageController.nextPage(
                duration: kDuration, curve: Curves.easeInOut);
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                Language.next.capitalizeByWord(),
                style: const TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagesSlider() {
    return SizedBox(
      height: size.height / 3,
      child: PageView(
        physics: const ClampingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children:
            onBoardingList.map((e) => CustomImage(path: e.image)).toList(),
      ),
    );
  }
}
