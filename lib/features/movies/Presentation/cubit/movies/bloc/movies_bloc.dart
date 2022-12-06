// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:xera_task/features/movies/Domain/Usecases/discovered_movies_usecase.dart';
import '../../../../../../Core/Failure/exceptions.dart';
import '../../../../../../Core/Failure/failures.dart';
import '../../../../Domain/Entities/movies_entity.dart';
part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetDiscoveredMoviesUsecase discoverUsecase;

  MoviesBloc({required this.discoverUsecase}) : super(MoviesInitial()) {
    on<MoviesEvent>((event, emit) async {
      if (event is GetAllDiscoveredMovies) {
        emit(MoviesDiscoverLoadingState());
        final failOrSuccessMovie = await discoverUsecase();
        failOrSuccessMovie.fold((error) {
          emit(MoviesDiscoverErrorState(message: _mapFailureToMessage(error)));
        }, (moviesList) => emit(MoviesDiscoverLoadedState(movies: moviesList)));
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
