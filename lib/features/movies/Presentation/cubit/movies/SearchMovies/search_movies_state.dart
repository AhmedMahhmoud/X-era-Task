part of 'search_movies_bloc.dart';

abstract class SearchMoviesState extends Equatable {
  const SearchMoviesState();

  @override
  List<Object> get props => [];
}

class SearchMoviesInitial extends SearchMoviesState {}

class SearchMovieLoadingState extends SearchMoviesState {}

class SearchMovieLoadedState extends SearchMoviesState {
  final List<MoviesEntity> movies;
  const SearchMovieLoadedState({required this.movies});
  @override
  List<Object> get props => [movies];
}

class SearchMovieErrorState extends SearchMoviesState {
  final String message;
  const SearchMovieErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class SearchMoviePaginatedLoadingState extends SearchMoviesState {}

class SearchMoviePaginatedLoadedState extends SearchMoviesState {}

class SearchMoviePaginatedErrorState extends SearchMoviesState {
  final String message;
  const SearchMoviePaginatedErrorState({required this.message});
   @override
  List<Object> get props => [message];

}
