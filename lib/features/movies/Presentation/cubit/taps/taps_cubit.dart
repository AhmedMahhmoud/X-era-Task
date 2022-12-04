// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:xera_task/Core/enums/movies_enum.dart';

part 'taps_state.dart';

class TapsCubit extends Cubit<TapsState> {
  TapsCubit() : super(TapsInitial());
  MoviePage currentTabValue = MoviePage.discover;
  changeTabValue(MoviePage value) {
    currentTabValue = value;
    emit(TapsChange());
  }
}
