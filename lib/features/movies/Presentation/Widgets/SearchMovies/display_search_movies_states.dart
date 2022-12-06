import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xera_task/Core/Shared/ProgressIndicator/loading_indicator.dart';

import '../../../../../Core/Shared/FaliureWidgets/display_failure.dart';
import '../../cubit/movies/SearchMovies/search_movies_bloc.dart';
import '../DiscoveredMovies/discovered_movies_list.dart';

class DisplaySearchMoviesStates extends StatelessWidget {
  const DisplaySearchMoviesStates({required this.searchController,super.key});

  final TextEditingController searchController;

  addMoviesEvent(BuildContext context, String movieName, int pageIndex) {
    BlocProvider.of<SearchMoviesBloc>(context, listen: false)
        .add(SearchMoviesByName(movieName: movieName));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
        builder: (context, state) {
      if (state is SearchMovieLoadingState) {
        return const Expanded(child: AdaptiveProgressIndicator());
      } else if (state is SearchMovieErrorState) {
        return displayErrorWidget(
          errorMsg: state.message,
          callback: () {
            addMoviesEvent(context, searchController.text, 1);
          },
        );
      } else if (state is SearchMovieLoadedState || state is SearchMoviePaginatedLoadedState|| state is SearchMoviePaginatedLoadingState) {
        return DisplayMoviesList(movieSearchTitle: searchController.text,
          movies: BlocProvider.of<SearchMoviesBloc>(context).movies,
        );
      }
      
      return Container();
    });
  }
}
