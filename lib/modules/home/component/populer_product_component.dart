import 'package:flutter/material.dart';
import '../../category/component/product_card.dart';
import '../model/product_model.dart';
import 'section_header.dart';

class HorizontalProductComponent extends StatelessWidget {
  const HorizontalProductComponent({
    Key? key,
    required this.productList,
    required this.category,
    this.bgColor,
    this.onTap,
  }) : super(key: key);
  final List<ProductModel> productList;
  final String category;
  final Color? bgColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {

    if (productList.isEmpty) return const SliverToBoxAdapter();

    return SliverToBoxAdapter(
      child: Container(
        color: bgColor,
        margin: const EdgeInsets.symmetric(vertical: 0),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            // const SizedBox(height: 10),
            SectionHeader(
              headerText: category,
              onTap: onTap,
            ),
            Container(
              height: 224,
              margin: const EdgeInsets.only(top: 14, bottom: 0),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    ProductCard(productModel: productList[index], width: 180),
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemCount: productList.length > 5 ? 5 : productList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
