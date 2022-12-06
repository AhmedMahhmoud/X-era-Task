part of 'discover_movies_bloc.dart';

abstract class DiscoveredMoviesEvent extends Equatable {
  const DiscoveredMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetAllDiscoveredMovies extends DiscoveredMoviesEvent {}
