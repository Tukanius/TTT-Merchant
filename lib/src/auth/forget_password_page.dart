// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/components/ui/form_textfield.dart';
import 'package:ttt_merchant_flutter/models/user.dart';
import 'package:ttt_merchant_flutter/provider/user_provider.dart';
import 'package:ttt_merchant_flutter/src/auth/set_password_page.dart';

class ForgetPasswordPage extends StatefulWidget {
  static const routeName = "ForgetPasswordPage";
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  GlobalKey<FormBuilderState> fbkeyPhone = GlobalKey<FormBuilderState>();
  GlobalKey<FormBuilderState> fbkeyOtp = GlobalKey<FormBuilderState>();
  TextEditingController otpController = TextEditingController();
  bool isLoading = false;
  User user = User();
  int _counter = 180;
  bool isGetCode = false;
  bool readOnlyPhone = false;
  late Timer _timer;

  getOtp() async {
    if (fbkeyPhone.currentState!.saveAndValidate()) {
      try {
        User save = User.fromJson(fbkeyPhone.currentState!.value);
        await Provider.of<UserProvider>(
          context,
          listen: false,
        ).forgetPassword(save);
        user = await Provider.of<UserProvider>(
          context,
          listen: false,
        ).getOtp("FORGOT", "PHONE");
        setState(() {
          FocusScope.of(context).unfocus();
          isGetCode = true;
          readOnlyPhone = true;
        });
        _startTimer();
      } catch (e) {
        setState(() {
          isGetCode = false;
          readOnlyPhone = false;
        });
        print(e);
      }
    }
  }

  onSubmitOtp() async {
    FocusScope.of(context).unfocus();
    if (fbkeyOtp.currentState!.saveAndValidate() &&
        fbkeyPhone.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isLoading = true;
        });
        user.otpCode = otpController.text;
        await await Provider.of<UserProvider>(
          context,
          listen: false,
        ).otpVerify(user);
        await Navigator.of(context).pushNamed(SetPasswordPage.routeName);
        setState(() {
          isLoading = true;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print(e.toString());
      }
    }
  }

  void _startTimer() async {
    _counter = 180;
    _timer = await Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        setState(() {
          isGetCode = false;
          readOnlyPhone = false;
          otpController.clear();
        });
        _timer.cancel();
      }
    });
  }

  String intToTimeLeft(int value) {
    int h, m, s;
    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);
    String minutes = m.toString().padLeft(2, '0');
    String seconds = s.toString().padLeft(2, '0');
    String result = "$minutes:$seconds";
    return result;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(
      context,
    );
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: white50,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: mediaQuery.padding.top + 16),
                        Image.asset('assets/icon/ttt_logo.png'),
                        SizedBox(height: 40),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 32,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Text(
                              'Нууц үг мартсан',
                              style: TextStyle(
                                color: black950,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Бүртгэлтэй утасны дугаараа оруулна уу.',
                              style: TextStyle(
                                color: black600,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 32),
                            FormBuilder(
                              key: fbkeyPhone,
                              child: Column(
                                children: [
                                  FormTextField(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 2,
                                    ),
                                    dense: true,
                                    colortext: black,
                                    color: white50,
                                    name: 'phone',
                                    readOnly: readOnlyPhone,
                                    hintTextStyle: TextStyle(
                                      color: black500,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    hintText: 'Утасны дугаар',
                                    prefixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(width: 12),
                                        SvgPicture.asset(
                                          'assets/svg/login_phone.svg',
                                        ),
                                        SizedBox(width: 12),
                                      ],
                                    ),
                                    borderRadius: 12,
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(width: 12),
                                        GestureDetector(
                                          onTap: () {
                                            isGetCode == true
                                                ? () {}
                                                : getOtp();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: isGetCode == true
                                                  ? orange.withOpacity(0.2)
                                                  : orange,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 24,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  isGetCode == true
                                                      ? '${intToTimeLeft(_counter)} '
                                                      : 'Код авах',
                                                  style: TextStyle(
                                                    color: isGetCode == true
                                                        ? black600
                                                        : white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                      ],
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      (value) {
                                        return validatePhoneNumber(
                                          context,
                                          value.toString(),
                                        );
                                      },
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            FormBuilder(
                              key: fbkeyOtp,
                              child: Column(
                                children: [
                                  FormTextField(
                                    controller: otpController,
                                    contentPadding: EdgeInsets.all(12),
                                    hintTextStyle: TextStyle(
                                      color: black500,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    hintText: 'Баталгаажуулах код',
                                    dense: true,
                                    color: white50,
                                    name: 'otp',
                                    prefixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(width: 12),
                                        SvgPicture.asset(
                                          'assets/svg/login_password.svg',
                                        ),
                                        SizedBox(width: 12),
                                      ],
                                    ),
                                    borderRadius: 12,
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        errorText:
                                            'Баталгаажуулах код оруулна уу.',
                                      ),
                                    ]),
                                  ),
                                  SizedBox(height: 12),
                                ],
                              ),
                            ),
                            isGetCode == true
                                ? Column(
                                    children: [
                                      SizedBox(height: 6),
                                      Text(
                                        user.message!,
                                        style: TextStyle(
                                          color: black800,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            SizedBox(height: 28),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      onSubmitOtp();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: orange,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          isLoading == true
                                              ? Container(
                                                  // margin: EdgeInsets.only(right: 15),
                                                  width: 17,
                                                  height: 17,
                                                  child: Platform.isAndroid
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                                color: white,
                                                                strokeWidth:
                                                                    2.5,
                                                              ),
                                                        )
                                                      : Center(
                                                          child:
                                                              CupertinoActivityIndicator(
                                                                color: white,
                                                              ),
                                                        ),
                                                )
                                              : Text(
                                                  'Үргэлжлүүлэх',
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
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: white100),
                                        color: white,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // SvgPicture.asset(
                                          //   'assets/svg/arrow_left.svg',
                                          // ),
                                          // SizedBox(width: 8),
                                          Text(
                                            'Нэвтрэх',
                                            style: TextStyle(
                                              color: black800,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: mediaQuery.padding.bottom + 24),
                    // Column(
                    //   children: [
                    //     Text(
                    //       '© 2025 Таван толгой түлш ХХК',
                    //       style: TextStyle(
                    //         color: black400,
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.w400,
                    //       ),
                    //     ),
                    //     SizedBox(height: mediaQuery.padding.bottom),
                    //   ],
                    // ),
                  ],
                ),
              ),
              !isKeyboardVisible
                  ? Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: 16,
                          left: 16,
                          bottom: Platform.isIOS
                              ? MediaQuery.of(context).padding.bottom
                              : MediaQuery.of(context).padding.bottom + 16,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '© 2025 Таван толгой түлш ХХК',
                              style: TextStyle(
                                color: black400,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
              // Positioned(bottom: 0, right: 0, left: 0, child: Text('data')),
            ],
          ),
        ),
      ),
    );
  }
}

String? validatePhoneNumber(BuildContext context, String value) {
  RegExp regex = RegExp(r'^\d{8,}$');

  if (value.isEmpty) {
    return 'Утасны дугаараа оруулна уу.';
  } else if (!regex.hasMatch(value)) {
    return 'Зөв утасны дугаар оруулна уу.';
  } else {
    return null;
  }
}
