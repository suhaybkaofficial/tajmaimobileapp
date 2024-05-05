import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/widgets/capitalized_word.dart';

import '../../utils/language_string.dart';
import '../../widgets/rounded_app_bar.dart';
import 'component/single_circuler_card.dart';
import 'controller/cubit/category_cubit.dart';

class AllCategoryListScreen extends StatelessWidget {
  const AllCategoryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CategoryCubit>().getCategoryList();
    return Scaffold(
      appBar: RoundedAppBar(
        titleText: Language.allCategories.capitalizeByWord(),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryListLoadedState ||
              state is CategoryLoadedState) {
            final categories = context.read<CategoryCubit>().categoryList;
            if (categories.isEmpty) {
              return  Center(child: Text(Language.noCategory.capitalizeByWord()));
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                mainAxisExtent: 130,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryCircleCard(
                  categoriesModel: categories[index],
                );
              },
            );
          } else if (state is CategoryErrorState) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          return  Center(
            child: SizedBox(
              child: Text(Language.somethingWentWrong.capitalizeByWord()),
            ),
          );
        },
      ),
    );
  }
}
