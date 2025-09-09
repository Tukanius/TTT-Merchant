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
import 'package:ttt_merchant_flutter/src/auth/login_page.dart';
import 'package:ttt_merchant_flutter/src/splash_page/splash_page.dart';

class UserSetPasswordPage extends StatefulWidget {
  static const routeName = "UserSetPasswordPage";
  const UserSetPasswordPage({super.key});

  @override
  State<UserSetPasswordPage> createState() => _UserSetPasswordPageState();
}

class _UserSetPasswordPageState extends State<UserSetPasswordPage> {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  Color combinationColor = gray600;
  Color lengthColor = gray600;
  bool combinationGood = false;
  bool combLenghtGood = false;
  void validatePassword(String value) {
    setState(() {
      RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$').hasMatch(value)
          ? combinationGood = true
          : combinationGood = false;

      value.length >= 8 ? combLenghtGood = true : combLenghtGood = false;
    });
  }

  onSubmit() async {
    FocusScope.of(context).unfocus();
    if (fbkey.currentState!.saveAndValidate() &&
        combinationGood == true &&
        combLenghtGood == true) {
      try {
        setState(() {
          isLoading = true;
        });
        User save = User.fromJson(fbkey.currentState!.value);
        await Provider.of<UserProvider>(
          context,
          listen: false,
        ).setPassword(save);
        // await Provider.of<UserProvider>(context, listen: false).me(false);

        // await Navigator.of(context).pushNamed(SplashPage.routeName);
        showSuccess(context);
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print(e.toString());
      }
    }
  }

  onExit() async {
    try {
      await Provider.of<UserProvider>(context, listen: false).logout();
      Navigator.of(context).pushNamed(SplashPage.routeName);
    } catch (e) {
      print(e);
    }
  }

  showSuccess(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: white100),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SvgPicture.asset('assets/svg/success.svg'),
                SizedBox(height: 12),
                Text(
                  'Амжилттай',
                  style: TextStyle(
                    color: successColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Таны нууц үг амжилттай шинэчлэгдлээ.',
                  style: const TextStyle(
                    color: black500,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(LoginPage.routeName);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: orange,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Болсон',
                          style: TextStyle(
                            color: white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(height: 16),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.of(context).pop();
                //     Navigator.of(context).pop();
                //     Navigator.of(context).pop();
                //     // Navigator.of(
                //     //   context,
                //     // ).pushNamed(PurchaseHistoryPage.routeName);
                //   },
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(12),
                //       color: white,
                //       border: Border.all(color: white100),
                //     ),
                //     padding: EdgeInsets.symmetric(vertical: 10),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text(
                //           'Листээс харах',
                //           style: TextStyle(
                //             color: black800,
                //             fontSize: 14,
                //             fontWeight: FontWeight.w600,
                //             decoration: TextDecoration.none,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
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
                        SizedBox(height: 30),
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
                              'Шинэ нууц үг',
                              style: TextStyle(
                                color: black950,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Та шинэ нууц үг оруулна уу.',
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
                                    hintTextStyle: TextStyle(
                                      color: black500,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    hintText: 'Хуучин нууц үг',
                                    dense: true,
                                    color: white50,
                                    name: 'oldPassword',
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
                                    // suffixIcon: Row(
                                    //   mainAxisSize: MainAxisSize.min,
                                    //   children: [
                                    //     InkWell(
                                    //       overlayColor: WidgetStateProperty.all(
                                    //         transparent,
                                    //       ),
                                    //       onTap: () {
                                    //         setState(() {
                                    //           isVisible = !isVisible;
                                    //         });
                                    //       },
                                    //       child: isVisible == false
                                    //           ? Icon(
                                    //               Icons.visibility,
                                    //               color: black950,
                                    //             )
                                    //           : Icon(
                                    //               Icons.visibility_off,
                                    //               color: black950,
                                    //             ),
                                    //     ),
                                    //     SizedBox(width: 14),
                                    //   ],
                                    // ),
                                    // onChanged: (value) {
                                    //   validatePassword(value);
                                    // },
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        errorText: 'Нууц үгээ оруулна уу.',
                                      ),
                                    ]),
                                  ),
                                  SizedBox(height: 8),
                                  FormTextField(
                                    contentPadding: EdgeInsets.all(12),
                                    hintTextStyle: TextStyle(
                                      color: black500,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    hintText: 'Шинэ нууц үг',
                                    dense: true,
                                    color: white50,
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
                                    // suffixIcon: Row(
                                    //   mainAxisSize: MainAxisSize.min,
                                    //   children: [
                                    //     InkWell(
                                    //       overlayColor: WidgetStateProperty.all(
                                    //         transparent,
                                    //       ),
                                    //       onTap: () {
                                    //         setState(() {
                                    //           isVisible = !isVisible;
                                    //         });
                                    //       },
                                    //       child: isVisible == false
                                    //           ? Icon(
                                    //               Icons.visibility,
                                    //               color: black950,
                                    //             )
                                    //           : Icon(
                                    //               Icons.visibility_off,
                                    //               color: black950,
                                    //             ),
                                    //     ),
                                    //     SizedBox(width: 14),
                                    //   ],
                                    // ),
                                    onChanged: (value) {
                                      validatePassword(value);
                                    },
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        errorText: 'Нууц үгээ оруулна уу.',
                                      ),
                                    ]),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        combinationGood == true
                                            ? 'assets/svg/pass_check.svg'
                                            : 'assets/svg/pass_com.svg',
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          'Нууц үг хамгийн багадаа 8 оротой байх',
                                          style: TextStyle(
                                            color: black800,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        combLenghtGood == true
                                            ? 'assets/svg/pass_check.svg'
                                            : 'assets/svg/pass_com.svg',
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          'Тоо жижиг үсэг холилдсон байх',
                                          style: TextStyle(
                                            color: black800,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  FormTextField(
                                    contentPadding: EdgeInsets.all(12),
                                    hintTextStyle: TextStyle(
                                      color: black500,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    hintText: 'Шинэ нууц үг давтах',
                                    dense: true,
                                    color: white50,
                                    name: 'passwordVerify',
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
                                    // suffixIcon: Row(
                                    //   mainAxisSize: MainAxisSize.min,
                                    //   children: [
                                    //     InkWell(
                                    //       overlayColor: WidgetStateProperty.all(
                                    //         transparent,
                                    //       ),
                                    //       onTap: () {
                                    //         setState(() {
                                    //           isVisible = !isVisible;
                                    //         });
                                    //       },
                                    //       child: isVisible == false
                                    //           ? Icon(
                                    //               Icons.visibility,
                                    //               color: black950,
                                    //             )
                                    //           : Icon(
                                    //               Icons.visibility_off,
                                    //               color: black950,
                                    //             ),
                                    //     ),
                                    //     SizedBox(width: 14),
                                    //   ],
                                    // ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        errorText: 'Нууц үгээ оруулна уу.',
                                      ),
                                      (value) {
                                        if (fbkey
                                                .currentState
                                                ?.fields['password']
                                                ?.value !=
                                            value) {
                                          return 'Нууц үг таарахгүй байна.';
                                        }
                                        return null;
                                      },
                                    ]),
                                  ),
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
                                      onExit();
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
                                            'Болих',
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
