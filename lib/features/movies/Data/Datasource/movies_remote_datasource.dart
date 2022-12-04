import 'dart:developer';

import 'package:xera_task/Core/Failure/exceptions.dart';
import 'package:xera_task/features/movies/Data/Model/movies_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../Core/Constants/constants.dart';

abstract class MoviesRemoteDataSource {
  //? So we can change later from json to xml easily ..
  Future<List<Movies>> getDiscoveredMovies();
  Future<List<Movies>> searchMoviesByName(String name);
}

class MoviesRemoteDataSourceImp implements MoviesRemoteDataSource {
  @override
  Future<List<Movies>> getDiscoveredMovies() async {
    const url =
        "${Constants.baseUrl}discover/movie?api_key=${Constants.apiKey}";
    final response = await http.get(Uri.parse(url));
    log(response.body);
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body)['results'] as List;
      final List<Movies> moviesList =
          decodedJson.map((e) => Movies.fromMap(e)).toList();
      return moviesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Movies>> searchMoviesByName(String name) {
    throw UnimplementedError();
  }
}
