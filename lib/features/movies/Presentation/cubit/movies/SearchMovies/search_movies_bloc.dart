// ignore: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xera_task/features/movies/Domain/Usecases/search_movies_by_name_usecase.dart';

import '../../../../../../Core/Shared/FaliureWidgets/display_failure.dart';
import '../../../../Domain/Entities/movies_entity.dart';
part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovieByNameUsecase searchMovieUsecase;
  List<MoviesEntity> movies = [];
  SearchMoviesBloc({required this.searchMovieUsecase})
      : super(SearchMoviesInitial()) {
    on<SearchMoviesEvent>((event, emit) async {
      if (event is SearchMoviesByName) {
        emit(SearchMovieLoadingState());
        final failOrSuccessMovie = await searchMovieUsecase(event.movieName, 1);
        failOrSuccessMovie.fold((error) {
          emit(SearchMovieErrorState(message: mapFailureToMessage(error)));
        }, (moviesList) {
          emit(SearchMovieLoadedState(movies: moviesList));
          movies = moviesList;
        });
      } else if (event is SearchMoviesByNamePaginated) {
        emit(SearchMoviePaginatedLoadingState());
        final failOrSuccessMovie =
            await searchMovieUsecase(event.movieName, event.pageIndex);
        failOrSuccessMovie.fold((error) {
          emit(SearchMoviePaginatedErrorState(
              message: mapFailureToMessage(error)));
        }, (moviesList) {
          emit(SearchMoviePaginatedLoadedState());
          movies.addAll(moviesList);
        });
      } else if (event is ResetMovies) {
        emit(SearchMoviesInitial());
      }
    });
  }
}
