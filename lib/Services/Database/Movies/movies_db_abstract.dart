//? Abstract class so we can implement it with multiple db
abstract class MoviesDbAbstract {
  Future insertMovieName(String movieName);
  Future<List<String>> getCachedMovies();
}
