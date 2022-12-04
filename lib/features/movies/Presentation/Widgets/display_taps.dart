import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xera_task/Core/Colors/app_colors.dart';
import '../../../../Core/Extenstions/movies_pages_extenstion.dart';
import '../cubit/taps/taps_cubit.dart';

class DisplayTaps extends StatelessWidget {
  const DisplayTaps({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabCubit = BlocProvider.of<TapsCubit>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: 450.w,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(12),
        ),
        child: DefaultTabController(
          length: 2,
          child: TabBar(
            indicator: BoxDecoration(
              color: CustomColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
            labelStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            labelColor: Colors.black,
            unselectedLabelColor: CustomColors.whiteColor,
            onTap: (value) {
              tabCubit.changeTabValue(
                  tabCubit.currentTabValue.convertIntToPage(value));
            },
            tabs: const [
              Tab(
                text: "Discover Movies",
                icon: Icon(Icons.movie),
              ),
              Tab(
                text: "Search a movie",
                icon: Icon(Icons.search),
              )
            ],
          ),
        ),
      ),
    );
  }
}
