import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:xera_task/Core/Colors/app_colors.dart';
import '../../Constants/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.ontapCall,
    required this.title,
    required this.width,
    required this.height,
  }) : super(key: key);
  final String title;
  final double width, height;
  final VoidCallback ontapCall;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontapCall();
      },
      child: Container(
        decoration: BoxDecoration(
            color: CustomColors.whiteColor,
            borderRadius: BorderRadius.circular(20)),
        width: width.w,
        height: height.h,
        child: Center(
          child: AutoSizeText(
            title,
            style: Constants.boldStyle,
          ),
        ),
      ),
    );
  }
}
