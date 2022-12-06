// ignore: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:xera_task/features/movies/Domain/Usecases/search_movies_by_name_usecase.dart';

import '../../../../../../../Core/Failure/exceptions.dart';
import '../../../../../../../Core/Failure/failures.dart';
import '../../../../Domain/Entities/movies_entity.dart';
import '../../../cubit/movies/SearchMovies/search_movies_bloc.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovieByNameUsecase searchMovieUsecase;
  List<MoviesEntity> movies = [];
  int pageNumber = 1;
  SearchMoviesBloc({required this.searchMovieUsecase})
      : super(SearchMoviesInitial()) {
    on<SearchMoviesEvent>((event, emit) async {
      if (event is SearchMoviesByName) {
        emit(SearchMovieLoadingState());
        final failOrSuccessMovie = await searchMovieUsecase(event.movieName, 1);
        failOrSuccessMovie.fold((error) {
          emit(SearchMovieErrorState(message: _mapFailureToMessage(error)));
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
              message: _mapFailureToMessage(error)));
        }, (moviesList) {
          emit(SearchMoviePaginatedLoadedState());
          movies.addAll(moviesList);
        });
      } else if (event is ResetMovies) {
        emit(SearchMoviesInitial());
      }
    });
  }
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return failure.props.toString();
    }
  }
}
