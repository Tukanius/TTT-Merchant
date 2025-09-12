import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/src/notify_page/notify_page.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  ///
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = '${info.version}';
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: white,
      centerTitle: false,
      elevation: 1,
      automaticallyImplyLeading: false,
      title: GestureDetector(
        onTap: () {
          // NotifyService().showNotification(
          //   title: "TTTETET HAHA",
          //   body: "TEST BODY AHHAHAH",
          // );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SvgPicture.asset('assets/svg/TTT.svg'),
            SizedBox(width: 6),
            Text(
              'V $_version',
              style: TextStyle(
                color: black950,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(NotifyPage.routeName);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    child: Center(
                      child: SvgPicture.asset('assets/svg/notify.svg'),
                    ),
                  ),
                  // Positioned(
                  //   right: 7,
                  //   top: 4,
                  //   child: Container(
                  //     height: 12,
                  //     width: 12,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(100),
                  //       color: rednotify,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(width: 16),
            ],
          ),
        ),
      ],
    );
  }
}
