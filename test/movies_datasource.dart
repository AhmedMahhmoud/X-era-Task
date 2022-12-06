// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:xera_task/Core/Failure/exceptions.dart';
// import 'package:xera_task/Core/Failure/failures.dart';
// import 'package:xera_task/Core/Network/network.dart';
// import 'package:xera_task/Services/Database/Movies/movies_db.dart';
// import 'package:xera_task/features/movies/Data/Datasource/movies_remote_datasource.dart';
// import 'package:xera_task/features/movies/Data/Model/movies_model.dart';
// import 'package:xera_task/features/movies/Data/Repository/movies_repo_imp.dart';
// import 'package:xera_task/features/movies/Domain/Entities/movies_entity.dart';
// import 'package:xera_task/features/movies/Domain/Repositories/movies_repository.dart';

// class MockRemoteDataSourceSuccess implements MoviesRemoteDataSource {
//   @override
//   Future<List<Movies>> getDiscoveredMovies() {
//     return Future.value([]);
//   }

//   @override
//   Future<List<Movies>> searchMoviesByName(String name, int pageNumber) {
//     return Future.value([]);
//   }
// }

// class MockRemoteDataSourceFailure implements MoviesRemoteDataSource {
//   @override
//   Future<List<Movies>> getDiscoveredMovies() {
//     throw OfflineException();
//   }

//   @override
//   Future<List<Movies>> searchMoviesByName(String name, int pageNumber) {
//     throw OfflineException();
//   }
// }

// void main() {
//   test(
//       'Fetch Movies should return instance of MovieEntity List on remoteDataSource success',
//       () {
//     MoviesRepository repo = MoviesRepoImp(
//         networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
//         remoteDataSrc: MockRemoteDataSourceSuccess(),
//         moviesDao: MoviesDao());
//     final result = repo.getDiscoveredMovies();
//     expect(result, isInstanceOf<Future<Either<Failure, List<MoviesEntity>>>>());
//   });
// }

import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:mocktail/mocktail.dart';
import 'package:xera_task/Core/Network/network.dart';
import 'package:xera_task/Services/Database/Movies/movies_db.dart';
import 'package:xera_task/features/movies/Data/Datasource/movies_remote_datasource.dart';
import 'package:xera_task/features/movies/Data/Model/movies_model.dart';
import 'package:xera_task/features/movies/Data/Repository/movies_repo_imp.dart';

class MockRemoteDataSource extends Mock implements MoviesRemoteDataSourceImp {}

void main() {
  test(
      'Fetch Movies should return instance of MovieEntity List on remoteDataSource ',
      () async {
    const movie = Movies(
        releaseDate: "releaseDate",
        overview: "overview",
        posterImage: "posterImage",
        title: "title");
    MockRemoteDataSource mockDS = MockRemoteDataSource();
    MoviesRepoImp repo = MoviesRepoImp(
        networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
        remoteDataSrc: mockDS,
        moviesDao: MoviesDao());
    when(mockDS.getDiscoveredMovies).thenAnswer((_) async => [movie]);
    final x = await repo.getDiscoveredMovies();
    var rightvalue = [];
    x.fold((l) => () {}, (r) {
      rightvalue = r;
    });

    expect(
      rightvalue,
      [movie],
    );
    verify(mockDS.getDiscoveredMovies).called(1);
  });
}
