import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';

import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/rounded_app_bar.dart';
import '../component/wish_list_card.dart';
import 'controllers/wish_list/wish_list_cubit.dart';
import 'model/wish_list_model.dart';

class WishlistOfferScreen extends StatefulWidget {
  const WishlistOfferScreen({Key? key}) : super(key: key);

  @override
  State<WishlistOfferScreen> createState() => _WishlistOfferScreenState();
}

class _WishlistOfferScreenState extends State<WishlistOfferScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WishListCubit>().getWishList();
      context.read<WishListCubit>().selectedId.clear();
      context.read<WishListCubit>().wishList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: bgColor,
      appBar: RoundedAppBar(titleText: Language.wishlist.capitalizeByWord()),
      body: BlocConsumer<WishListCubit, WishListState>(
        listener: (context, state) {
          if (state is WishListStateAddRemoveError) {
            Utils.errorSnackBar(context, state.message);
          } else if (state is WishListStateSuccess) {
            Utils.showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          log(state.toString(), name: 'wishlist offer screen');
          if (state is WishListStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WishListStateError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: redColor),
              ),
            );
          } else if (state is WishListStateInitial) {
            return const SizedBox();
          }
          return const _LoadedWidget();
        },
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        child: TextButton(
          style: TextButton.styleFrom(foregroundColor: redColor),
          onPressed: () {
            context.read<WishListCubit>().clearWishList();
          },
          child: Text(
            Language.clearWishlist.capitalizeByWord(),
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}

class _LoadedWidget extends StatefulWidget {
  const _LoadedWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_LoadedWidget> createState() => __LoadedWidgetState();
}

class __LoadedWidgetState extends State<_LoadedWidget> {
  List<WishListModel> productList = [];

  @override
  void initState() {
    super.initState();
    productList = context.read<WishListCubit>().wishList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Icon(Icons.favorite, color: redColor),
              const SizedBox(width: 10),
              Text(
                _getText(productList.length),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (productList.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              Language.swipeToDelete.capitalizeByWord(),
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: grayColor,
                  ),
            ),
          ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (_, __) {
              return const SizedBox(height: 16);
            },
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.horizontal,
                onDismissed: (s) async {
                  final item = productList.removeAt(index);
                  setState(() {});
                  final result =
                      await context.read<WishListCubit>().removeWishList(item);
                  result.fold(
                    (failure) {
                      productList.add(item);
                      setState(() {});
                      Utils.errorSnackBar(context, failure.message);
                    },
                    (success) {
                      Utils.showSnackBar(context, success);
                    },
                  );
                },
                background: Container(
                  decoration: BoxDecoration(
                    color: redColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.only(right: 40),
                  alignment: Alignment.centerRight,
                  child: const Icon(
                    Icons.delete,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                child: WishListCard(product: productList[index]),
              );
            },
            itemCount: productList.length,
          ),
        ),
      ],
    );
  }

  //
  // Widget _buildBottomButtons() {
  //   return Container(
  //       alignment: Alignment.center,
  //       child: TextButton(onPressed: (){}, child: const Text("Clear Wishlist")));
  // }

  String _getText(int length) {
    if (length > 1) {
      return '${productList.length} ${Language.itemsInYourCart.capitalizeByWord()}';
    } else {
      return '${productList.length} ${Language.itemInYourCart.capitalizeByWord()}';
    }
  }
}
