import 'package:flutter/material.dart';
import '../../widgets/rounded_app_bar.dart';
import '../home/model/product_model.dart';
import 'component/product_card.dart';

class AllFlashDealProductScreen extends StatelessWidget {
  const AllFlashDealProductScreen({
    Key? key,
    required this.products,
  }) : super(key: key);
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
        titleText: "Flash Deal",
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: products.isEmpty
          ? const Center(child: Text("No Item"))
          : _buildProductGrid(),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        mainAxisExtent: 210,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      itemCount: products.length,
      itemBuilder: (context, index) =>
          ProductCard(productModel: products[index]),
    );
  }
}
