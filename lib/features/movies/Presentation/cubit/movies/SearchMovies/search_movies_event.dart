part of 'search_movies_bloc.dart';

abstract class SearchMoviesEvent extends Equatable {
  const SearchMoviesEvent();

  @override
  List<Object> get props => [];
}

class SearchMoviesByName extends SearchMoviesEvent {
  final String movieName;

  const SearchMoviesByName({required this.movieName});
  @override
  List<Object> get props => [movieName,];
}

class SearchMoviesByNamePaginated extends SearchMoviesEvent {
  final String movieName;
  final int pageIndex;
  const SearchMoviesByNamePaginated({required this.movieName,required this.pageIndex});
  @override
  List<Object> get props => [movieName,pageIndex];
}

class ResetMovies extends SearchMoviesEvent {}
