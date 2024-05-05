import 'package:flutter/material.dart';

import '../../../core/remote_urls.dart';
import '../../../core/router_name.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../model/brand_model.dart';

class SponsorComponent extends StatelessWidget {
  const SponsorComponent({
    Key? key,
    required this.brands,
  }) : super(key: key);

  final List<BrandModel> brands;

  @override
  Widget build(BuildContext context) {
    if (brands.isEmpty) return const SizedBox();
    return Container(
      height: 70,
      margin: const EdgeInsets.only(bottom: 0),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      decoration: BoxDecoration(
        color: Utils.dynamicPrimaryColor(context).withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteNames.brandProductScreen,
              arguments: brands[index].slug,
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 24),
            child: CustomImage(
              path: RemoteUrls.imageUrl(brands[index].logo),
              height: 56,
              width: 68,
            ),
          ),
        ),
        separatorBuilder: (_, index) => const SizedBox(width: 10),
        itemCount: brands.length,
      ),
    );
  }
}
