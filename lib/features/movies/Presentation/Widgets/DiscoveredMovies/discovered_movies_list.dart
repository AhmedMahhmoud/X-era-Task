import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xera_task/Core/Colors/app_colors.dart';
import 'package:xera_task/Core/Shared/ProgressIndicator/loading_indicator.dart';
import 'package:xera_task/features/movies/Domain/Entities/movies_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

import '../../cubit/movies/SearchMovies/search_movies_bloc.dart';
import 'movie_poster.dart';
import 'movies_details.dart';

class DisplayMoviesList extends StatefulWidget {
  final List<MoviesEntity> movies;
  final String? movieSearchTitle;
  const DisplayMoviesList({
    required this.movies,
    this.movieSearchTitle,
    Key? key,
  }) : super(key: key);

  @override
  State<DisplayMoviesList> createState() => _DisplayMoviesListState();
}

int pageNumber = 1;

class _DisplayMoviesListState extends State<DisplayMoviesList> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    if (widget.movieSearchTitle != "" && widget.movieSearchTitle != null) {
      _scrollController.addListener(() async {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          pageNumber = pageNumber + 1;
          addMoviesEvent(context, widget.movieSearchTitle!, pageNumber);
        }
      });
    }
    super.initState();
  }

  addMoviesEvent(BuildContext context, String movieName, int pageNumber) {
    BlocProvider.of<SearchMoviesBloc>(context, listen: false).add(
        SearchMoviesByNamePaginated(
            movieName: movieName, pageIndex: pageNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView.separated(
                controller: _scrollController,
                itemBuilder: (context, index) {
                  final movie = widget.movies[index];
                  return SlideInDown(
                    delay: Duration(milliseconds: 5 * index),
                    child: Card(
                        elevation: 2,
                        shadowColor: CustomColors.whiteColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          width: 400.w,
                          height: 120.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MoviePoster(movie: movie),
                              const VerticalDivider(
                                thickness: 3,
                                width: 0,
                                color: CustomColors.blackColor,
                              ),
                              MovieDetails(movie: movie)
                            ],
                          ),
                        )),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: widget.movies.length),
          ),
          BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
            builder: (context, state) {
              if (state is SearchMoviePaginatedLoadingState) {
                return const AdaptiveProgressIndicator();
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
