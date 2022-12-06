import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/Constants/constants.dart';
import '../../cubit/movies/SearchMovies/search_movies_bloc.dart';

class MovieSearchField extends StatefulWidget {
  const MovieSearchField(
      {required this.callback, required this.searchController, super.key});

  final Function callback;
  final TextEditingController searchController;

  @override
  State<MovieSearchField> createState() => _MovieSearchFieldState();
}

class _MovieSearchFieldState extends State<MovieSearchField> {
  String oldValue = "";
  String query = "";

  Timer? _debounce;
  final int _debouncetime = 820; //?Time to simulate when user stop typing

  @override
  void initState() {
    widget.searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    widget.callback(widget.searchController.text);
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(Duration(milliseconds: _debouncetime), () {
      if (widget.searchController.text != "" &&
          widget.searchController.text != oldValue) {
        BlocProvider.of<SearchMoviesBloc>(context)
            .add(SearchMoviesByName(movieName: widget.searchController.text));
        oldValue = widget.searchController.text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Constants.boldStyle,
      controller: widget.searchController,
      decoration: Constants.kSearchTextFieldDecoration,
    );
  }
}
