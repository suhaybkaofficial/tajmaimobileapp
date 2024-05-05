part of 'inbox_cubit.dart';

abstract class InboxState extends Equatable {
  const InboxState();

  @override
  List<Object> get props => [];
}

class InboxInitial extends InboxState {}
class InboxDataLoading extends InboxState {}
class InboxDataError extends InboxState {}
class InboxDataLoaded extends InboxState {}
class InboxProductDataLoaded extends InboxState {
  final ProductDetailsModel productModel;
  const InboxProductDataLoaded(this.productModel);

  @override
  List<Object> get props => [productModel];
}

