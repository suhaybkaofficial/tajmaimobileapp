import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '/modules/authentication/controller/login/login_bloc.dart';
import '/modules/message/controller/bloc/bloc/chat_bloc.dart';
import '/modules/message/controller/cubit/inbox_cubit.dart';
import '/modules/product_details/component/loader_screen.dart';
import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../../core/router_name.dart';
import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../../utils/laravel_echo/laravel_echo.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/toggle_button_component.dart';
import '../cart/controllers/cart/cart_cubit.dart';
import '../home/component/home_app_bar.dart';
import '../message/models/inbox_seller.dart';
import 'component/bottom_sheet_widget.dart';
import 'component/description_component.dart';
import 'component/product_details_component.dart';
import 'component/product_header_component.dart';
import 'component/rating_list_component.dart';
import 'component/related_products_list.dart';
import 'component/seller_info_component.dart';
import 'component/video_component.dart';
import 'controller/cubit/product_details_cubit.dart';
import 'model/product_details_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.slug});

  final String slug;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<ProductDetailsCubit>().getProductDetails(widget.slug));
  }

  final _className = 'ProductDetailsScreen';

  @override
  Widget build(BuildContext context) {
    print('product-slug ${widget.slug}');
    final detailCubit = context.read<ProductDetailsCubit>();
    return Scaffold(
      body: Builder(builder: (context) {
        return BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
          listener: (context, state) {
            if (state is ProductDetailsStateError) {
              if (state.statusCode == 503 ||
                  detailCubit.productDetails == null) {
                detailCubit.getProductDetails(widget.slug);
              } else {
                Utils.errorSnackBar(context, state.errorMessage);
              }
            }
          },
          builder: (context, state) {
            if (state is ProductDetailsStateLoading) {
              return const Center(child: DetailsPageLoading());
            }
            if (state is ProductDetailsStateError) {
              if (state.statusCode == 503 ||
                  detailCubit.productDetails != null) {
                return _buildLoadedPage(detailCubit.productDetails!);
              } else {
                return Center(
                  child: Text(
                    state.errorMessage,
                    style: const TextStyle(color: redColor),
                  ),
                );
              }
            }
            if (state is ProductDetailsStateLoaded) {
              return _buildLoadedPage(state.productDetailsModel);
            }
            log(state.toString(), name: _className);
            if (detailCubit.productDetails != null) {
              return _buildLoadedPage(detailCubit.productDetails!);
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      }),
    );
  }

  Widget _buildLoadedPage(ProductDetailsModel productDetailsModel) {
    print('total-videos ${productDetailsModel.videos!.length}');
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: borderColor.withOpacity(.2),
              title: Text(Language.productDetails.capitalizeByWord()),
            ),
            SliverToBoxAdapter(
                child: ProductHeaderComponent(
                    productDetailsModel.product, productDetailsModel.gallery)),
            // const SliverToBoxAdapter(
            //   child: SizedBox(height: 0.0),
            // ),
            SliverToBoxAdapter(
              child: ProductDetailsComponent(
                detailsModel: productDetailsModel,
                product: productDetailsModel.product,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 25)),
            SliverToBoxAdapter(
              child: productDetailsModel.isSellerProduct == true
                  ? ToggleButtonComponent(
                      textList: [
                        Language.description.capitalizeByWord(),
                        '${Language.reviews.capitalizeByWord()} (${productDetailsModel.productReviews.length})',
                        Language.sellerInfo.capitalizeByWord(),
                      ],
                      initialLabelIndex: 0,
                      onChange: (int i) {
                        setState(() {
                          selectedIndex = i;
                        });
                      },
                    )
                  : productDetailsModel.videos!.isNotEmpty
                      ? ToggleButtonComponent(
                          textList: [
                            'Videos',
                            Language.description.capitalizeByWord(),
                            '${Language.reviews.capitalizeByWord()} (${productDetailsModel.productReviews.length})',
                          ],
                          initialLabelIndex: 0,
                          onChange: (int i) {
                            setState(() {
                              selectedIndex = i;
                            });
                          },
                        )
                      : ToggleButtonComponent(
                          textList: [
                            Language.description.capitalizeByWord(),
                            '${Language.reviews.capitalizeByWord()} (${productDetailsModel.productReviews.length})',
                          ],
                          initialLabelIndex: 0,
                          onChange: (int i) {
                            setState(() {
                              selectedIndex = i;
                            });
                          },
                        ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(child: getChild(productDetailsModel)),
            SliverToBoxAdapter(
              child: RelatedProductsList(productDetailsModel.relatedProducts),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 95)),
          ],
        ),
        _buildBottomButtons(productDetailsModel),
      ],
    );
  }

  Widget getChild(ProductDetailsModel productDetailsModel) {
    if (productDetailsModel.videos != null &&
            productDetailsModel.videos!.isNotEmpty
        ? selectedIndex == 0
        : selectedIndex == 1) {
      return VideoComponent(videos: productDetailsModel.videos!);
      // if (productDetailsModel.videos != null) {
      //   if (productDetailsModel.videos!.isNotEmpty) {
      //     return VideoComponent(videos: productDetailsModel.videos!);
      //   }
      // } else {
      //   return const SizedBox.shrink();
      // }
    } else if (productDetailsModel.videos != null &&
            productDetailsModel.videos!.isNotEmpty
        ? selectedIndex == 1
        : selectedIndex == 0) {
      return DescriptionComponent(productDetailsModel.product.longDescription);
    } else if (selectedIndex == 2) {
      return ReviewListComponent(productDetailsModel.productReviews);
    } else if (selectedIndex == 3) {
      return SellerInfo(productDetailsModel: productDetailsModel);
    }
    return const SizedBox();
  }

  Widget _buildBottomButtons(ProductDetailsModel productDetailsModel) {
    final loginBloc = context.read<LoginBloc>();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            offset: const Offset(-9, -1),
            blurRadius: 30,
            spreadRadius: 30,
          )
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
      ),
      child: Row(
        children: [
          if (productDetailsModel.sellerProfile != null)
            InkWell(
              onTap: () {
                context.read<InboxCubit>().loadProduct(productDetailsModel);
                context.read<ChatBloc>().add(SelectedSeller(
                      InboxSelectedSeller(
                        id: productDetailsModel.sellerProfile!.sellerUserId,
                        name: productDetailsModel.sellerProfile!.shopName,
                        image: productDetailsModel.sellerProfile!.bannerImage,
                      ),
                    ));
                // context.read<ChatBloc>().add(SendProductToSeller(productDetailsModel));
                LaravelEcho.init(
                    token: context.read<LoginBloc>().userInfo!.accessToken);
                Navigator.pushNamed(context, RouteNames.chatScreen);
              },
              child: Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: borderColor,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return SvgPicture.asset(Kimages.inboxActive);
                  },
                ),
              ),
            ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.cartScreen);
            },
            child: Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: BorderRadius.circular(0),
              ),
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return CartBadge(
                    count: context.read<CartCubit>().cartCount.toString(),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
            child: PrimaryButton(
              text: Language.addToCart.capitalizeByWord(),
              onPressed: () {
                if (loginBloc.userInfo != null) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(0),
                      ),
                    ),
                    builder: (_) =>
                        BottomSheetWidget(product: productDetailsModel.product),
                  );
                } else {
                  Utils.showSnackBarWithLogin(
                    context,
                    'Please login first',
                    () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteNames.authenticationScreen,
                      (route) => false,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
