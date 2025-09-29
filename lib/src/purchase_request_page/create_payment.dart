// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ttt_merchant_flutter/api/auth_api.dart';
import 'package:ttt_merchant_flutter/api/balance_api.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/dialog/error_dialog.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/pay_method.dart';
import 'package:ttt_merchant_flutter/models/purchase_models/product_purchase_model.dart';
import 'package:ttt_merchant_flutter/models/qpay_payment.dart';
import 'package:ttt_merchant_flutter/models/user.dart';
import 'package:ttt_merchant_flutter/src/main_page.dart';
import 'package:ttt_merchant_flutter/utils/utils.dart';

class CreatePaymentArguments {
  final String id;
  final List<ProductPurchaseModel> data;
  final int totalAmount;
  CreatePaymentArguments({
    required this.totalAmount,
    required this.id,
    required this.data,
  });
}

class CreatePayment extends StatefulWidget {
  static const routeName = "CreatePayment";
  final String id;
  final List<ProductPurchaseModel> data;
  final int totalAmount;

  const CreatePayment({
    super.key,
    required this.id,
    required this.data,
    required this.totalAmount,
  });

  @override
  State<CreatePayment> createState() => _CreatePaymentState();
}

class _CreatePaymentState extends State<CreatePayment> with AfterLayoutMixin {
  bool isLoading = false;
  QpayPayment qpayPayment = QpayPayment();
  int? selectIndex;
  bool showQpay = false;
  User user = User();
  bool isLoadingPage = true;
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      user = await AuthApi().me(false);
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  @override
  void initState() {
    widget.data.map((data) {
      print(
        "✅ Product INFOOOO: ${data.price}, ${data.quantity}, ${data.price}",
      );
      print('=====totalAmount=====');
    }).toList();
    print(widget.data);
    super.initState();
  }

  onSubmit() async {
    if (selectIndex != null) {
      try {
        setState(() {
          isLoading = true;
        });
        if (selectIndex == 0) {
          PayMethod data = PayMethod();
          data.paymentMethod = 'CASH';
          qpayPayment = await BalanceApi().checkPaymentMethod(widget.id, data);
          setState(() {
            isLoading = false;
          });
          saleSuccess(context);
        }
        if (selectIndex == 1) {
          PayMethod data = PayMethod();
          data.paymentMethod = 'QPAY';
          qpayPayment = await BalanceApi().checkPaymentMethod(widget.id, data);
          setState(() {
            showQpay = true;
            isLoading = false;
          });
          // saleSuccess(context);
        }
        // if (selectIndex == 1) {
        //   await ProductApi().checkPayment(qpayPayment.id!);
        // }
      } catch (e) {
        print(e);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  onSubmitQpay() async {
    try {
      setState(() {
        isLoading = true;
      });
      QpayPayment data = QpayPayment();
      data = await BalanceApi().checkPayment(qpayPayment.id!);
      if (data.status != "PAID") {
        ErrorDialog(context: context).show('Төлбөр хүлээгдэж байна');
        setState(() {
          isLoading = false;
        });
      }
      if (data.status == "PAID") {
        setState(() {
          isLoading = false;
        });
        saleSuccess(context);
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  saleSuccess(BuildContext context) {
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
                  'Төлбөр амжилттай төлөгдлөө.',
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: false,
        elevation: 1,
        automaticallyImplyLeading: false,
        titleSpacing: 12,
        title: Text(
          'Төлбөр төлөх',
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
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Түлш',
                          style: TextStyle(
                            color: black950,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 12),
                        Column(
                          children: widget.data
                              .map(
                                (data) => Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(12),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color: white,
                                        ),
                                        padding: const EdgeInsets.only(
                                          left: 4,
                                          right: 16,
                                          top: 4,
                                          bottom: 4,
                                        ),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              child:
                                                  data.mainImage != null &&
                                                      data.mainImage != ''
                                                  ? Image.network(
                                                      '${data.mainImage!.url}',
                                                      height: 62,
                                                      width: 62,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.asset(
                                                      'assets/images/default.jpg',
                                                      height: 62,
                                                      width: 62,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data.name!,
                                                    style: TextStyle(
                                                      color: black950,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Тоо ширхэг: ',
                                                        style: TextStyle(
                                                          color: black600,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${data.quantity} ш',
                                                        style: TextStyle(
                                                          color: black950,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Үнэ: ',
                                                        style: TextStyle(
                                                          color: black600,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${Utils().formatCurrencyDouble(data.price?.toDouble() ?? 0)} ₮',
                                                        style: TextStyle(
                                                          color: black950,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Төлбөрийн хэрэгсэл',
                          style: TextStyle(
                            color: black950,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 12),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectIndex = 0;
                              showQpay = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: white,
                            ),
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: selectIndex == 0 ? orange : black100,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Бэлнээр',
                                  style: TextStyle(
                                    color: black950,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectIndex = 1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: white,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border: showQpay == true
                                        ? Border(
                                            bottom: BorderSide(color: white50),
                                          )
                                        : null,
                                    // color: blue200,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 16,
                                        width: 16,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                          color: selectIndex == 1
                                              ? orange
                                              : black100,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'QPAY',
                                        style: TextStyle(
                                          color: black950,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                showQpay == true
                                    ? Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            border: Border.all(color: white100),
                                            color: white,
                                          ),
                                          child: Center(
                                            child: QrImageView(
                                              data: qpayPayment.qpay!.qr_text!,
                                              version: QrVersions.auto,
                                              backgroundColor: Colors.white,
                                              foregroundColor: Colors.black,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).padding.bottom + 150,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Нийт төлөх төлбөр:',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '${Utils().formatCurrencyDouble(qpayPayment.amount == null ? widget.totalAmount.toDouble() : qpayPayment.amount!.toDouble())}₮',
                                style: TextStyle(
                                  color: orange,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: isLoading == true
                                      ? () {}
                                      : selectIndex == null
                                      ? () {}
                                      : showQpay == true && selectIndex == 1
                                      ? () async {
                                          await onSubmitQpay();
                                        }
                                      : () async {
                                          await onSubmit();
                                        },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: selectIndex == null
                                          ? orange.withOpacity(0.5)
                                          : orange,
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
                                                              strokeWidth: 2.5,
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
                                                selectIndex == 0
                                                    ? 'Дуусгах'
                                                    : showQpay == true &&
                                                          selectIndex == 1
                                                    ? 'Төлбөр шалгах'
                                                    : 'Төлбөр төлөх',
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
