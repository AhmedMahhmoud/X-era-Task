import 'package:flutter/material.dart';
import 'package:xera_task/Core/Colors/app_colors.dart';

class AdaptiveProgressIndicator extends StatelessWidget {
  const AdaptiveProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator.adaptive( //?Adaptive so we can display indicator for Ios and Android
      backgroundColor: CustomColors.whiteColor,
    ));
  }
}
