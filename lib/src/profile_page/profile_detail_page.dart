// ignore_for_file: deprecated_member_use

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ttt_merchant_flutter/api/auth_api.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/general/general_init.dart';
import 'package:ttt_merchant_flutter/models/user.dart';
import 'package:ttt_merchant_flutter/provider/user_provider.dart';
import 'package:ttt_merchant_flutter/src/splash_page/splash_page.dart';

class ProfileDetailPageArguments {
  final GeneralInit data;

  ProfileDetailPageArguments({required this.data});
}

class ProfileDetailPage extends StatefulWidget {
  final GeneralInit data;
  static const routeName = 'ProfileDetailPage';
  const ProfileDetailPage({super.key, required this.data});

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage>
    with AfterLayoutMixin {
  User user = User();
  bool isLoadingPage = true;

  @override
  afterFirstLayout(BuildContext context) async {
    try {
      user = await AuthApi().me(false);
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = false;
      });
    }
  }

  bool isClose = true;
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
      await Provider.of<UserProvider>(context, listen: false).logout();
      Navigator.of(dialogContext).pop();
      Navigator.of(context).pushNamed(SplashPage.routeName);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: false,
        elevation: 1,
        automaticallyImplyLeading: false,
        titleSpacing: 12,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 16),
              SvgPicture.asset('assets/svg/arrow_left_wide.svg'),
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.data.inventory?.name ?? '-'}',
              style: TextStyle(
                color: black950,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: green.withOpacity(0.13),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              child: Text(
                '${widget.data.inventory?.name ?? '-'}',
                style: TextStyle(
                  color: green,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.scale(
                scale: 24 / 31,
                child: Switch.adaptive(
                  value: isClose,
                  onChanged: (value) => setState(() => isClose = value),
                  activeColor: orange,
                ),
              ),

              SizedBox(width: 16),
            ],
          ),
        ],
      ),
      backgroundColor: white50,
      body: isLoadingPage == true
          ? CustomLoader()
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsGeometry.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                                '${widget.data.inventory?.name ?? '-'}',
                                style: TextStyle(
                                  color: black800,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(12),
                    //     color: orange,
                    //   ),
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 12,
                    //     vertical: 10,
                    //   ),
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       SvgPicture.asset(
                    //         'assets/svg/edit.svg',
                    //         color: white,
                    //         height: 18,
                    //         width: 18,
                    //       ),
                    //       SizedBox(width: 8),
                    //       Text(
                    //         'Утасны дугаар солих',
                    //         style: TextStyle(
                    //           color: white,
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: 16),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(12),
                    //     color: orange,
                    //   ),
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 12,
                    //     vertical: 10,
                    //   ),
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       SvgPicture.asset(
                    //         'assets/svg/edit.svg',
                    //         color: white,
                    //         height: 18,
                    //         width: 18,
                    //       ),
                    //       SizedBox(width: 8),
                    //       Text(
                    //         'Нууц үг солих',
                    //         style: TextStyle(
                    //           color: white,
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: 16),
                    Text(
                      'Ажилтны мэдээлэл',
                      style: TextStyle(
                        color: black600,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: white,
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Овог нэр:',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${user.firstName} ${user.lastName}',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Утасны дугаар:',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${user.phone ?? '-'}',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Борлуулагч болсон огноо:',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${DateFormat('yyyy/MM/dd HH:mm').format(DateTime.parse(user.createdAt!).toLocal())}',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Салбарын мэдээлэл',
                      style: TextStyle(
                        color: black600,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: white,
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Салбарын дугаар:',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Салбарын утасны дугаар:',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '-',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Салбарын хаяг:',
                                  style: TextStyle(
                                    color: black950,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${widget.data.inventory?.address?.additionalInformation ?? '-'}',
                                  style: TextStyle(
                                    color: black950,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Цагийн хуваарь',
                          style: TextStyle(
                            color: black600,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () {},
                        //   child: Row(
                        //     children: [
                        //       SvgPicture.asset(
                        //         'assets/svg/edit.svg',
                        //         height: 16,
                        //         width: 16,
                        //       ),
                        //       SizedBox(width: 4),
                        //       Text(
                        //         'Өөрчлөх',
                        //         style: TextStyle(
                        //           color: black800,
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.w400,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: white,
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Даваа:',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '09:00 - 21:00',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Мягмар:',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '09:00 - 21:00',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Лхагва:',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '09:00 - 21:00',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Пүрэв:',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '09:00 - 21:00',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Баасан:',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '09:00 - 21:00',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Бямба:',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '09:00 - 21:00',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ням:',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Амарна',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
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
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom + 16,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
