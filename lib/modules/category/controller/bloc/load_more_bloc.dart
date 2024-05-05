import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'load_more_event.dart';
part 'load_more_state.dart';

class LoadMoreBloc extends Bloc<LoadMoreEvent, LoadMoreState> {
  LoadMoreBloc() : super(LoadMoreInitial()) {
    on<LoadMoreEvent>((event, emit) {
    
    });
  }
}
