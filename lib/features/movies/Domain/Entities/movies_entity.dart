import 'package:equatable/equatable.dart';

class MoviesEntity extends Equatable {
  final String releaseDate;
  final String overview;
  final String posterImage;
  final String title;
  const MoviesEntity({
    required this.releaseDate,
    required this.overview,
    required this.posterImage,
    required this.title,
  });

  @override
  List<Object?> get props => [releaseDate, overview, posterImage, title];
}
