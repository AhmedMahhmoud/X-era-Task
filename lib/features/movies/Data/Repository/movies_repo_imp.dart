import 'package:xera_task/Core/Failure/exceptions.dart';
import 'package:xera_task/Core/Network/network.dart';
import 'package:xera_task/features/movies/Data/Datasource/movies_remote_datasource.dart';
import 'package:xera_task/features/movies/Domain/Entities/movies_entity.dart';
import 'package:xera_task/Core/Failure/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:xera_task/features/movies/Domain/Repositories/movies_repository.dart';

class MoviesRepoImp implements MoviesRepository {
  final NetworkInfo networkInfo;
  final MoviesRemoteDataSource remoteDataSrc;
  MoviesRepoImp({required this.networkInfo, required this.remoteDataSrc});
  @override
  Future<Either<Failure, List<MoviesEntity>>> getDiscoveredMovies() async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSrc.getDiscoveredMovies());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<MoviesEntity>>> searchMoviesByName(
      String movieName) {
    throw UnimplementedError();
  }
}
