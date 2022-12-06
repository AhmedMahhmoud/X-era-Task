import 'dart:developer';

import 'package:xera_task/Core/Failure/exceptions.dart';
import 'package:xera_task/features/movies/Data/Model/movies_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../Core/Constants/constants.dart';

abstract class MoviesRemoteDataSource {
  //? So we can change later from json to xml easily ..
  Future<List<Movies>> getDiscoveredMovies();
  Future<List<Movies>> searchMoviesByName(String name, int pageNumber);
}

class MoviesRemoteDataSourceImp implements MoviesRemoteDataSource {
  @override
  Future<List<Movies>> getDiscoveredMovies() async {
    const url =
        "${Constants.baseUrl}discover/movie?api_key=${Constants.apiKey}";
    final response = await http.get(Uri.parse(url));

    return mapResponseToMoviesList(response);
  }

  @override
  Future<List<Movies>> searchMoviesByName(String name, int pageNumber) async {
    final url =
        "${Constants.baseUrl}search/movie?api_key=${Constants.apiKey}&query=$name&page=$pageNumber";
    final response = await http.get(Uri.parse(url));

    return mapResponseToMoviesList(response);
  }

  List<Movies> mapResponseToMoviesList(response) {
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body)['results'] as List;
      final List<Movies> moviesList =
          decodedJson.map((e) => Movies.fromMap(e)).toList();
      return moviesList;
    } else {
      throw ServerException();
    }
  }
}
