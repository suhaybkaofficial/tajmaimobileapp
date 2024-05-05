part of 'products_cubit.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}
class ProductsStateLoading extends ProductsState {}
class ProductsStateMoreDataLoading extends ProductsState {}

class ProductsStateError extends ProductsState {
  final String errorMessage;
  const ProductsStateError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
class ProductsStateLoaded extends ProductsState {
  final List<ProductModel> highlightedProducts;
  const ProductsStateLoaded({required this.highlightedProducts});

  @override
  List<Object> get props => [highlightedProducts];
}
