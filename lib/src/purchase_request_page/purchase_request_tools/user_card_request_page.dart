import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ttt_merchant_flutter/api/balance_api.dart';
import 'package:ttt_merchant_flutter/api/product_api.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/dialog/success_dialog.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/components/ui/form_textfield.dart';
import 'package:ttt_merchant_flutter/models/card_balance.dart';
import 'package:ttt_merchant_flutter/models/user_address.dart';
import 'package:ttt_merchant_flutter/models/user_card_request.dart';

class UserCardRequestPageArguments {
  final CardBalance data;
  UserCardRequestPageArguments({required this.data});
}

class UserCardRequestPage extends StatefulWidget {
  final CardBalance data;

  static const routeName = "UserCardRequestPage";
  const UserCardRequestPage({super.key, required this.data});

  @override
  State<UserCardRequestPage> createState() => _UserCardRequestPageState();
}

class _UserCardRequestPageState extends State<UserCardRequestPage>
    with AfterLayoutMixin {
  bool isLoadingPage = true;
  bool isLoading = false;
  GlobalKey<FormBuilderState> fbkeyPhone = GlobalKey<FormBuilderState>();
  GlobalKey<FormBuilderState> fbkeyToot = GlobalKey<FormBuilderState>();
  // Result addressData = Result();
  String? selectedDuuregId;
  String? selectedKhorooId;
  List<UserAddress> addressDatas = [];
  List<UserAddress> duuregs = [];
  List<UserAddress> khoroos = [];

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      addressDatas = await ProductApi().getAddress();
      setState(() {
        duuregs = addressDatas.where((item) => item.level == 2).toList();
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  onSubmit() async {
    if (fbkeyPhone.currentState!.saveAndValidate() &&
        fbkeyToot.currentState!.saveAndValidate() &&
        selectedDuuregId != null &&
        selectedKhorooId != null) {
      try {
        setState(() {
          isLoading = true;
        });

        UserCardRequest userCardRequest = UserCardRequest()
          ..phone = fbkeyPhone.currentState?.fields['phone']?.value
          // fbkeyPhone.currentState!.value.toString()
          ..registerNo = widget.data.userInfo?.registerNo
          ..lastName = widget.data.userInfo?.lastName
          ..firstName = widget.data.userInfo?.firstName
          ..level2 = selectedDuuregId
          ..level3 = selectedKhorooId
          ..additionalInformation =
              fbkeyToot.currentState?.fields['information']?.value
          ..passportAddress = widget.data.userInfo?.passportAddress;
        /*
  phone                : Joi.string().required(),
  registerNo           : Joi.string().required(),
  lastName             : Joi.string().required(),
  firstName            : Joi.string().required(),
  level2               : Joi.string().required(),
  level3               : Joi.string().required(),
  additionalInformation: Joi.string().optional().allow(null, ""),
  */
        await BalanceApi().userCardRequestCreate(userCardRequest);
        showSuccess(context, 'Таны хүсэлт амжилттай илгээгдлээ.');
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        print(e);
        setState(() {
          isLoading = false;
        });
      }
    }
    selectedDuuregId == null
        ? setState(() {
            showDuureg = true;
          })
        : setState(() {
            showDuureg = false;
          });
    selectedKhorooId == null
        ? setState(() {
            showKhoroo = true;
          })
        : setState(() {
            showKhoroo = false;
          });
  }

  bool showDuureg = false;
  bool showKhoroo = false;
  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(
      context,
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          centerTitle: false,
          elevation: 1,
          automaticallyImplyLeading: false,
          titleSpacing: 12,
          title: Text(
            'Картын мэдээлэл',
            style: TextStyle(
              color: black950,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 16),
                SvgPicture.asset('assets/svg/arrow_left_wide.svg'),
              ],
            ),
          ),
        ),
        backgroundColor: white50,
        body: isLoadingPage == true
            ? CustomLoader()
            : Stack(
                children: [
                  widget.data.cardRequest == null ||
                          widget.data.cardRequest?.requestStatus == "CANCELLED"
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(height: 16),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: black950,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            'Та түлш худалдан авах хүсэлт илгээх гэж байна. ',
                                      ),
                                      TextSpan(
                                        text: '"Тавантолгой Түлш ХХК"',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ), // зөвхөн энэ хэсэг w600
                                      ),
                                      TextSpan(
                                        text:
                                            ' таны хүсэлтийг баталгаажуулсны дараа  виртуал карт нээгдэнэ.',
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: white,
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Хувийн мэдээлэл',
                                        style: TextStyle(
                                          color: black400,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Овог',
                                              style: TextStyle(
                                                color: black800,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${widget.data.userInfo?.lastName}',
                                              style: TextStyle(
                                                color: black950,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Нэр',
                                              style: TextStyle(
                                                color: black800,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${widget.data.userInfo?.firstName}',
                                              style: TextStyle(
                                                color: black950,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Регистрийн дугаар',
                                              style: TextStyle(
                                                color: black800,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${widget.data.userInfo?.registerNo?.toUpperCase()}',

                                              style: TextStyle(
                                                color: black950,
                                                fontSize: 16,
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
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: white,
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Холбоо барих мэдээлэл',
                                        style: TextStyle(
                                          color: black400,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      FormBuilder(
                                        key: fbkeyPhone,
                                        child: Column(
                                          children: [
                                            FormTextField(
                                              contentPadding: EdgeInsets.all(
                                                12,
                                              ),
                                              dense: true,
                                              colortext: black,
                                              color: white50,
                                              name: 'phone',
                                              hintTextStyle: TextStyle(
                                                color: black500,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              hintText:
                                                  'Утасны дугаар оруулна уу.',
                                              // prefixIcon: Row(
                                              //   mainAxisSize: MainAxisSize.min,
                                              //   children: [
                                              //     SizedBox(width: 12),
                                              //     SvgPicture.asset(
                                              //       'assets/svg/login_phone.svg',
                                              //     ),
                                              //     SizedBox(width: 12),
                                              //   ],
                                              // ),
                                              borderRadius: 12,
                                              validator:
                                                  FormBuilderValidators.compose([
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
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: white,
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: FormBuilder(
                                    key: fbkeyToot,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Хаягийн мэдээлэл',
                                          style: TextStyle(
                                            color: black400,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        DropdownButtonFormField<String>(
                                          initialValue: selectedDuuregId,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,

                                          // decoration: const InputDecoration(
                                          //   labelText: "Дүүрэг сонгох",
                                          // ),
                                          decoration: InputDecoration(
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: BorderSide.none,
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide.none,
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide.none,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide.none,
                                            ),
                                            fillColor: white50,
                                            filled: true,
                                            isDense: true,
                                            hintText: 'Дүүрэг',
                                            hintStyle: TextStyle(
                                              color: black500,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            // dense: true,
                                          ),
                                          items: duuregs.map((duureg) {
                                            return DropdownMenuItem(
                                              value: duureg.id,
                                              child: Text(duureg.name!),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedDuuregId = value;
                                              selectedKhorooId = null; // reset

                                              // сонгосон дүүргийн _id == parent бүхий хороог гаргаж авна
                                              khoroos = addressDatas
                                                  .where(
                                                    (item) =>
                                                        item.level == 3 &&
                                                        item.parent ==
                                                            selectedDuuregId,
                                                  )
                                                  .toList();
                                            });
                                          },
                                          validator:
                                              FormBuilderValidators.compose([
                                                FormBuilderValidators.required(
                                                  errorText:
                                                      'Заавал оруулна уу.',
                                                ),
                                              ]),
                                        ),
                                        // showDuureg == false
                                        //     ? Column(
                                        //       children: [
                                        //         SizedBox(height: 6,),
                                        //         Text(''),
                                        //       ],
                                        //     )
                                        //     : SizedBox(),
                                        const SizedBox(height: 12),
                                        DropdownButtonFormField<String>(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          decoration: InputDecoration(
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: BorderSide.none,
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide.none,
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide.none,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide.none,
                                            ),
                                            fillColor: white50,
                                            filled: true,
                                            isDense: true,
                                            // dense: true,
                                            hintText: 'Хороо/Баг',
                                            hintStyle: TextStyle(
                                              color: black500,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          initialValue: selectedKhorooId,

                                          items: khoroos.map((khoroo) {
                                            return DropdownMenuItem(
                                              value: khoroo.id,
                                              child: Text(khoroo.name!),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedKhorooId = value;
                                            });
                                          },
                                          validator:
                                              FormBuilderValidators.compose([
                                                FormBuilderValidators.required(
                                                  errorText:
                                                      'Заавал оруулна уу.',
                                                ),
                                              ]),
                                        ),
                                        // showKhoroo == false
                                        //     ? Text('showKhoroo')
                                        //     : SizedBox(),
                                        const SizedBox(height: 12),
                                        Column(
                                          children: [
                                            FormTextField(
                                              inputType: TextInputType.text,
                                              contentPadding: EdgeInsets.all(
                                                12,
                                              ),
                                              dense: true,
                                              colortext: black,
                                              color: white50,
                                              name: 'information',
                                              hintTextStyle: TextStyle(
                                                color: black500,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              hintText: 'Гудамж/Тоот',
                                              // prefixIcon: Row(
                                              //   mainAxisSize: MainAxisSize.min,
                                              //   children: [
                                              //     SizedBox(width: 12),
                                              //     SvgPicture.asset(
                                              //       'assets/svg/login_phone.svg',
                                              //     ),
                                              //     SizedBox(width: 12),
                                              //   ],
                                              // ),
                                              borderRadius: 12,
                                              maxLines: 5,
                                              validator:
                                                  FormBuilderValidators.compose([
                                                    FormBuilderValidators.required(
                                                      errorText:
                                                          'Заавал оруулна уу.',
                                                    ),
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // SizedBox(height: 16),
                                // Container(
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(12),
                                //     color: white,
                                //   ),
                                //   padding: EdgeInsets.all(12),
                                //   child: Column(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children: [
                                //       Text(
                                //         'Нэмэлт тайлбар',
                                //         style: TextStyle(
                                //           color: black400,
                                //           fontSize: 14,
                                //           fontWeight: FontWeight.w400,
                                //         ),
                                //       ),
                                //       SizedBox(height: 8),
                                //       FormBuilder(
                                //         key: fbkeyNote,
                                //         child: FormTextField(
                                //           contentPadding: EdgeInsets.all(12),
                                //           dense: true,
                                //           colortext: black,
                                //           color: white50,
                                //           name: 'note',
                                //           hintTextStyle: TextStyle(
                                //             color: black500,
                                //             fontSize: 14,
                                //             fontWeight: FontWeight.w400,
                                //           ),
                                //           hintText: 'Тайлбар бичнэ үү.',
                                //           // prefixIcon: Row(
                                //           //   mainAxisSize: MainAxisSize.min,
                                //           //   children: [
                                //           //     SizedBox(width: 12),
                                //           //     SvgPicture.asset(
                                //           //       'assets/svg/login_phone.svg',
                                //           //     ),
                                //           //     SizedBox(width: 12),
                                //           //   ],
                                //           // ),
                                //           borderRadius: 12,
                                //           maxLines: 5,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).padding.bottom +
                                      200,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                    color: black950,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          'Виртуаль картын хүсэлт илгээгдсэн байна. Хүсэлттэй холбоотой  мэдээллийг ',
                                    ),
                                    TextSpan(
                                      text: '70119400',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ), // зөвхөн энэ хэсэг w600
                                    ),
                                    TextSpan(text: ' дугаараас авна уу.'),
                                  ],
                                ),
                              ),
                              // Text(
                              //   'Виртуаль картын хүсэлт илгээгдсэн байна. Хүсэлттэй холбоотой  мэдээллийг 70119400 дугаараас авна уу.',
                              //   style: TextStyle(
                              //     color: black950,
                              //     fontSize: 14,
                              //     fontWeight: FontWeight.w400,
                              //   ),
                              //   textAlign: TextAlign.center,
                              // ),
                            ),
                          ],
                        ),
                  !isKeyboardVisible
                      ? Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Container(
                            color: white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 16,
                                right: 16,
                                left: 16,
                                bottom: Platform.isIOS
                                    ? MediaQuery.of(context).padding.bottom
                                    : MediaQuery.of(context).padding.bottom +
                                          16,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.data.cardRequest == null ||
                                          widget
                                                  .data
                                                  .cardRequest
                                                  ?.requestStatus ==
                                              "CANCELLED"
                                      ? Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: white,
                                                border: Border.all(
                                                  color: white100,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/svg/shield_warning.svg',
                                                  ),
                                                  SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      'Уг хэрэглэгч түлш худалдан авах эрхгүй байна , виртуал картын хүсэлт илгээх хэрэгтэй.',
                                                      style: TextStyle(
                                                        color: redColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 16),
                                          ],
                                        )
                                      : SizedBox(),
                                  widget.data.cardRequest == null ||
                                          widget
                                                  .data
                                                  .cardRequest
                                                  ?.requestStatus ==
                                              "CANCELLED"
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: isLoading == true
                                                    ? () {}
                                                    : () {
                                                        // onSubmit();
                                                        Navigator.of(
                                                          context,
                                                        ).pop();
                                                      },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    color: white,
                                                    border: Border.all(
                                                      color: white100,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Болих',
                                                        style: TextStyle(
                                                          color: black950,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 16),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: isLoading == true
                                                    ? () {}
                                                    : () {
                                                        onSubmit();
                                                      },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    color: orange,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      isLoading == true
                                                          ? Container(
                                                              // margin: EdgeInsets.only(right: 15),
                                                              width: 17,
                                                              height: 17,
                                                              child:
                                                                  Platform
                                                                      .isAndroid
                                                                  ? Center(
                                                                      child: CircularProgressIndicator(
                                                                        color:
                                                                            white,
                                                                        strokeWidth:
                                                                            2.5,
                                                                      ),
                                                                    )
                                                                  : Center(
                                                                      child: CupertinoActivityIndicator(
                                                                        color:
                                                                            white,
                                                                      ),
                                                                    ),
                                                            )
                                                          : Text(
                                                              'Илгээх',
                                                              style: TextStyle(
                                                                color: white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: isLoading == true
                                                    ? () {}
                                                    : () {
                                                        // onSubmit();
                                                        Navigator.of(
                                                          context,
                                                        ).pop();
                                                      },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    color: white,
                                                    border: Border.all(
                                                      color: white100,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Болих',
                                                        style: TextStyle(
                                                          color: black950,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
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
                        )
                      : SizedBox(),
                ],
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
