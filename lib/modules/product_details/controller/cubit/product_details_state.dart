part of 'product_details_cubit.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

class ProductDetailsStateLoading extends ProductDetailsState {}

class ProductDetailsStateError extends ProductDetailsState {
  final String errorMessage;
  final int statusCode;
  const ProductDetailsStateError(this.errorMessage, this.statusCode);

  @override
  List<Object> get props => [errorMessage, statusCode];
}

class ProductDetailsStateLoaded extends ProductDetailsState {
  final ProductDetailsModel productDetailsModel;
  const ProductDetailsStateLoaded(this.productDetailsModel);

  @override
  List<Object> get props => [productDetailsModel];
}
