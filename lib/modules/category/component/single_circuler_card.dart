import 'package:flutter/material.dart';
import 'package:flutter_font_awesome_web_names/flutter_font_awesome.dart';

import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../home/model/home_category_model.dart';

class CategoryCircleCard extends StatelessWidget {
  const CategoryCircleCard({
    Key? key,
    required this.categoriesModel,
  }) : super(key: key);

  // final CategoriesModel categoriesModel;
  final HomePageCategoriesModel categoriesModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.singleCategoryProductScreen,
            arguments: {
              'title': categoriesModel.name,
              'slug': categoriesModel.slug,
            });
      },
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffFFF7E7),
            ),
            child: Center(
              child: FaIcon(categoriesModel.icon, color: blackColor),
            ),
            // child: Center(
            //   child: CustomImage(
            //     path: RemoteUrls.imageUrl(categoriesModel.image),
            //     height: 40.0,
            //     width: 40.0,
            //   ),
            //   // child: FaIcon(categoriesModel., color: blackColor),
            // ),
          ),
          Text(
            categoriesModel.name,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
