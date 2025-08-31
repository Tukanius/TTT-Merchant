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
import 'package:ttt_merchant_flutter/src/auth/forget_password_page.dart';
import 'package:ttt_merchant_flutter/src/splash_page/splash_page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "LoginPage";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  bool isVisible = true;
  bool isLoading = false;

  onSubmit() async {
    FocusScope.of(context).unfocus();
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isLoading = true;
        });
        // if (saveIsUsername == true) {
        //   email = fbkey.currentState?.fields['email']?.value;
        //   _storePhone(email);
        // } else {
        //   secureStorage.deleteAll();
        // }
        User save = User.fromJson(fbkey.currentState!.value);
        await Provider.of<UserProvider>(context, listen: false).login(save);
        // UserProvider().setUsername(save.username.toString());
        setState(() {
          isLoading = false;
        });
        await Navigator.of(context).pushNamed(SplashPage.routeName);
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print(e.toString());
      }
    }
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
                              'Нэвтрэх',
                              style: TextStyle(
                                color: black950,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Хэрэглэгчийн бүртгэлээр нэвтрэх',
                              style: TextStyle(
                                color: black600,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 32),
                            FormBuilder(
                              key: fbkey,
                              child: Column(
                                children: [
                                  FormTextField(
                                    contentPadding: EdgeInsets.all(12),
                                    dense: true,
                                    colortext: black,
                                    color: white50,
                                    name: 'username',
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
                                    validator: FormBuilderValidators.compose([
                                      (value) {
                                        return validatePhoneNumber(
                                          context,
                                          value.toString(),
                                        );
                                      },
                                    ]),
                                  ),
                                  SizedBox(height: 16),
                                  FormTextField(
                                    contentPadding: EdgeInsets.all(12),
                                    hintTextStyle: TextStyle(
                                      color: black500,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    hintText: 'Нууц үг',
                                    dense: true,
                                    color: white50,
                                    obscureText: isVisible,
                                    name: 'password',
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
                                    suffixContraints: BoxConstraints(
                                      maxHeight: 20,
                                    ),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          overlayColor: WidgetStateProperty.all(
                                            transparent,
                                          ),
                                          onTap: () {
                                            setState(() {
                                              isVisible = !isVisible;
                                            });
                                          },
                                          child: isVisible == false
                                              ? Icon(
                                                  Icons.visibility,
                                                  color: black950,
                                                )
                                              : Icon(
                                                  Icons.visibility_off,
                                                  color: black950,
                                                ),
                                        ),
                                        SizedBox(width: 14),
                                      ],
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        errorText: 'Нууц үгээ оруулна уу.',
                                      ),
                                    ]),
                                  ),
                                  SizedBox(height: 12),
                                ],
                              ),
                            ),
                            SizedBox(height: 28),

                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      onSubmit();
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
                                                  'Нэвтрэх',
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
                                      Navigator.of(
                                        context,
                                      ).pushNamed(ForgetPasswordPage.routeName);
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
                                          Text(
                                            'Нууц үг мартсан?',
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
