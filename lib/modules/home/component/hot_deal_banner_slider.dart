import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../model/banner_model.dart';
import 'hot_deal_banner.dart';

class CombineBannerSlider extends StatefulWidget {
  const CombineBannerSlider({
    Key? key,
    required this.banners,
  }) : super(key: key);

  final List<BannerModel> banners;

  @override
  State<CombineBannerSlider> createState() => _CombineBannerSliderState();
}

class _CombineBannerSliderState extends State<CombineBannerSlider> {
  final double height = 150;
  final int initialPage = 1;
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) return const SizedBox();

    return Column(
      children: [
        const SizedBox(height: 14),
        CarouselSlider(
          options: CarouselOptions(
            height: height,
            viewportFraction: 0.8,
            initialPage: initialPage,
            // enableInfiniteScroll: false,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: false,
            onPageChanged: callbackFunction,
            scrollDirection: Axis.horizontal,
          ),
          items: widget.banners.map((i) => HotDealBanner(banner: i)).toList(),
        ),
        const SizedBox(height: 5),
        DotsIndicator(
          dotsCount: widget.banners.length,
          key: UniqueKey(),
          decorator: DotsDecorator(
            activeColor: Utils.dynamicPrimaryColor(context),
            color: borderColor,
            activeSize: const Size(18.0, 4.0),
            size: const Size(18.0, 4.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
          position: _currentIndex,
        ),
        const SizedBox(height: 10)
      ],
    );
  }

  void callbackFunction(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentIndex = index;
    });
  }
}
