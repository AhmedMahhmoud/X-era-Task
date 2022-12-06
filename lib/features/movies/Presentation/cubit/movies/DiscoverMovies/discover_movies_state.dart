part of 'discover_movies_bloc.dart';

abstract class DiscoveredMoviesState extends Equatable {
  const DiscoveredMoviesState();

  @override
  List<Object> get props => [];
}

class MoviesInitial extends DiscoveredMoviesState {}

class MoviesDiscoverLoadingState extends DiscoveredMoviesState {}

class MoviesDiscoverLoadedState extends DiscoveredMoviesState {
  final List<MoviesEntity> movies;
  const MoviesDiscoverLoadedState({required this.movies});
  @override
  List<Object> get props => [movies];
}

class MoviesDiscoverErrorState extends DiscoveredMoviesState {
  final String message;
  const MoviesDiscoverErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
