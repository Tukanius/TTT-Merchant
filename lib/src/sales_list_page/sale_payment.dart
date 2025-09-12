import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:ttt_merchant_flutter/api/product_api.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/general/general_balance.dart';
import 'package:ttt_merchant_flutter/provider/general_provider.dart';
import 'package:ttt_merchant_flutter/src/main_page.dart';
import 'package:ttt_merchant_flutter/src/wallet_page/wallet_recharge.dart';
import 'package:ttt_merchant_flutter/utils/utils.dart';
// import 'package:ttt_merchant_flutter/utils/utils.dart';

class SalePaymentArguments {
  final int payAmount;
  final String id;
  SalePaymentArguments({required this.id, required this.payAmount});
}

class SalePayment extends StatefulWidget {
  final int payAmount;
  final String id;

  static const routeName = "SalePayment";
  const SalePayment({super.key, required this.payAmount, required this.id});

  @override
  State<SalePayment> createState() => _SalePaymentState();
}

class _SalePaymentState extends State<SalePayment> with AfterLayoutMixin {
  bool isLoading = false;
  bool isLoadingPage = true;
  GeneralBalance generalBalance = GeneralBalance();

  @override
  afterFirstLayout(BuildContext context) async {
    try {
      generalBalance = await Provider.of<GeneralProvider>(
        context,
        listen: false,
      ).initBalance();
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = false;
      });
    }
  }

  onSubmit() async {
    try {
      setState(() {
        isLoading = true;
      });
      if (generalBalance.lastBalance! < widget.payAmount) {
        await Navigator.of(context).pushNamed(WalletRecharge.routeName);
      } else {
        await ProductApi().paySales(widget.id);
        saleSuccess(context);
      }
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
                  'Төлбөр амжилттай төлөгдлөө',
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
                      arguments: MainPageArguments(changeIndex: 1),
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
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(
                      MainPage.routeName,
                      arguments: MainPageArguments(changeIndex: 1),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: white,
                      border: Border.all(color: white100),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Листээс харах',
                          style: TextStyle(
                            color: black800,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
          'Татан авалтын төлбөр төлөх',
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Таны хэтэвчний үлдэгдэл',
                        style: TextStyle(
                          color: black950,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: white,
                          border: Border.all(color: orange),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              right: 0,
                              child: SvgPicture.asset(
                                'assets/svg/wallet_bg.svg',
                                width: 70,
                                height: 95,
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(width: 16),
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: orange,
                                  ),
                                ),
                                SizedBox(width: 12),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 12),
                                    Text(
                                      'Үлдэгдэл',
                                      style: TextStyle(
                                        color: black950,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '${Utils().formatCurrencyDouble(generalBalance.lastBalance?.toDouble() ?? 0)}₮',
                                      style: TextStyle(
                                        color: black950,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
                                'Нийт дүн:',
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                '${Utils().formatCurrencyDouble(widget.payAmount.toDouble())}₮',
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
                                  onTap: () {
                                    onSubmit();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
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
                                                generalBalance.lastBalance! <
                                                        widget.payAmount
                                                    ? 'Цэнэглээд төлөх'
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
