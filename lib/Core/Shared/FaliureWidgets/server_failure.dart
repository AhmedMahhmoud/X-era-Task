import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Colors/app_colors.dart';
import '../../Constants/constants.dart';
import '../../Failure/exceptions.dart';
import '../Buttons/rounded_button.dart';

class ServerFailureDisplay extends StatelessWidget {
  final VoidCallback ontapCall;
  const ServerFailureDisplay({required this.ontapCall, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AutoSizeText(
            SERVER_FAILURE_MESSAGE,
            style: Constants.boldStyle.copyWith(color: CustomColors.whiteColor),
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
