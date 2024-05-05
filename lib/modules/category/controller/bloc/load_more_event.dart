part of 'load_more_bloc.dart';

abstract class LoadMoreEvent extends Equatable {
  const LoadMoreEvent();

  @override
  List<Object> get props => [];
}


class FetchMoreData extends LoadMoreEvent{}
