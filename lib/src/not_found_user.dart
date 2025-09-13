import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/provider/user_provider.dart';
import 'package:ttt_merchant_flutter/src/splash_page/splash_page.dart';

class NotFoundUser extends StatefulWidget {
  static const routeName = "NotFoundUser";
  const NotFoundUser({super.key});

  @override
  State<NotFoundUser> createState() => _NotFoundUserState();
}

class _NotFoundUserState extends State<NotFoundUser> {
  onExit(BuildContext dialogContext) async {
    try {
      await Provider.of<UserProvider>(context, listen: false).logout();
      Navigator.of(context).pushNamed(SplashPage.routeName);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Хэрэглэгч олдсонгүй',
              style: TextStyle(
                color: black950,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                onExit(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: redColor,
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset('assets/svg/log_out.svg'),
                    SizedBox(width: 8),
                    Text(
                      'Системээс гарах',
                      style: TextStyle(
                        color: white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
