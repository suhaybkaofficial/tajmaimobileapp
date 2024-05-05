part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchEventSearch extends SearchEvent {
  final String search;
  const SearchEventSearch(this.search);

  @override
  List<Object> get props => [search];
}

class SearchEventLoadMore extends SearchEvent {
  const SearchEventLoadMore();
}
