import 'package:mockito/mockito.dart';
import 'package:xera_task/features/movies/Domain/Repositories/movies_repository.dart';

class MovieRepoTest extends Mock implements MoviesRepository {}

@GeneratedMocks([MovieRepoTest])
Future<void> main() async {
  late MockMovieRepoTest movieRepo;

}
