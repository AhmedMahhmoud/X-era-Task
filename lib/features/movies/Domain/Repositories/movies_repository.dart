import 'package:dartz/dartz.dart';
import 'package:xera_task/Core/Failure/failures.dart';
import 'package:xera_task/features/movies/Domain/Entities/movies_entity.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<MoviesEntity>>> getDiscoveredMovies();
  Future<Either<Failure, List<MoviesEntity>>> searchMoviesByName(
      String movieName);
}
