part of 'child_cubit.dart';

abstract class ChildCategoryState extends Equatable {
  const ChildCategoryState();

  @override
  List<Object> get props => [];
}

class ChildStateInitial extends ChildCategoryState {}

class ChildStateLoding extends ChildCategoryState {}

class ChildCategoryErrorState extends ChildCategoryState {
  final String errorMessage;

  const ChildCategoryErrorState({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}

class ChildCategoryListLoadedState extends ChildCategoryState {
  final List<ChildCategoryModel> childCategoryList;

  const ChildCategoryListLoadedState({required this.childCategoryList});

  @override
  List<Object> get props => [childCategoryList];
}
