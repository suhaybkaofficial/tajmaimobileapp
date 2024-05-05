import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../utils/k_images.dart';
import '../../../widgets/custom_image.dart';
import '../../category/component/product_card.dart';
import '../model/product_model.dart';

class NewArrivalComponent extends StatelessWidget {
  const NewArrivalComponent({
    Key? key,
    required this.productList,
    required this.sectionTitle,
  }) : super(key: key);
  final List<ProductModel> productList;
  final String sectionTitle;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: MultiSliver(
        children: [
           SliverToBoxAdapter(child: Text(sectionTitle, style: const TextStyle(fontSize: 18, height: 1.5, fontWeight: FontWeight.w600),)),
          const SliverToBoxAdapter(child: SizedBox(height: 15)),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              mainAxisExtent: 224,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) =>
                  ProductCard(productModel: productList[index]),
              childCount: productList.length > 8 ? 8 : productList.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _NewArrivalHeader extends StatefulWidget {
  const _NewArrivalHeader({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  State<_NewArrivalHeader> createState() => _NewArrivalHeaderState();
}

class _NewArrivalHeaderState extends State<_NewArrivalHeader> {
  final _controller = CustomPopupMenuController();

  final List<String> list = <String>[
    'New Arrival',
    'Top Products',
    'Best Sellings',
    'Discount Products',
    'Height Price',
    'Low Price',
    'Free Delivery'
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(
          widget.title,
          style: const TextStyle(fontSize: 18, height: 1.5, fontWeight: FontWeight.w600),
        ),
        CustomPopupMenu(
          pressType: PressType.singleClick,
          position: PreferredPosition.bottom,
          showArrow: false,
          verticalMargin: 4,
          controller: _controller,
          child: const SizedBox(
            height: 24,
            width: 24,
            child: Center(child: CustomImage(path: Kimages.menuIcon)),
          ),
          menuBuilder: () =>
              MenuItemListComponent(list: list, controller: _controller),
        ),
      ],
    );
  }
}

class MenuItemListComponent extends StatelessWidget {
  const MenuItemListComponent({
    Key? key,
    required this.controller,
    required this.list,
  }) : super(key: key);

  final List<String> list;
  final CustomPopupMenuController controller;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: Colors.white,
        width: 175,
        height: 280,
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(left: 12),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: list
              .map(
                (e) => InkWell(
                  onTap: () {
                    controller.hideMenu();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      e,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
