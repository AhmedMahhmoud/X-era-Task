import 'package:flutter/material.dart';
import 'package:xera_task/features/movies/Domain/Entities/movies_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MoviesEntity movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100.w,
        height: 120.h,
        child: Image.network(
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(
                Icons.broken_image,
                size: 50,
              ),
            );
          },
          movie.posterImage,
          fit: BoxFit.cover,
        ));
  }
}
