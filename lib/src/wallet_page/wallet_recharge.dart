// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ttt_merchant_flutter/api/product_api.dart';
import 'package:ttt_merchant_flutter/components/custom_keyboard/custom_keyboard.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/charge_wallet.dart';
import 'package:ttt_merchant_flutter/models/qpay_payment.dart';
import 'package:ttt_merchant_flutter/src/main_page.dart';
import 'package:ttt_merchant_flutter/src/wallet_page/wallet_qpay_charge.dart';
import 'package:ttt_merchant_flutter/utils/utils.dart';

class WalletRecharge extends StatefulWidget {
  static const routeName = "WalletRecharge";
  const WalletRecharge({super.key});

  @override
  State<WalletRecharge> createState() => _WalletRechargeState();
}

class _WalletRechargeState extends State<WalletRecharge> {
  TextEditingController controller = TextEditingController();
  bool isLoading = false;

  final List<String> tabs = ['10,000₮', '20,000₮', '30,000₮', '50,000₮'];
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  onSubmit() async {
    QpayPayment qpayPayment = QpayPayment();
    ChargeWallet data = ChargeWallet();
    print(controller.text);
    print('=======controller======');
    try {
      setState(() {
        isLoading = true;
      });
      data.amount = int.parse(controller.text);
      qpayPayment = await ProductApi().rechargeWallet(data);
      Navigator.of(context).pushNamed(
        WalletQpayCharge.routeName,
        arguments: WalletQpayChargeArguments(data: qpayPayment),
      );
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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          centerTitle: false,
          elevation: 1,
          automaticallyImplyLeading: false,
          titleSpacing: 12,
          title: Text(
            'Данс цэнэглэх',
            style: TextStyle(
              color: black950,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(
                MainPage.routeName,
                arguments: MainPageArguments(changeIndex: 0),
              );
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
        body: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Цэнэглэх дүн',
                          style: TextStyle(
                            color: black950,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 6),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${Utils().formatCurrencyDouble(controller.text != '' ? int.parse(controller.text).toDouble() : 0)}₮',
                              //  == '' ? "0" : controller.text,
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 6),
                            Container(
                              width: 200,
                              height: 3,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [white, orange, white],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Text(
                        //   'data',
                        //   style: TextStyle(
                        //     color: orange,
                        //     fontSize: 50,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: List.generate(tabs.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        String value = tabs[index].replaceAll(
                          RegExp(r'[^0-9]'),
                          '',
                        );
                        controller.text = value;
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: white,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        child: Text(
                          tabs[index],
                          style: TextStyle(
                            color: black950,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: buildCustomKeyboard(controller, 10, () {}),
            ),
            SizedBox(height: 16),

            Row(
              children: [
                SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: controller.text == '' || isLoading == true
                        ? () {}
                        : () {
                            onSubmit();
                            // Navigator.of(
                            //   context,
                            // ).pushNamed(WalletRecharge.routeName);
                          },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: controller.text == ''
                            ? orange.withOpacity(0.5)
                            : orange,
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
                                  'Данс цэнэглэх',
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
            SizedBox(
              height: Platform.isIOS
                  ? MediaQuery.of(context).padding.bottom
                  : MediaQuery.of(context).padding.bottom + 16,
            ),
          ],
        ),
      ),
    );
  }
}
