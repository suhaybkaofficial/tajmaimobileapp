import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/modules/category/controller/repository/category_repository.dart';
import '/modules/category/model/sub_category_model.dart';

import '../../../../home/model/product_model.dart';
import '../../../model/child_category_model.dart';

part 'sub_category_state.dart';

class SubCategoryCubit extends Cubit<SubCategoryState> {
  SubCategoryCubit(CategoryRepository categoryRepository)
      : _categoryRepository = categoryRepository,
        super(SubCategoryLoadingState());

  final CategoryRepository _categoryRepository;
  late List<SubCategoryModel> subCategoryList;
  late List<ChildCategoryModel> childCategoryList;
  late List<ProductModel> subCategoryProductsList;

  Future<void> getSubCategoryList(String id) async {
    emit(SubCategoryLoadingState());

    final result = await _categoryRepository.getSubCategoryList(id);
    result.fold(
      (failuer) {
        emit(SubCategoryErrorState(errorMessage: failuer.message));
      },
      (data) {
        subCategoryList = data;

        emit(SubCategoryListLoadedState(subCategoryList: data));


      },
    );
  }

  Future<void> getSubCategoryProduct(String slug) async {
    emit(SubCategoryLoadingState());

    final result = await _categoryRepository.getSubCategoryProducts(slug);
    result.fold(
          (failuer) {
        emit(SubCategoryErrorState(errorMessage: failuer.message));
      },
          (data) {
        subCategoryProductsList = data;
        emit(SubCategoryProductsLoadedState(subCategoryProducts: data));
      },
    );
  }
}
