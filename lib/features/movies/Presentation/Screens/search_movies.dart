import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xera_task/features/movies/Presentation/Widgets/SearchMovies/display_search_movies_states.dart';
import 'package:xera_task/features/movies/Presentation/Widgets/SearchMovies/recent_search_chips.dart';
import '../Widgets/SearchMovies/movie_search_field.dart';
import '../cubit/movies/SearchMovies/search_movies_bloc.dart';

class SearchMovies extends StatefulWidget {
  const SearchMovies({super.key});

  @override
  State<SearchMovies> createState() => _SearchMoviesState();
}

class _SearchMoviesState extends State<SearchMovies> {
  final TextEditingController _searchController = TextEditingController();
  final _searchFieldNotifi = ValueNotifier<String>("");

  void setSearchFieldState(String newState) {
    _searchFieldNotifi.value = newState;
  }

  resetMovies() {
    BlocProvider.of<SearchMoviesBloc>(context, listen: false)
        .add(ResetMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                    ? RecentSearchesChips(onChipsTap: (value) {
                        _searchController.text = value;
                        resetMovies();
                      })
                    : DisplaySearchMoviesStates(
                        searchController: _searchController);
              },
            )
          ],
        ),
      ),
    );
  }
}
