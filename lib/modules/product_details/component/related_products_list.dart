import 'package:flutter/material.dart';
import 'package:shop_o/utils/language_string.dart';
import 'package:shop_o/widgets/capitalized_word.dart';

import '../../home/component/section_header.dart';
import '../model/product_details_product_model.dart';
import 'related_single_product_card.dart';

class RelatedProductsList extends StatelessWidget {
  const RelatedProductsList(
    this.relatedProducts, {
    Key? key,
  }) : super(key: key);
  final List<ProductDetailsProductModel> relatedProducts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: SectionHeader(
            headerText: Language.relatedProduct.capitalizeByWord(),
            onTap: () {},
            isSeeAllShow: false,
          ),
        ),
        SizedBox(
          height: 235,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            itemCount: relatedProducts.length,
            itemBuilder: (context, index) => RelatedSingleProductCard(
                productModel: relatedProducts[index], width: 180),
          ),
        ),
      ],
    );
  }
}
