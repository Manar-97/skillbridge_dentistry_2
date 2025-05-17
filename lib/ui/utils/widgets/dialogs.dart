import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../core/assets_manager.dart';

abstract class Dialogs {
  static void alertDialog({
    required final String message,
    final Widget? animation,
    final String? negativeFeedback,
    final String? positiveFeedback,
    final VoidCallback? positiveAction,
    final VoidCallback? negativeAction,
    final Widget? icon,
    final bool isClosed = true,
    required BuildContext context,
  }) {
    List<Widget> actions = [];
    if (positiveFeedback != null) {
      actions.add(ElevatedButton(
          onPressed: positiveAction,
          child: Text(
            positiveFeedback,
            style: const TextStyle(color: Colors.white),
          )));
    }
    if (negativeFeedback != null) {
      actions.add(ElevatedButton(
          onPressed: negativeAction,
          child: Text(
            negativeFeedback,
            style: const TextStyle(color: Colors.white),
          )));
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: animation ?? icon,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(message)],
              ),
              actions: actions,
            ));
  }

  static void successDialog({required BuildContext context}) {
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Lottie.asset(AnimationAssets.success)));
  }

  static void loading({required BuildContext context}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Lottie.asset(
                  height: MediaQuery.of(context).size.height * .2,
                  AnimationAssets.loading),
            ),
        barrierDismissible: false);
  }

  static void logout({required BuildContext context}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Lottie.asset(
                  height: MediaQuery.of(context).size.height * .2,
                  AnimationAssets.logout),
            ),
        barrierDismissible: false);
  }

  static void errorDialog({required BuildContext context}) {
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Lottie.asset(AnimationAssets.error)));
  }
}
