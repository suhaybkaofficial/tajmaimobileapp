import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '/modules/category/controller/cubit/category_cubit.dart';
import '/modules/home/controller/cubit/products_cubit.dart';

import '../category/component/product_card.dart';

class BannerProductScreen extends StatelessWidget {
  const BannerProductScreen({Key? key, this.slug}) : super(key: key);
  final String? slug;

  @override
  Widget build(BuildContext context) {
    context.read<CategoryCubit>().getCategoryProduct(slug!, 1);
    int page = 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banner Products'),
        backgroundColor: Colors.white.withOpacity(0.5),
      ),
      body:
          BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
        if (state is CategoryLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoryErrorState) {
          return Center(child: Text(state.errorMessage));
        } else if (state is CategoryLoadedState) {
          return LazyLoadScrollView(
            onEndOfPage: () {
              context.read<CategoryCubit>().loadCategoryProducts(slug!, page++);
            },
            scrollOffset: 300,
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        mainAxisExtent: 230,
                      ),
                      itemCount: state.categoryProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                            productModel: state.categoryProducts[index]);
                      }),
                )
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      }),
      bottomNavigationBar: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsStateMoreDataLoading) {
            return Container(
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
