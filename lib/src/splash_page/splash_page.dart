import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:ttt_merchant_flutter/api/auth_api.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/user.dart';
// import 'package:ttt_merchant_flutter/src/auth/first_user_login_page.dart';
import 'package:ttt_merchant_flutter/src/auth/login_page.dart';
import 'package:ttt_merchant_flutter/src/main_page.dart';

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
      await Navigator.of(context).pushNamed(
        MainPage.routeName,
        arguments: MainPageArguments(changeIndex: 0),
      );
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(fit: BoxFit.cover, 'assets/icon/ttt_logo.png'),
            ],
          ),
        ),
      ),
    );
  }
}
