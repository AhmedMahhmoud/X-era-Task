import 'package:flutter/material.dart';
import 'package:xera_task/Core/enums/movies_enum.dart';
import 'package:xera_task/features/movies/Presentation/cubit/taps/taps_cubit.dart';

import '../Widgets/Taps/display_taps.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'discover_movies.dart';

class MoviesHome extends StatelessWidget {
  const MoviesHome({super.key});

  @override
  Widget build(BuildContext context) {
    var tabValue = BlocProvider.of<TapsCubit>(context);
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const DisplayTaps(),
          BlocBuilder<TapsCubit, TapsState>(
            builder: (context, state) {
              if (tabValue.currentTabValue == MoviePage.discover) {
                return const DiscoverMoviesPage();
              }
              return Container();
            },
          )
        ],
      ),
    ));
  }
}
