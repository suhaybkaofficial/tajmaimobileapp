import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../core/router_name.dart';
import '../model/home_seller_model.dart';
import 'section_header.dart';
import 'single_circuler_seller.dart';

class BestSellerGridView extends StatelessWidget {
  const BestSellerGridView({
    Key? key,
    required this.sectionTitle,
    required this.sellers,
  }) : super(key: key);
  final List<HomeSellerModel> sellers;
  final String sectionTitle;

  @override
  Widget build(BuildContext context) {
    if (sellers.isEmpty) return const SliverToBoxAdapter();
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 10,left: 0,right: 0),
      sliver: MultiSliver(
        children: [
          SliverToBoxAdapter(
            child: SectionHeader(
              headerText: sectionTitle,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.allSellerList,
                arguments: sellers);
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) =>
                  SingleCircularSeller(seller: sellers[index]),
              childCount: sellers.length,
            ),
          ),

        ],
      ),
    );
  }
}
