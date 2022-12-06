import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:xera_task/Core/Colors/app_colors.dart';
import 'package:xera_task/Core/Shared/ProgressIndicator/loading_indicator.dart';
import 'package:xera_task/Services/Database/Movies/movies_db.dart';

import '../../../../../Core/Constants/constants.dart';

class RecentSearchesChips extends StatefulWidget {
  const RecentSearchesChips({required this.onChipsTap, super.key});

  final Function onChipsTap;

  @override
  State<RecentSearchesChips> createState() => _RecentSearchesChipsState();
}

class _RecentSearchesChipsState extends State<RecentSearchesChips> {
  List<String> cachedMovies = [];
  late Future getCachedMovies;

  @override
  void initState() {
    if (cachedMovies.isEmpty) {
      getCachedMoviesFromDB();
    }

    super.initState();
  }

  getCachedMoviesFromDB() async {
    MoviesDao moviesDao = MoviesDao();
    getCachedMovies = moviesDao.getCachedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            cachedMovies.isEmpty) {
          return const AdaptiveProgressIndicator();
        } else {
          if (cachedMovies.isEmpty) {
            cachedMovies = snapshot.data;
          }

          return cachedMovies.isEmpty
              ? Container()
              : Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "Recent searches :",
                        style: Constants.boldStyle
                            .copyWith(color: CustomColors.whiteColor),
                      ),
                      Wrap(
                        alignment: WrapAlignment.start,
                        children: List<Widget>.generate(
                          cachedMovies.length,
                          (int idx) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: InkWell(
                                onTap: () {
                                  widget.onChipsTap(cachedMovies[idx]);
                                },
                                child: Chip(
                                  label: AutoSizeText(cachedMovies[idx]),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                );
        }
      },
      future: getCachedMovies,
    );
  }
}
