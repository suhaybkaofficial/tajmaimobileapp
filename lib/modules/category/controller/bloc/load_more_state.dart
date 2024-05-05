part of 'load_more_bloc.dart';

abstract class LoadMoreState extends Equatable {
  const LoadMoreState();
  
  @override
  List<Object> get props => [];
}

class LoadMoreInitial extends LoadMoreState {}
