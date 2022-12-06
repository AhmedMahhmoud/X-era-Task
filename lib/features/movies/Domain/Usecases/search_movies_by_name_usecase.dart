import 'package:dartz/dartz.dart';
import 'package:xera_task/Core/Failure/failures.dart';
import 'package:xera_task/features/movies/Domain/Entities/movies_entity.dart';
import 'package:xera_task/features/movies/Domain/Repositories/movies_repository.dart';

class SearchMovieByNameUsecase {
  final MoviesRepository moviesRepository;
  SearchMovieByNameUsecase(this.moviesRepository);
  Future<Either<Failure, List<MoviesEntity>>> call(
      String movieName, int pageIndex) async {
    return await moviesRepository.searchMoviesByName(movieName, pageIndex);
  }
}
