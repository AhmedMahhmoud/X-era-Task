import 'package:flutter/material.dart';
import 'package:xera_task/Core/Colors/app_colors.dart';
import 'package:xera_task/features/movies/Domain/Entities/movies_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

import 'movie_poster.dart';
import 'movies_details.dart';

class DisplayMoviesList extends StatelessWidget {
  final List<MoviesEntity> movies;
  const DisplayMoviesList({
    required this.movies,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
            itemBuilder: (context, index) {
              final movie = movies[index];
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
            itemCount: movies.length));
  }
}
