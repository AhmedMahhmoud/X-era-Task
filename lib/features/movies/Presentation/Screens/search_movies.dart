import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xera_task/Core/Colors/app_colors.dart';
import 'package:xera_task/Core/Shared/ProgressIndicator/loading_indicator.dart';
import 'package:xera_task/Services/Database/Movies/movies_db.dart';
import '../../../../Core/Constants/constants.dart';
import '../../../../Core/Shared/FaliureWidgets/display_failure.dart';
import '../Widgets/DiscoveredMovies/discovered_movies_list.dart';
import '../Widgets/SearchMovies/movie_search_field.dart';
import '../cubit/movies/SearchMovies/search_movies_bloc.dart';

class SearchMovies extends StatefulWidget {
  const SearchMovies({super.key});

  @override
  State<SearchMovies> createState() => _SearchMoviesState();
}

class _SearchMoviesState extends State<SearchMovies> {
  late Future getCachedMovies;

  final TextEditingController _searchController = TextEditingController();
  final _searchFieldNotifi = ValueNotifier<String>("");
  getCachedMoviesFromDB() async {
    MoviesDao moviesDao = MoviesDao();
    getCachedMovies = moviesDao.getMovieNames();
  }

  @override
  void initState() {
    getCachedMoviesFromDB();
    super.initState();
  }

  addMoviesEvent(BuildContext context, String movieName, int pageIndex) {
    BlocProvider.of<SearchMoviesBloc>(context, listen: false)
        .add(SearchMoviesByName(movieName: movieName, pageIndex: pageIndex));
  }

  void setSearchFieldState(String newState) {
    _searchFieldNotifi.value = newState;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MovieSearchField(
                searchController: _searchController,
                callback: setSearchFieldState),
            const SizedBox(
              height: 10,
            ),
            ValueListenableBuilder(
              valueListenable: _searchFieldNotifi,
              builder: (context, value, child) {
                return _searchFieldNotifi.value == ""
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            "Recent searches :",
                            style: Constants.boldStyle
                                .copyWith(color: CustomColors.whiteColor),
                          ),
                          FutureBuilder(
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const AdaptiveProgressIndicator();
                              }
                              List<String> data = snapshot.data;
                              return Wrap(
                                alignment: WrapAlignment.start,
                                children: List<Widget>.generate(
                                  data.length,
                                  (int idx) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: InkWell(
                                        onTap: () {
                                          _searchController.text = data[idx];
                                          addMoviesEvent(context, data[idx], 1);
                                        },
                                        child: Chip(
                                          label: AutoSizeText(data[idx]),
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              );
                            },
                            future: getCachedMovies,
                          ),
                        ],
                      )
                    : BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
                        builder: (context, state) {
                          if (state is SearchMovieLoadingState) {
                            return const Expanded(
                                child: AdaptiveProgressIndicator());
                          } else if (state is SearchMovieErrorState) {
                            return displayErrorWidget(
                              errorMsg: state.message,
                              callback: () {
                                addMoviesEvent(
                                    context, _searchController.text, 1);
                              },
                            );
                          } else if (state is SearchMovieLoadedState) {
                            return DisplayMoviesList(
                              movies: state.movies,
                            );
                          }
                          return Container();
                        },
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
