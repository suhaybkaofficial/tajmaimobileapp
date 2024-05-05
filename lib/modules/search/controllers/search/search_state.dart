part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchStateInitial extends SearchState {
  const SearchStateInitial();
}

class SearchStateLoading extends SearchState {
  const SearchStateLoading();
}

class SearchStateLoadMore extends SearchState {
  const SearchStateLoadMore();
}

class SearchStateError extends SearchState {
  final String message;
  final int statusCode;

  const SearchStateError(this.message, this.statusCode);
  @override
  List<Object> get props => [message, statusCode];
}

class SearchStateMoreError extends SearchState {
  final String message;
  final int statusCode;

  const SearchStateMoreError(this.message, this.statusCode);
  @override
  List<Object> get props => [message, statusCode];
}

class SearchStateLoaded extends SearchState {
  final List<ProductModel> products;
  const SearchStateLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class SearchStateMoreLoaded extends SearchState {
  final List<ProductModel> products;
  const SearchStateMoreLoaded(this.products);

  @override
  List<Object> get props => [products];
}
