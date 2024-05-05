import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/product_details_model.dart';
import '../repository/product_details_repository.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this.repository) : super(ProductDetailsStateLoading());

  final ProductDetailsRepository repository;
  ProductDetailsModel? productDetails;

  Future<void> getProductDetails(String slug) async {
    emit(ProductDetailsStateLoading());

    final result = await repository.getProductDetails(slug);
    result.fold(
      (failuer) {
        emit(ProductDetailsStateError(failuer.message, failuer.statusCode));
      },
      (data) {
        productDetails = data;
        emit(ProductDetailsStateLoaded(data));
      },
    );
  }
}
