import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';

class AcceptOrderModal extends StatefulWidget {
  const AcceptOrderModal({super.key});

  @override
  State<AcceptOrderModal> createState() => _AcceptOrderModalState();
}

class _AcceptOrderModalState extends State<AcceptOrderModal>
    with AfterLayoutMixin {
  TextEditingController pinput = TextEditingController();

  bool isLoading = false;
  final defaultPinTheme = PinTheme(
    width: 80,
    height: 62,
    textStyle: TextStyle(
      fontSize: 16,
      color: black,
      fontWeight: FontWeight.w700,
    ),
    decoration: BoxDecoration(
      color: white,
      border: Border.all(color: white100),
      borderRadius: BorderRadius.circular(8),
    ),
  );
  @override
  afterFirstLayout(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: white50,
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: black300,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Жолооч баталгаажуулах',
                style: TextStyle(
                  color: black950,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16),
              // Padding(
              //   padding: const EdgeInsets.all(16),
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(12),
              //       color: white,
              //     ),
              //     padding: EdgeInsets.all(14),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           'Захиалгын мэдээлэл',
              //           style: TextStyle(
              //             color: black400,
              //             fontSize: 12,
              //             fontWeight: FontWeight.w400,
              //           ),
              //         ),
              //         SizedBox(height: 8),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Түлш төрөл:',
              //               style: TextStyle(
              //                 color: black800,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               'Хатуу түлш',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 4),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Тоо, хэмжээ:',
              //               style: TextStyle(
              //                 color: black800,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               '12,000 ш',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 16),
              //         Container(
              //           height: 1,
              //           color: black200,
              //           width: MediaQuery.of(context).size.width,
              //         ),
              //         SizedBox(height: 16),
              //         Text(
              //           'Тээврийн мэдээлэл',
              //           style: TextStyle(
              //             color: black400,
              //             fontSize: 12,
              //             fontWeight: FontWeight.w400,
              //           ),
              //         ),
              //         SizedBox(height: 8),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Улсын дугаар:',
              //               style: TextStyle(
              //                 color: black800,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               'УБА 3213',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 4),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Тээврийн компани:',
              //               style: TextStyle(
              //                 color: black800,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               'УБА 3213',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 4),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Марк:',
              //               style: TextStyle(
              //                 color: black800,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               'М2',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 4),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Жолооч:',
              //               style: TextStyle(
              //                 color: black800,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               'Б.Батбаяр',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 4),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Жолоочийн утасны дугаар:',
              //               style: TextStyle(
              //                 color: black800,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               '88888888',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 16),
              //         Container(
              //           height: 1,
              //           color: black200,
              //           width: MediaQuery.of(context).size.width,
              //         ),
              //         SizedBox(height: 16),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Илгээсэн:',
              //               style: TextStyle(
              //                 color: black800,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               '20,000 ш ',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 4),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Хүлээн авсан:',
              //               style: TextStyle(
              //                 color: black800,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               '12,000 ш',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 4),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Дутсан :',
              //               style: TextStyle(
              //                 color: black800,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               '8,000 ш',
              //               style: TextStyle(
              //                 color: redColor,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 16),
              //         Container(
              //           height: 1,
              //           color: black200,
              //           width: MediaQuery.of(context).size.width,
              //         ),
              //         SizedBox(height: 16),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               'Үнэ:',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //             Text(
              //               '18,000.00₮',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 2),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text(
              //               '1ш: 5,000₮',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //             Text(
              //               '4x5,000₮',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 16),
              //         Row(
              //           children: [
              //             Expanded(
              //               child: LayoutBuilder(
              //                 builder: (context, constraints) {
              //                   final boxWidth = constraints.constrainWidth();
              //                   const dashWidth = 20.0;
              //                   const dashSpace = 6.0;
              //                   final dashCount =
              //                       (boxWidth / (dashWidth + dashSpace))
              //                           .floor();

              //                   return Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: List.generate(dashCount, (_) {
              //                       return Container(
              //                         width: dashWidth,
              //                         height: 3,
              //                         decoration: BoxDecoration(
              //                           color: orange,
              //                           borderRadius: BorderRadius.circular(
              //                             100,
              //                           ),
              //                         ),
              //                       );
              //                     }),
              //                   );
              //                 },
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 16),
              //         Text(
              //           'Нийт хүлээн авсан тоо:',
              //           style: TextStyle(
              //             color: black950,
              //             fontSize: 16,
              //             fontWeight: FontWeight.w600,
              //           ),
              //         ),
              //         SizedBox(height: 4),
              //         Row(
              //           children: [
              //             Text(
              //               '12 тон ',
              //               style: TextStyle(
              //                 color: orange,
              //                 fontSize: 26,
              //                 fontWeight: FontWeight.w700,
              //               ),
              //             ),
              //             Text(
              //               '15ш',
              //               style: TextStyle(
              //                 color: black950,
              //                 fontSize: 18,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: white,
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Жолоочын бааталгаажуулах 4 оронтой кодыг оруулна уу.',
                        style: TextStyle(
                          color: black950,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Pinput(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        closeKeyboardWhenCompleted: true,
                        // onCompleted: (value) => checkOpt(value),
                        controller: pinput,
                        // validator: (value) {
                        //   return value == "${user.otpCode}"
                        //       ? null
                        //       : local.translate('verification_incorrect');
                        // },
                        length: 4,
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        defaultPinTheme: defaultPinTheme,
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(color: errorColor),
                        ),
                        errorTextStyle: TextStyle(
                          color: errorColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: orange,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isLoading == true
                                ? Container(
                                    // margin: EdgeInsets.only(right: 15),
                                    width: 17,
                                    height: 17,
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
                                : Text(
                                    'Батлах',
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
                  SizedBox(width: 16),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
            ],
          ),
        ),
      ),
    );
  }
}
