import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '/widgets/custom_image.dart';
import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/utils.dart';
import '../model/banner_model.dart';

class HotDealBanner extends StatelessWidget {
  const HotDealBanner({
    Key? key,
    required this.banner,
    this.height,
  }) : super(key: key);
  final BannerModel banner;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: CustomImage(
                  path: RemoteUrls.imageUrl(banner.image), fit: BoxFit.fill)),
          Positioned(
              top: 10.0,
              left: 10.0,
              child: Text(
                banner.titleOne,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0),
              )),
          Positioned(
            top: 30.0,
            left: 10.0,
            child: SizedBox(
              width: 180.0,
              height: 50.0,
              child: AutoSizeText(
                banner.titleTwo,
                maxLines: 2,
                maxFontSize: 18.0,
                minFontSize: 15.0,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          buildContainerContent(context),
        ],
      ),
    );
  }

  Container buildContainerContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, bottom: 16),
      color: Colors.black.withOpacity(.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                  context, RouteNames.singleCategoryProductScreen,
                  arguments: {
                    'title': banner.slug,
                    'slug': banner.slug,
                  });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Utils.dynamicPrimaryColor(context),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Text(
                Language.shopNow.capitalizeByWord(),
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}
