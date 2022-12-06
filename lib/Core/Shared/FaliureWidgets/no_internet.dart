import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:xera_task/Core/Colors/app_colors.dart';
import 'package:xera_task/Core/Failure/exceptions.dart';
import 'package:xera_task/Core/ImagePaths/image_pathds.dart';
import '../../Constants/constants.dart';
import '../Buttons/rounded_button.dart';

class NoInternetDisplay extends StatelessWidget {
  const NoInternetDisplay({required this.ontapCall, super.key});

  final VoidCallback ontapCall;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AutoSizeText(
            OFFLINE_FAILURE_MESSAGE,
            style: Constants.boldStyle.copyWith(color: CustomColors.whiteColor),
          ),
          Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage(ImagePaths.noInternet)),
            ),
          ),
          RoundedButton(
            ontapCall: ontapCall,
            height: 40,
            width: 120,
            title: "Retry",
          )
        ],
      ),
    );
  }
}
