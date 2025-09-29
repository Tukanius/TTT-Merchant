// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:ttt_merchant_flutter/api/auth_api.dart';
import 'package:ttt_merchant_flutter/api/product_api.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/inspector_models/inspector_model.dart';
import 'package:ttt_merchant_flutter/models/user.dart';
import 'package:ttt_merchant_flutter/src/main_page.dart';

class IncomeInspectorDetailArguments {
  final String id;
  IncomeInspectorDetailArguments({required this.id});
}

class IncomeInspectorDetail extends StatefulWidget {
  final String id;
  static const routeName = "IncomeInspectorDetail";
  const IncomeInspectorDetail({super.key, required this.id});

  @override
  State<IncomeInspectorDetail> createState() => _IncomeInspectorDetailState();
}

class _IncomeInspectorDetailState extends State<IncomeInspectorDetail>
    with AfterLayoutMixin {
  bool isLoadingPage = true;
  InspectorModel incomeData = InspectorModel();
  bool isLoading = false;
  User user = User();
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      incomeData = await ProductApi().getInspectorItem(widget.id);
      user = await AuthApi().me(false);
      if (incomeData.orderProducts != null) {
        for (var i = 0; i < incomeData.orderProducts!.length; i++) {
          _controllers[i] = TextEditingController(
            text: incomeData.orderProducts![i].totalCount.toString(),
          );
          _editedQuantities[i] = incomeData.orderProducts![i].totalCount!;
        }
      }
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  final Map<int, TextEditingController> _controllers = {};
  final Map<int, int> _editedQuantities = {};
  String compNote = '';
  // ConfirmIncomeRequest confirmRequest = ConfirmIncomeRequest();
  // List<Products>? receiveProdut;
  TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    for (var c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  // /scl/app/receipt/:${Method.mongoId("id")}/confirm
  onSubmit() {
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
              'Баталгаажуулах',
              style: TextStyle(
                color: black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          content: Text(
            'Та захиалга баталгаажуулахдаа итгэлтэй байна уу.',
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
      Navigator.of(dialogContext).pop();
      await ProductApi().putInspector(incomeData.id!);
      await showSuccess(context, 'Захиалга амжилттай баталгаажлаа.');
      setState(() {
        isLoading = false;
      });
      // Navigator.of(context).pushNamed(SplashPage.routeName);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  showSuccess(context, String body) {
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
                  body,
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
                    Navigator.of(context).pushNamed(
                      MainPage.routeName,
                      arguments: MainPageArguments(
                        changeIndex: 0,
                        userType: user.userType!,
                      ),
                    );
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
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: false,
        elevation: 1,
        automaticallyImplyLeading: false,
        titleSpacing: 12,
        title: Text(
          'Дэлгэрэнгүй',
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
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${incomeData.contractNo ?? '-'}',
                                  style: TextStyle(
                                    color: black950,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${DateFormat('yyyy/MM/dd HH:mm').format(DateTime.parse(incomeData.createdAt!).toLocal())}',
                                  style: TextStyle(
                                    color: black400,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: incomeData.receiptStatus == "CANCELED"
                                    ? redColor.withOpacity(0.1)
                                    : incomeData.receiptStatus == "NEW" ||
                                          incomeData.receiptStatus ==
                                              "PENDING" ||
                                          incomeData.receiptStatus ==
                                              "FINANCE_APPROVED"
                                    ? orange.withOpacity(0.1)
                                    : green.withOpacity(0.1),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 4,
                              ),
                              child: Text(
                                '${incomeData.receiptStatus == "NEW"
                                    ? 'Шинэ'
                                    : incomeData.receiptStatus == "PENDING"
                                    ? 'Хүлээгдэж буй'
                                    : incomeData.receiptStatus == "FACTORY_APPROVED"
                                    ? 'Баталгаажсан'
                                    : incomeData.receiptStatus == "FINANCE_APPROVED"
                                    ? 'Төлбөр баталгаажсан'
                                    : incomeData.receiptStatus == "CANCELED"
                                    ? 'Татгазсан'
                                    : incomeData.receiptStatus == "DONE"
                                    ? 'Амжилттай'
                                    : "-"}',
                                style: TextStyle(
                                  color: incomeData.receiptStatus == "CANCELED"
                                      ? redColor
                                      : incomeData.receiptStatus == "NEW" ||
                                            incomeData.receiptStatus ==
                                                "PENDING" ||
                                            incomeData.receiptStatus ==
                                                "FINANCE_APPROVED"
                                      ? orange
                                      : green,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(100),
                            //     color: green.withOpacity(0.1),
                            //   ),
                            //   padding: EdgeInsets.symmetric(
                            //     horizontal: 9,
                            //     vertical: 4,
                            //   ),
                            //   child: Text(
                            //     '${widget.data.transportStatus}',
                            //     style: TextStyle(
                            //       color: green,
                            //       fontSize: 10,
                            //       fontWeight: FontWeight.w500,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: white50),
                            top: BorderSide(color: white50),
                          ),
                          color: white,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/svg/truck_avatar.svg'),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${incomeData.vehiclePlateNo?.toUpperCase() ?? '-'}',
                                  style: TextStyle(
                                    color: black950,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  '${incomeData.driverName ?? '-'}',
                                  style: TextStyle(
                                    color: black950,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Тоо ширхэг:',
                              style: TextStyle(
                                color: black800,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${incomeData.orderProductCount ?? '-'} Тонн',
                              style: TextStyle(
                                color: orange,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: white,
                          border: Border.all(color: white100),
                        ),
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            // Row(
                            //   children: [
                            //     GestureDetector(
                            //       onTap: () {
                            //         setState(() {
                            //           isIssueNumber = !isIssueNumber;
                            //         });
                            //       },
                            //       child: isIssueNumber == true
                            //           ? SvgPicture.asset(
                            //               'assets/svg/check_complain.svg',
                            //             )
                            //           : Container(
                            //               width: 20,
                            //               height: 20,
                            //               decoration: BoxDecoration(
                            //                 borderRadius: BorderRadius.circular(6),
                            //                 border: Border.all(color: gray300),
                            //               ),
                            //               // child: Center(child: Icon(Icons.check, size: 16)),
                            //             ),
                            //     ),

                            //     SizedBox(width: 6),
                            //     Text(
                            //       'Хянагч хянасан',
                            //       style: TextStyle(
                            //         color: black950,
                            //         fontSize: 14,
                            //         fontWeight: FontWeight.w600,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: 30),
                            // widget.data.inOutType == "IN" ||
                            //         widget.data.inOutType == null
                            //     ?
                            //     : widget.data.inOutType == "OUT"
                            //     ? Column(
                            //         children: [
                            //           Row(
                            //             children: [
                            //               GestureDetector(
                            //                 onTap: () {
                            //                   // setState(() {
                            //                   //   isIssueNumber = !isIssueNumber;
                            //                   // });
                            //                 },
                            //                 child: isIssueNumber == true
                            //                     ? SvgPicture.asset(
                            //                         'assets/svg/check_complain.svg',
                            //                       )
                            //                     : Container(
                            //                         width: 20,
                            //                         height: 20,
                            //                         decoration: BoxDecoration(
                            //                           borderRadius:
                            //                               BorderRadius.circular(6),
                            //                           border: Border.all(
                            //                             color: gray300,
                            //                           ),
                            //                         ),
                            //                         // child: Center(child: Icon(Icons.check, size: 16)),
                            //                       ),
                            //               ),

                            //               SizedBox(width: 6),
                            //               Text(
                            //                 'Хяналтын тоологч хянасан',
                            //                 style: TextStyle(
                            //                   color: black950,
                            //                   fontSize: 14,
                            //                   fontWeight: FontWeight.w600,
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //           SizedBox(height: 6),
                            //           Text(
                            //             'Хяналтын тоологч хянасан үед агуулахаас түлш зарлагадах боломжтой.',
                            //             style: TextStyle(
                            //               color: black950,
                            //               fontSize: 12,
                            //               fontWeight: FontWeight.w400,
                            //             ),
                            //           ),
                            //           SizedBox(height: 16),
                            //         ],
                            //       )
                            //     : SizedBox(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // GestureDetector(
                                    //   // onTap: () {
                                    //   //   setState(() {
                                    //   //     isIssueNumber = !isIssueNumber;
                                    //   //   });
                                    //   // },
                                    //   child: isIssueNumber == true
                                    //       ? SvgPicture.asset(
                                    //           'assets/svg/check_complain.svg',
                                    //         )
                                    //       : Container(
                                    //           width: 20,
                                    //           height: 20,
                                    //           decoration: BoxDecoration(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(6),
                                    //             border: Border.all(
                                    //               color: gray300,
                                    //             ),
                                    //           ),
                                    //           // child: Center(child: Icon(Icons.check, size: 16)),
                                    //         ),
                                    // ),
                                    // SizedBox(width: 6),
                                    Text(
                                      'Тоолох',
                                      style: TextStyle(
                                        color: black950,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Танд ирсэн бүтээгдэхүүний тоог оруулна уу.',
                                  style: TextStyle(
                                    color: black950,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                            incomeData.orderProducts != null
                                ? Column(
                                    children: incomeData.orderProducts!.asMap().entries.map((
                                      entry,
                                    ) {
                                      // final index = entry.key;
                                      final data = entry.value;

                                      return Container(
                                        padding: EdgeInsets.only(
                                          top: 4,
                                          left: 4,
                                          right: 16,
                                          bottom: 4,
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/default.jpg',
                                              height: 62,
                                              width: 62,
                                            ),
                                            SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${data.product?.name ?? '-'}',
                                                    style: TextStyle(
                                                      color: black950,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    'Байх ёстой: ${data.totalCount} Тонн',
                                                    style: TextStyle(
                                                      color: black950,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 12),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: white50,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: white100,
                                                  ),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 29,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  // mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      '${data.totalCount}',
                                                      style: TextStyle(
                                                        color: black950,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    // Expanded(
                                                    //   child: TextField(
                                                    //     controller:
                                                    //         _controllers[index],
                                                    //     keyboardType:
                                                    //         TextInputType
                                                    //             .number,
                                                    //     textAlign:
                                                    //         TextAlign.center,
                                                    //     style: TextStyle(
                                                    //       color: black950,
                                                    //       fontSize: 16,
                                                    //       fontWeight:
                                                    //           FontWeight.w600,
                                                    //     ),
                                                    //     readOnly: true,
                                                    //     decoration:
                                                    //         const InputDecoration(
                                                    //           border:
                                                    //               InputBorder
                                                    //                   .none,
                                                    //           isDense: true,
                                                    //           contentPadding:
                                                    //               EdgeInsets
                                                    //                   .zero,
                                                    //         ),
                                                    //     onChanged: (value) {
                                                    //       final parsed =
                                                    //           int.tryParse(
                                                    //             value,
                                                    //           ) ??
                                                    //           0;
                                                    //       setState(() {
                                                    //         _editedQuantities[index] =
                                                    //             parsed; // зөвхөн түр хадгалах
                                                    //       });
                                                    //     },
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 150,
                      ),
                    ],
                  ),
                ),
                !isKeyboardVisible && incomeData.receiptStatus == "PENDING"
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
                                  : MediaQuery.of(context).padding.bottom + 16,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text(
                                    //   '${Utils().formatCurrencyDouble(data.totalAmount?.toDouble() ?? 0)}₮',
                                    //   style: TextStyle(
                                    //     color: orange,
                                    //     fontSize: 24,
                                    //     fontWeight: FontWeight.w700,
                                    //   ),
                                    // ),
                                  ],
                                ),

                                // SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: isLoading == true ? (){}:() {
                                          // onSubmit();
                                          // Navigator.of(context).pushNamed(
                                          //   IncomeConfirmPage.routeName,
                                          //   arguments:
                                          //       IncomeConfirmPageArguments(
                                          //         data: data,
                                          //       ),
                                          // );
                                          onSubmit();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
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
                                                                    color:
                                                                        white,
                                                                    strokeWidth:
                                                                        2.5,
                                                                  ),
                                                            )
                                                          : Center(
                                                              child:
                                                                  CupertinoActivityIndicator(
                                                                    color:
                                                                        white,
                                                                  ),
                                                            ),
                                                    )
                                                  : Text(
                                                      'Баталгаажуулах',
                                                      style: TextStyle(
                                                        color: white,
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
    );
  }
}
