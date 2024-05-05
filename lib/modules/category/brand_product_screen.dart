import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../widgets/rounded_app_bar.dart';
import 'component/product_card.dart';
import 'controller/cubit/category_cubit.dart';

class BrandProductScreen extends StatefulWidget {
  const BrandProductScreen({
    Key? key,
    required this.slug,
  }) : super(key: key);
  final String slug;

  @override
  State<BrandProductScreen> createState() =>
      _SingleCategoryProductScreenState();
}

class _SingleCategoryProductScreenState extends State<BrandProductScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<CategoryCubit>().getBrandProduct(widget.slug);

    return Scaffold(
        appBar: RoundedAppBar(
          titleText: widget.slug.capitalizeByWord(),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        body: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoryLoadedState) {
              if (state.categoryProducts.isEmpty) {
                return  Center(child: Text(Language.noItemsFound.capitalizeByWord()));
              }
              // _buildProductGrid(state.productCategoriesModel.products);
              return const CategoryLoad();
            } else if (state is CategoryErrorState) {
              return Center(
                child: Text(state.errorMessage),
              );
            }
            return  Center(
              child: SizedBox(
                child: Text(Language.somethingWentWrong),
              ),
            );
          },
        ));
  }
}

class CategoryLoad extends StatelessWidget {
  const CategoryLoad({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brandProducts = context.read<CategoryCubit>().brandProducts;
    return CustomScrollView(slivers: [
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        sliver: MultiSliver(
          children: [
            const SizedBox(height: 10),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 230,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ProductCard(productModel: brandProducts[index]);
                },
                childCount: brandProducts.length,
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
