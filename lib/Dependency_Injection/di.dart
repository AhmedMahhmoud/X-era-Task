import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:xera_task/features/movies/Data/Datasource/movies_remote_datasource.dart';
import 'package:xera_task/features/movies/Data/Repository/movies_repo_imp.dart';
import 'package:xera_task/features/movies/Domain/Repositories/movies_repository.dart';
import 'package:xera_task/features/movies/Domain/Usecases/discovered_movies_usecase.dart';
import 'package:xera_task/features/movies/Domain/Usecases/search_movies_by_name_usecase.dart';
import 'package:xera_task/features/movies/Presentation/cubit/movies/bloc/movies_bloc.dart';

import '../Core/Network/network.dart';

final sl = GetIt.instance;
Future<void> init() async {
  // Bloc
  sl.registerFactory(() => MoviesBloc(discoverUsecase: sl()));
  //usecases
  sl.registerLazySingleton(() => GetDiscoveredMoviesUsecase(sl()));
  sl.registerLazySingleton(() => SearchMovieByNameUsecase(sl()));
  //Datasource
  sl.registerLazySingleton<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImp());
  //Repository
  sl.registerLazySingleton<MoviesRepository>(
      () => MoviesRepoImp(networkInfo: sl(), remoteDataSrc: sl()));
  //External
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}
