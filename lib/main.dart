import 'package:flutter/material.dart';
import 'package:xera_task/Core/Theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xera_task/features/movies/Presentation/cubit/taps/taps_cubit.dart';
import 'features/movies/Presentation/Screens/movies_home_taps.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xera_task/Dependency_Injection/di.dart' as di;

import 'features/movies/Presentation/cubit/movies/DiscoverMovies/discover_movies_bloc.dart';
import 'features/movies/Presentation/cubit/movies/SearchMovies/search_movies_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TapsCubit(),
        ),
        BlocProvider(
          create: (context) =>
              di.sl<DiscoverMoviesBloc>()..add(GetAllDiscoveredMovies()),
        ),
        BlocProvider(create: (context) => di.sl<SearchMoviesBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return MaterialApp(
            theme: AppThemeManager.getApplicationTheme(),
            home: const MoviesHome(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
