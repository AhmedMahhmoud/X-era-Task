import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:xera_task/Core/Colors/app_colors.dart';
import 'package:xera_task/features/movies/Domain/Entities/movies_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Core/Constants/constants.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MoviesEntity movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 210.w,
            child: AutoSizeText(
              movie.title,
              style: Constants.boldStyle,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: SizedBox(
              width: 220.w,
              child: AutoSizeText(
                  maxLines: 3,
                  movie.overview,
                  style: Constants.boldStyle.copyWith(
                    color: CustomColors.greyColor,
                    fontSize: 14.sp,
                    overflow: TextOverflow.ellipsis,
                  )),
            ),
          ),
          AutoSizeText(movie.releaseDate)
        ],
      ),
    );
  }
}
