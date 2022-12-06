import 'package:flutter/material.dart';
import 'package:xera_task/Core/Colors/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Constants {
  static const String MoviesDBName = "moviesDB";
  static const String imagesUrl = "https://image.tmdb.org/t/p/w500";
  static const String apiKey = "dc8c6ae585c2496b758c84803cd3868e";
  static const String baseUrl = "https://api.themoviedb.org/3/";
  static const TextStyle boldStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  static final kSearchTextFieldDecoration = InputDecoration(
    isDense: true,
    contentPadding: EdgeInsets.all(18.sp),
    hintText: 'Enter the movie you want to search for',
    hintStyle: boldStyle.copyWith(
        color: CustomColors.greyColor, fontStyle: FontStyle.italic),
    fillColor: CustomColors.whiteColor,
    filled: true,
    disabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xffEDEDED), width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
//  contentPadding: EdgeInsets.symmetric(),
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xff4a4a4a), width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xff4a4a4a), width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
  );
}
