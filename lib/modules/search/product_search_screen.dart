import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../category/component/product_card.dart';
import 'components/rounded_app_bar.dart';
import 'controllers/search/search_bloc.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({Key? key}) : super(key: key);

  @override
  State<ProductSearchScreen> createState() => ProductSearchScreenState();
}

class ProductSearchScreenState extends State<ProductSearchScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    _controller.addListener(() {
      final maxExtent = _controller.position.maxScrollExtent - 200;
      if (maxExtent < _controller.position.pixels) {
        searchBloc.add(const SearchEventLoadMore());
      }
    });
  }

  final searchCtr = TextEditingController();
  final _controller = ScrollController();

  late SearchBloc searchBloc;

  @override
  void dispose() {
    super.dispose();

    searchBloc.products.clear();
  }

  @override
  Widget build(BuildContext context) {
    searchBloc = context.read<SearchBloc>();

    return Scaffold(
      appBar: SearchAppBar(
        titleWidget: Container(
          margin: const EdgeInsets.only(right: 20),
          height: 40,
          child: TextFormField(
            controller: searchCtr,
            textInputAction: TextInputAction.done,
            autofocus: true,
            onChanged: (v) {
              if (v.isEmpty) return;
              context.read<SearchBloc>().add(SearchEventSearch(v.trim()));
            },
            onFieldSubmitted: (v) {
              if (v.isEmpty) return;
              context.read<SearchBloc>().add(SearchEventSearch(v.trim()));
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(8),
              hintText: "Search here",
            ),
          ),
        ),
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is SearchStateMoreError) {
            Utils.errorSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          final products = searchBloc.products;
          if (searchBloc.products.isEmpty && state is SearchStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchStateError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: redColor),
                  ),
                ),
              ],
            );
          }
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  controller: _controller,
                  padding: const EdgeInsets.all(15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 230,
                  ),
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductCard(productModel: products[index]);
                  },
                ),
              ),
              if (state is SearchStateLoadMore)
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const CircularProgressIndicator()),
            ],
          );
        },
      ),
    );
  }
}
