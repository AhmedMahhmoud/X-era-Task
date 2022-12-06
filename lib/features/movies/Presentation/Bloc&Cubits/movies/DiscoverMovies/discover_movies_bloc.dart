// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:xera_task/features/movies/Domain/Usecases/discovered_movies_usecase.dart';
import '../../../../../../Core/Failure/exceptions.dart';
import '../../../../../../Core/Failure/failures.dart';
import '../../../cubit/movies/DiscoverMovies/discover_movies_bloc.dart';

class DiscoverMoviesBloc
    extends Bloc<DiscoveredMoviesEvent, DiscoveredMoviesState> {
  final GetDiscoveredMoviesUsecase discoverUsecase;
  DiscoverMoviesBloc({
    required this.discoverUsecase,
  }) : super(MoviesInitial()) {
    on<DiscoveredMoviesEvent>((event, emit) async {
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
