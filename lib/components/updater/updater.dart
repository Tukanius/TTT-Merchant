import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

class UpdaterComponent extends StatefulWidget {
  final Widget child;
  const UpdaterComponent({super.key, required this.child});

  @override
  State<UpdaterComponent> createState() => _UpdaterComponentState();
}

class _UpdaterComponentState extends State<UpdaterComponent>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await Upgrader.clearSavedSettings();
  }

  final upgrader = Upgrader(
    debugLogging: true,
    messages: UpgraderMessages(code: 'mn'),
  );
  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      dialogStyle: Platform.isAndroid
          ? UpgradeDialogStyle.material
          : UpgradeDialogStyle.cupertino,
      showLater: false,
      showIgnore: false,
      barrierDismissible: false,
      upgrader: Upgrader(
        upgraderOS: UpgraderOS(),
        debugLogging: true,
        messages: UpgraderMessages(code: 'mn'),
        countryCode: 'MN',
        minAppVersion: '1.0.14',
      ),
      child: widget.child,
    );
  }
}
