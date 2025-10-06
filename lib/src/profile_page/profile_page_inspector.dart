import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:ttt_merchant_flutter/api/auth_api.dart';
import 'package:ttt_merchant_flutter/components/custom_app_bar/custom_app_bar.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/general/general_init.dart';
import 'package:ttt_merchant_flutter/models/user_models/user.dart';
import 'package:ttt_merchant_flutter/provider/general_provider.dart';
import 'package:ttt_merchant_flutter/provider/user_provider.dart';
import 'package:ttt_merchant_flutter/src/profile_page/profile_detail_page.dart';
import 'package:ttt_merchant_flutter/src/splash_page/splash_page.dart';

class ProfilePageInspector extends StatefulWidget {
  final Function(int) onChangePage;
  static const routeName = "ProfilePageInspector";
  const ProfilePageInspector({super.key, required this.onChangePage});

  @override
  State<ProfilePageInspector> createState() => _ProfilePageInspectorState();
}

class _ProfilePageInspectorState extends State<ProfilePageInspector>
    with AfterLayoutMixin {
  User user = User();
  bool isLoadingPage = true;
  GeneralInit general = GeneralInit();
  bool isLoading = false;

  @override
  afterFirstLayout(BuildContext context) async {
    try {
      user = await AuthApi().me(false);
      general = await Provider.of<GeneralProvider>(
        context,
        listen: false,
      ).init();
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  toExit() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: white,
          title: Center(
            child: Text(
              'Гарах',
              style: TextStyle(
                color: black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          content: Text(
            'Та системээс гарахдаа итгэлтэй байна уу.',
            style: TextStyle(color: black, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          actionsAlignment: MainAxisAlignment.end,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Үгүй', style: TextStyle(color: black)),
            ),
            TextButton(
              onPressed: () async {
                await onExit(context);
                // Navigator.of(context).pop();
              },
              child: Text('Тийм', style: TextStyle(color: black)),
            ),
          ],
        );
      },
    );
  }

  onExit(BuildContext dialogContext) async {
    try {
      setState(() {
        isLoading = true;
      });
      await Provider.of<UserProvider>(context, listen: false).logout();
      Navigator.of(dialogContext).pop();
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushNamed(SplashPage.routeName);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      backgroundColor: white50,
      body: isLoadingPage == true
          ? CustomLoader()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            ProfileDetailPage.routeName,
                            arguments: ProfileDetailPageArguments(
                              data: general,
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/svg/profile.svg'),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${user.firstName} ${user.lastName}',
                                      style: TextStyle(
                                        color: black950,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '${general.inventory?.name ?? '-'}',
                                      style: TextStyle(
                                        color: black800,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SvgPicture.asset('assets/svg/arrow_right.svg'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          // Navigator.of(context).pushNamed(IncomeListPage.routeName);
                          widget.onChangePage(0);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset('assets/svg/board.svg'),
                                  SizedBox(width: 12),
                                  Text(
                                    'Захиалга',
                                    style: TextStyle(
                                      color: black950,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SvgPicture.asset('assets/svg/arrow_right.svg'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: isLoading == true
                            ? () {}
                            : () {
                                toExit();
                              },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: redColor,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isLoading == true
                                  ? Container(
                                      // margin: EdgeInsets.only(right: 15),
                                      width: 24,
                                      height: 24,
                                      child: Platform.isAndroid
                                          ? Center(
                                              child: CircularProgressIndicator(
                                                color: white,
                                                strokeWidth: 2.5,
                                              ),
                                            )
                                          : Center(
                                              child: CupertinoActivityIndicator(
                                                color: white,
                                              ),
                                            ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/log_out.svg',
                                        ),
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
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).padding.bottom),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
