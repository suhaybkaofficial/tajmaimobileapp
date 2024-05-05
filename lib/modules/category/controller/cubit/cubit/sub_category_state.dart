part of 'sub_category_cubit.dart';

abstract class SubCategoryState extends Equatable {
  const SubCategoryState();

  @override
  List<Object> get props => [];
}

class SubCategoryInitial extends SubCategoryState {}

class SubCategoryLoadingState extends SubCategoryState {}

class SubCategoryErrorState extends SubCategoryState {
  final String errorMessage;

  const SubCategoryErrorState({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}

class SubCategoryListLoadedState extends SubCategoryState {
  final List<SubCategoryModel> subCategoryList;

  const SubCategoryListLoadedState({required this.subCategoryList});

  @override
  List<Object> get props => [subCategoryList];
}
class SubCategoryProductsLoadedState extends SubCategoryState {
  final List<ProductModel> subCategoryProducts;
  const SubCategoryProductsLoadedState({required this.subCategoryProducts});

  @override
  List<Object> get props => [subCategoryProducts];
}