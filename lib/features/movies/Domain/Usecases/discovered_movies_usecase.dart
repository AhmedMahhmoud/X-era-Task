import 'package:dartz/dartz.dart';
import 'package:xera_task/Core/Failure/failures.dart';
import 'package:xera_task/features/movies/Domain/Entities/movies_entity.dart';
import 'package:xera_task/features/movies/Domain/Repositories/movies_repository.dart';

class GetDiscoveredMoviesUsecase {
  final MoviesRepository moviesRepository;
  GetDiscoveredMoviesUsecase(this.moviesRepository);

  Future<Either<Failure, List<MoviesEntity>>> call() async {
    return await moviesRepository.getDiscoveredMovies();
  }
}
