import 'dart:developer';

import 'package:sembast/sembast.dart';

import '../../../Core/Constants/constants.dart';
import '../sembast.dart';

class MoviesDao {
  final _userStore = intMapStoreFactory.store(Constants.MoviesDBName);
  Future<Database> get _db async => await AppDatabase.instance.database;
  var store = StoreRef.main();
  Future insertMovies(String movieName) async {
    await _userStore.add(await _db, {"name": movieName});
    log("movie added successfully");
  }

  Future<List<String>> getMovieNames() async {
    List<String> cachedMovies = [];
    var moviesSnapshots = await _userStore.find(await _db);
    moviesSnapshots = moviesSnapshots.reversed.toList();
    var listLength = moviesSnapshots.length;

    for (int i = 0;
        i < listLength.clamp(0, 10);
        i++) //? Returns the last 10 cache movies
    {
      cachedMovies.add(moviesSnapshots[i].value.values.first.toString());
    }
    return cachedMovies;
  }
}
