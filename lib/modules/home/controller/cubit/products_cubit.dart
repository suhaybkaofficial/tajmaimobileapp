import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/modules/home/model/product_model.dart';

import '../repository/home_repository.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(HomeRepository homeRepository)
      : _homeRepository = homeRepository,
        super(ProductsInitial());

  final HomeRepository _homeRepository;
  late List<ProductModel> hightlightedProducts = [];

  Future<void> getHighlightedProduct(String keyword) async {
    emit(ProductsStateLoading());

    final result = await _homeRepository.getHighlightProducts(keyword);
    result.fold(
      (failuer) {
        emit(ProductsStateError(errorMessage: failuer.message));
      },
      (data) {
        hightlightedProducts.addAll(data);
        emit(ProductsStateLoaded(highlightedProducts: hightlightedProducts));
      },
    );
  }

  Future<void> loadMoreData(String keyword, int page, int perPage) async {
    emit(ProductsStateMoreDataLoading());

    final result = await _homeRepository.loadMoreProducts(keyword,page, perPage);
    result.fold(
          (failure) {
        emit(ProductsStateError(errorMessage: failure.message));
      },
          (data) {
            if(data.isNotEmpty){
              hightlightedProducts.addAll(data);
            }else{
              hightlightedProducts = data;
            }

        emit(ProductsStateLoaded(highlightedProducts: hightlightedProducts));
      },
    );
  }
}
