import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';

import '../../widgets/rounded_app_bar.dart';
import '../home/controller/cubit/products_cubit.dart';
import 'component/populer_product_card.dart';

class AllPopularProductScreen extends StatefulWidget {
  const AllPopularProductScreen({Key? key}) : super(key: key);

  @override
  State<AllPopularProductScreen> createState() =>
      _AllPopularProductScreenState();
}

class _AllPopularProductScreenState extends State<AllPopularProductScreen> {
  final scrollController = ScrollController();
  bool hasMoreDataLoading = false;
  int page = 1;
  int perPage = 10;

  // late Map<String,dynamic> receivedName;
  // late String keyword;
  // late String title;

  @override
  void initState() {
    super.initState();

    // scrollController.addListener(_handleScroll);
  }

  // void _handleScroll() {
  //   if (scrollController.position.extentAfter < 100) {
  //     page++;
  //     context
  //         .read<ProductsCubit>()
  //         .loadMoreData(widget.keyword!, page, perPage);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final receivedName =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // final title = receivedName['title'] as String;
    final receivedName =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final keyword = receivedName['keyword'];
    final title = receivedName['title'];
    context.read<ProductsCubit>().getHighlightedProduct(keyword);
    return Scaffold(
      appBar: RoundedAppBar(
        titleText: title,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body:
          BlocBuilder<ProductsCubit, ProductsState>(builder: (context, state) {
        if (state is ProductsStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductsStateError) {
        } else if (state is ProductsStateLoaded) {
          if (state.highlightedProducts.isEmpty) {
            return Center(
              child: Text(Language.noItemsFound.capitalizeByWord()),
            );
          } else {
            return LazyLoadScrollView(
              onEndOfPage: () {
                context
                    .read<ProductsCubit>()
                    .loadMoreData(keyword, page++, perPage);
              },
              scrollOffset: 100,
              child: ListView.builder(
                // controller: scrollController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                itemCount: state.highlightedProducts.length,
                itemBuilder: (context, index) => PopulerProductCard(
                    productModel: state.highlightedProducts[index]),
              ),
            );
          }
        }
        return const SizedBox();
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
