import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xera_task/Core/Shared/FaliureWidgets/display_failure.dart';
import 'package:xera_task/Core/Shared/ProgressIndicator/loading_indicator.dart';
import 'package:xera_task/features/movies/Presentation/cubit/movies/bloc/movies_bloc.dart';
import '../Widgets/DiscoveredMovies/discovered_movies_list.dart';

class DiscoverMoviesPage extends StatelessWidget {
  const DiscoverMoviesPage({super.key});
  addMoviesEvent(BuildContext context) {
    BlocProvider.of<MoviesBloc>(context, listen: false)
        .add(GetAllDiscoveredMovies());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesDiscoverLoadingState) {
          return const Expanded(child: AdaptiveProgressIndicator());
        } else if (state is MoviesDiscoverErrorState) {
          return displayErrorWidget(
            errorMsg: state.message,
            callback: () {
              addMoviesEvent(context);
            },
          );
        } else if (state is MoviesDiscoverLoadedState) {
          return DiscoveredMoviesList(
            movies: state.movies,
          );
        }
        return Container();
      },
    );
  }
}
