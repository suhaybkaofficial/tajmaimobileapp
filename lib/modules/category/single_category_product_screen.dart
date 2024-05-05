import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '/core/router_name.dart';
import '/modules/category/component/drawer_filter.dart';
import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../../utils/utils.dart';
import '../../widgets/rounded_app_bar.dart';
import 'component/product_card.dart';
import 'controller/cubit/category_cubit.dart';

class SingleCategoryProductScreen extends StatefulWidget {
  const SingleCategoryProductScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SingleCategoryProductScreen> createState() =>
      _SingleCategoryProductScreenState();
}

class _SingleCategoryProductScreenState
    extends State<SingleCategoryProductScreen> {
  @override
  Widget build(BuildContext context) {
    final receiveName =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final title = receiveName['title'] as String;
    final slug = receiveName['slug'] as String;
    context.read<CategoryCubit>().getCategoryProduct(slug, 1);

    return Scaffold(
        endDrawer: const DrawerFilter(),
        appBar: RoundedAppBar(
          titleText: title.capitalizeByWord(),
          onTap: () {
            Navigator.popAndPushNamed(
                context, RouteNames.allCategoryListScreen);
          },
        ),
        body: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoryLoadedState) {
              if (state.categoryProducts.isEmpty) {
                return Center(
                    child: Text(Language.noItemsFound.capitalizeByWord()));
              }
              // _buildProductGrid(state.productCategoriesModel.products);
              return CategoryLoad(slug: slug);
            } else if (state is CategoryErrorState) {
              return Center(
                child: Text(state.errorMessage),
              );
            }
            return Center(
              child: SizedBox(
                child: Text(Language.somethingWentWrong.capitalizeByWord()),
              ),
            );
          },
        ));
  }
}

class CategoryLoad extends StatelessWidget {
  const CategoryLoad({
    Key? key,
    required this.slug,
  }) : super(key: key);
  final String slug;

  @override
  Widget build(BuildContext context) {
    int page = 1;
    final categoryProduct = context.read<CategoryCubit>().categoryProducts;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              GestureDetector(
                onTap: () => Scaffold.of(context).openEndDrawer(),
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Utils.dynamicPrimaryColor(context)),
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(Language.filter.capitalizeByWord()),
                    )),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LazyLoadScrollView(
            onEndOfPage: () {
              context.read<CategoryCubit>().loadCategoryProducts(slug, page++);
            },
            scrollOffset: 100,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: GridView.builder(
                itemCount: categoryProduct.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 230,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(productModel: categoryProduct[index]);
                },

                // delegate: SliverChildBuilderDelegate(
                //       (BuildContext context, int index) {
                //     return ;
                //   },
                //   childCount: categoryProduct.length,
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
