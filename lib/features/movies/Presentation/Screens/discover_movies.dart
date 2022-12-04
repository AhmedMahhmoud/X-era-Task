import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xera_task/Core/Colors/app_colors.dart';
import 'package:xera_task/Core/Shared/ProgressIndicator/loading_indicator.dart';
import 'package:xera_task/features/movies/Presentation/cubit/movies/bloc/movies_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

class DiscoverMoviesPage extends StatelessWidget {
  const DiscoverMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesDiscoverLoadingState) {
          return const Expanded(child: AdaptiveProgressIndicator());
        } else if (state is MoviesDiscoverErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is MoviesDiscoverLoadedState) {
          return Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
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
                                SizedBox(
                                    width: 100.w,
                                    height: 120.h,
                                    child: Image.network(
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Center(
                                          child: Icon(
                                            Icons.broken_image,
                                            size: 50,
                                          ),
                                        );
                                      },
                                      state.movies[index].posterImage,
                                      fit: BoxFit.cover,
                                    )),
                                const VerticalDivider(
                                  thickness: 3,
                                  width: 0,
                                  color: CustomColors.blackColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 210.w,
                                        child: AutoSizeText(
                                          state.movies[index].title,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold),
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
                                            state.movies[index].overview,
                                            style: TextStyle(
                                                color: CustomColors.greyColor,
                                                fontSize: 14.sp,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      AutoSizeText(
                                          state.movies[index].releaseDate)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: state.movies.length));
        }
        return Container();
      },
    );
  }
}
