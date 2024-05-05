import 'package:flutter/material.dart';

import '/utils/language_string.dart';
import '/utils/lazy_loader.dart';
import '/widgets/capitalized_word.dart';
import '../../../utils/constants.dart';

class DetailsPageLoading extends StatelessWidget {
  const DetailsPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: borderColor.withOpacity(.2),
          title: Text(Language.productDetails.capitalizeByWord()),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const SizedBox(
                  child: ShimmerLoader(
                    height: 300,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(
                  child: ShimmerLoader(
                    height: 20,
                    width: 70,
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(
                  child: ShimmerLoader(
                    height: 15,
                    width: 100,
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(
                  child: ShimmerLoader(
                    height: 20,
                    width: 200,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    ...List.generate(
                      4,
                      (index) => const Column(
                        children: [
                          SizedBox(height: 10),
                          SizedBox(
                            child: ShimmerLoader(
                              height: 10,
                              width: double.infinity,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(Language.relatedProduct.capitalizeByWord()),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(
                          4,
                          (index) => Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: const ShimmerLoader(
                              height: 150,
                              width: 150,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
