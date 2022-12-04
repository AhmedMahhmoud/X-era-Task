part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesDiscoverLoadingState extends MoviesState {}

class MoviesDiscoverLoadedState extends MoviesState {
  final List<MoviesEntity> movies;
  const MoviesDiscoverLoadedState({required this.movies});
  @override
  List<Object> get props => [movies];
}

class MoviesDiscoverErrorState extends MoviesState {
  final String message;
  const MoviesDiscoverErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
