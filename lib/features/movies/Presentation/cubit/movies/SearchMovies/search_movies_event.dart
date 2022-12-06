part of 'search_movies_bloc.dart';

abstract class SearchMoviesEvent extends Equatable {
  const SearchMoviesEvent();

  @override
  List<Object> get props => [];
}

class SearchMoviesByName extends SearchMoviesEvent {
  final String movieName;
  final int pageIndex;
  const SearchMoviesByName({required this.movieName, required this.pageIndex});
  @override
  List<Object> get props => [movieName, pageIndex];
}
