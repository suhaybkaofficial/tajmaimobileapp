part of 'wish_list_cubit.dart';

abstract class WishListState extends Equatable {
  const WishListState();

  @override
  List<Object> get props => [];
}

class WishListStateInitial extends WishListState {
  const WishListStateInitial();
}

class WishListStateLoading extends WishListState {
  const WishListStateLoading();
}

class WishListStateAddRemoving extends WishListState {
  const WishListStateAddRemoving();
}

class WishListStateSuccess extends WishListState {
  final String message;
  const WishListStateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WishListStateAddRemoveError extends WishListState {
  final String message;
  final int statusCode;
  const WishListStateAddRemoveError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class WishListStateError extends WishListState {
  final String message;
  final int statusCode;
  const WishListStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class WishListStateLoaded extends WishListState {
  final List<WishListModel> productList;
  const WishListStateLoaded(this.productList);

  @override
  List<Object> get props => [productList];
}
