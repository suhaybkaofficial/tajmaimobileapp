import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../model/child_category_model.dart';
import '../../repository/category_repository.dart';

part 'child_state.dart';

class ChildCubit extends Cubit<ChildCategoryState> {
  ChildCubit(CategoryRepository categoryRepository)
      : _categoryRepository = categoryRepository,
        super(ChildStateLoding());

  final CategoryRepository _categoryRepository;
  late List<ChildCategoryModel> childCategoryList;

  Future<void> getChildCategoryList(String id) async {
    emit(ChildStateLoding());

    final result = await _categoryRepository.getChildCategoryList(id);
    result.fold(
      (failuer) {
        emit(ChildCategoryErrorState(errorMessage: failuer.message));
      },
      (data) {
        childCategoryList = data;

        emit(ChildCategoryListLoadedState(childCategoryList: data));
      },
    );
  }
}
