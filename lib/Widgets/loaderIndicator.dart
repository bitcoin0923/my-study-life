import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app.dart';

class LoadingDialog extends ConsumerWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const LoadingDialog({Key? key}) : super(key: key);

  @override
   Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Platform.isAndroid
            ? const CircularProgressIndicator()
            : CupertinoActivityIndicator(
                color: theme == ThemeMode.light ? Colors.black : Colors.white,
                radius: 20,
                animating: true,
              ),
      ),
    );
  }
}