import 'package:event_planning_3/utils/AppStyle.dart';
import 'package:flutter/material.dart';

class DialogUtils {

  static void showLoading({
    required BuildContext context,
    required String message,
  }) {
    showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(message, style: AppStyle.Mediam16black),
              ),
            ],
          ),
        );
      },
    );
  }

  // ✅ قفل نفس الـ navigator اللي اتفتح بيه
  static void hideLoading(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    String? posActionName,
    String? title,
    Function? posAction,
    String? negActionName,
    Function? negAction,
  }) {

    // ✅ لو مفيش زرار → اعمل زر OK تلقائي
    final actions = <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
          posAction?.call();
        },
        child: Text(
          posActionName ?? "OK",
          style: AppStyle.Mediam16black,
        ),
      ),
    ];

    if (negActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            negAction?.call();
          },
          child: Text(
            negActionName,
            style: AppStyle.Mediam16black,
          ),
        ),
      );
    }

    showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: title != null
              ? Text(title, style: AppStyle.Mediam16black)
              : null,
          content: Text(message),
          actions: actions,
        );
      },
    );
  }
}
