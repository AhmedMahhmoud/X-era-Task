import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xera_task/Core/Shared/FaliureWidgets/display_failure.dart';
import 'package:xera_task/Core/Shared/ProgressIndicator/loading_indicator.dart';
import '../Widgets/DiscoveredMovies/discovered_movies_list.dart';
import '../cubit/movies/DiscoverMovies/discover_movies_bloc.dart';

class DiscoverMoviesPage extends StatelessWidget {
  const DiscoverMoviesPage({super.key});
  addMoviesEvent(BuildContext context) {
    BlocProvider.of<DiscoverMoviesBloc>(context, listen: false)
        .add(GetAllDiscoveredMovies());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscoverMoviesBloc, DiscoveredMoviesState>(
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
          return DisplayMoviesList(
            movies: state.movies,
          );
        }
        return Container();
      },
    );
  }
}
