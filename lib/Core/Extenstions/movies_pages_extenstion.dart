import 'package:xera_task/Core/enums/movies_enum.dart';

extension MoviePageExtension on MoviePage {
  MoviePage convertIntToPage(int index) {
    if (index == 0) {
      return MoviePage.discover;
    }
    return MoviePage.search;
  }
}
