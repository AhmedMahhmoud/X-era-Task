// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xera_task/features/movies/Domain/Usecases/search_movies_by_name_usecase.dart';

import '../../../../../../../Core/Failure/exceptions.dart';
import '../../../../../../../Core/Failure/failures.dart';
import '../../../../Domain/Entities/movies_entity.dart';
part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovieByNameUsecase searchMovieUsecase;
  SearchMoviesBloc({required this.searchMovieUsecase})
      : super(MoviesInitial()) {
    on<SearchMoviesEvent>((event, emit) async {
      if (event is SearchMoviesByName) {
        emit(SearchMovieLoadingState());
        final failOrSuccessMovie =
            await searchMovieUsecase(event.movieName, event.pageIndex);
        failOrSuccessMovie.fold((error) {
          emit(SearchMovieErrorState(message: _mapFailureToMessage(error)));
        }, (moviesList) => emit(SearchMovieLoadedState(movies: moviesList)));
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
