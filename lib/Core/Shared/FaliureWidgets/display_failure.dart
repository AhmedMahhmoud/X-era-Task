import 'package:flutter/cupertino.dart';
import 'package:xera_task/Core/Shared/FaliureWidgets/server_failure.dart';

import '../../Constants/constants.dart';
import '../../Failure/exceptions.dart';
import 'no_internet.dart';

displayErrorWidget({required String errorMsg, required VoidCallback callback}) {
  switch (errorMsg) {
    case OFFLINE_FAILURE_MESSAGE:
      return NoInternetDisplay(
        ontapCall: callback,
      );
    case SERVER_FAILURE_MESSAGE:
      return ServerFailureDisplay(
        ontapCall: callback,
      );
    default:
      return Center(
        child: Text(
          errorMsg,
          style: Constants.boldStyle,
        ),
      );
  }
}
