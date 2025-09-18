import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:ttt_merchant_flutter/api/auth_api.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/user.dart';
// import 'package:ttt_merchant_flutter/src/auth/first_user_login_page.dart';
import 'package:ttt_merchant_flutter/src/auth/login_page.dart';
// import 'package:ttt_merchant_flutter/src/auth/user_set_password_page.dart';
import 'package:ttt_merchant_flutter/src/main_page.dart';
import 'package:upgrader/upgrader.dart';

class SplashPage extends StatefulWidget {
  static const routeName = "SplashPage";
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AfterLayoutMixin {
  User user = User();

  @override
  afterFirstLayout(BuildContext context) async {
    try {
      user = await AuthApi().me(false);
      if (user.userType != null) {
        await Navigator.of(context).pushNamed(
          MainPage.routeName,
          arguments: MainPageArguments(
            changeIndex: 0,
            userType: user.userType!,
          ),
        );
      } else {
        await Navigator.of(context).pushNamed(LoginPage.routeName);
      }
      // user.userStatus == "NEW"
      //     ? await Navigator.of(context).pushNamed(UserSetPasswordPage.routeName)
      //     : await Navigator.of(context).pushNamed(
      //         MainPage.routeName,
      //         arguments: MainPageArguments(
      //           changeIndex: 0,
      //           userType: user.userType!,
      //         ),
      //       );
    } catch (e) {
      // Navigator.of(context).pushNamed(LoginPhonePage.routeName);
      Navigator.of(context).pushNamed(LoginPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: white50,
        body: UpgradeAlert(
          dialogStyle: Platform.isAndroid
              ? UpgradeDialogStyle.material
              : UpgradeDialogStyle.cupertino,
          showLater: false,
          showIgnore: false,
          barrierDismissible: false,
          upgrader: Upgrader(
            debugLogging: true,
            durationUntilAlertAgain: const Duration(days: 0),
            languageCode: 'mn',
            // minAppVersion: '1.0.7',
            messages: UpgraderMessages(code: 'mn'),
            upgraderOS: UpgraderOS(),
            // showIgnore: false,
            // showLater: false,
            // canDismissDialog: false,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(fit: BoxFit.cover, 'assets/icon/ttt_logo.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
