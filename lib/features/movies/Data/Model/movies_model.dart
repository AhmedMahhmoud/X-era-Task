import 'package:xera_task/features/movies/Domain/Entities/movies_entity.dart';
import 'dart:convert';

import '../../../../Core/Constants/constants.dart';

class Movies extends MoviesEntity {
  const Movies(
      {required super.releaseDate,
      required super.overview,
      required super.posterImage,
      required super.title});

  factory Movies.fromJson(String source) => Movies.fromMap(json.decode(source));

  factory Movies.fromMap(Map<String, dynamic> json) {
    return Movies(
        overview: json['overview'],
        posterImage: "${Constants.imagesUrl}${json['backdrop_path']}",
        releaseDate: json['release_date'],
        title: json['title']);
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {'title': title};
  }
}
