import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../model/home_category_model.dart';
import '../../../core/router_name.dart';
import '../../category/component/single_circuler_card.dart';
import 'section_header.dart';

class CategoryGridView extends StatelessWidget {
  const CategoryGridView({
    Key? key,
    required this.categoryList,
    required this.sectionTitle,
  }) : super(key: key);
  //final List<CategoriesModel> categoryList;
  final List<HomePageCategoriesModel> categoryList;
  final String sectionTitle;

  @override
  Widget build(BuildContext context) {
    if (categoryList.isEmpty) return const SliverToBoxAdapter();
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      sliver: MultiSliver(
        children: [
          SliverToBoxAdapter(
            child: SectionHeader(
              headerText: sectionTitle,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.allCategoryListScreen);
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                      categoryList.length > 6 ? 6 : categoryList.length,
                      (index) => Padding(
                            padding: const EdgeInsets.only(right: 24),
                            child: CategoryCircleCard(
                                categoriesModel: categoryList[index]),
                          ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
