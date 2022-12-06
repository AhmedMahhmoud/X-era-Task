import 'package:xera_task/Core/Failure/exceptions.dart';
import 'package:xera_task/Core/Network/network.dart';
import 'package:xera_task/features/movies/Data/Datasource/movies_remote_datasource.dart';
import 'package:xera_task/features/movies/Data/Model/movies_model.dart';
import 'package:xera_task/features/movies/Domain/Entities/movies_entity.dart';
import 'package:xera_task/Core/Failure/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:xera_task/features/movies/Domain/Repositories/movies_repository.dart';

import '../../../../Services/Database/Movies/movies_db.dart';

class MoviesRepoImp implements MoviesRepository {
  final NetworkInfo networkInfo;
  final MoviesRemoteDataSource remoteDataSrc;
  final MoviesDao moviesDao;
  MoviesRepoImp(
      {required this.networkInfo,
      required this.remoteDataSrc,
      required this.moviesDao});
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
      String movieName, int pageIndex) async {
    if (await networkInfo.isConnected) {
      try {
        List<Movies> moviesList =
            await remoteDataSrc.searchMoviesByName(movieName, pageIndex);
        if (moviesList.isNotEmpty && pageIndex == 1) {
          moviesDao.insertMovieName(movieName);
        }
        return Right(moviesList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
