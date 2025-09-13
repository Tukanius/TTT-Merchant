// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ttt_merchant_flutter/api/auth_api.dart';
import 'package:ttt_merchant_flutter/api/balance_api.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/qpay_payment.dart';
import 'package:ttt_merchant_flutter/models/urls.dart';
import 'package:ttt_merchant_flutter/models/user.dart';
import 'package:ttt_merchant_flutter/src/main_page.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ttt_merchant_flutter/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class QpayPaymentPageArguments {
  final String id;

  QpayPaymentPageArguments({required this.id});
}

class QpayPaymentPage extends StatefulWidget {
  final String id;

  static const routeName = "QpayPaymentPage";
  const QpayPaymentPage({super.key, required this.id});

  @override
  State<QpayPaymentPage> createState() => _QpayPaymentPageState();
}

class _QpayPaymentPageState extends State<QpayPaymentPage>
    with AfterLayoutMixin {
  bool isLoading = false;
  bool isLoadingPage = true;
  QpayPayment qpayPayment = QpayPayment();
  User user = User();
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      user = await AuthApi().me(false);
      qpayPayment = await BalanceApi().getPayment(widget.id);
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      print(e);
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
      await BalanceApi().checkPayment(qpayPayment.id!);
      setState(() {
        isLoading = true;
      });
      saleSuccess(context);
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
            'Төлбөр төлөх',
            style: TextStyle(
              color: black950,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                MainPage.routeName,
                arguments: MainPageArguments(
                  changeIndex: 0,
                  userType: user.userType!,
                ),
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
        body: isLoadingPage == true
            ? CustomLoader()
            : Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Container(
                          width: 300,
                          height: 300,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
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
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 16.0,
                                mainAxisSpacing: 20.0,
                                childAspectRatio: 1,
                              ),
                          padding: const EdgeInsets.all(16.0),
                          itemCount: qpayPayment.qpay!.urls!.length,
                          itemBuilder: (context, index) {
                            final data = qpayPayment.qpay!.urls![index];
                            return GestureDetector(
                              onTap: () {
                                _launchInBrowser(data.link!, data);
                              },
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      height: 50,
                                      width: 50,
                                      '${data.logo}',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    '${data.description}',
                                    style: TextStyle(
                                      color: black950,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).padding.bottom + 200,
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
                            Text(
                              'Нийт дүн:',
                              style: TextStyle(
                                color: black950,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${Utils().formatCurrencyDouble(qpayPayment.amount?.toDouble() ?? 0)}₮',
                              style: TextStyle(
                                color: orange,
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: isLoading == true
                                        ? () {}
                                        : () async {
                                            await onSubmit();
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
                                                  'Төлбөр шалгах',
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
      ),
    );
  }
}

Future<void> _launchInBrowser(String url, Urls link) async {
  try {
    if (!await launch("${url}")) throw 'Could not launch $url';
  } catch (e) {
    String storeLink = "";
    if (Platform.isIOS) {
      storeLink =
          "https://apps.apple.com/mn/app/${getDeepLink("${link.name}")}/id${getCode('${link.name}')}";
      print('=========storelink========');
      print(storeLink.toString());
      print(link.name.toString());
      print('=========storelink========');
    } else {
      storeLink =
          "https://play.google.com/store/search?q=${"${link.name}"}&c=apps";
    }
    await launch(storeLink);
  }
}

String getDeepLink(String name) {
  switch (name) {
    case "qPay wallet":
      return "qpay-wallet";
    case "Khan bank":
      return "khan-bank";
    case "State bank 3.0":
      return "state-bank";
    case "Xac bank":
      return "xacbank";
    case "Trade and Development bank":
      return "tdb-online";
    case "Most money":
      return "mostmoney";
    case "National investment bank":
      return "nibank";
    case "Chinggis khaan bank":
      return "smartbank-ckbank";
    case "Capitron bank":
      return "capitron-digital-bank";
    case "Bogd bank":
      return "bogd-mobile";
    case "Trans bank":
      return "transbаnk";
    case "M bank":
      return "%D0%BC-bank";
    case "Ard App":
      return "ard";
    case "Arig bank":
      return "arig-online";
    case "Social Pay":
      return "socialpay";
    case "Pocket":
      return "pocket";
    case "Toki App":
      return "toki";
    case "Monpay":
      return "monpay";
    default:
      return "";
  }
}

String? getCode(String name) {
  switch (name) {
    case "qPay wallet":
      return "1501873159";
    case "Khan bank":
      return "1555908766";
    case "State bank 3.0":
      return "6469474361";
    case "Xac bank":
      return "1534265552";
    case "Trade and Development bank":
      return "1458831706";
    case "Most money":
      return "487144325";
    case "National investment bank":
      return "882075781";
    case "Chinggis khaan bank":
      return "1180620714";
    case "Capitron bank":
      return "1612591322";
    case "Bogd bank":
      return "1475442374";
    case "Trans bank":
      return "1604334470";
    case "M bank":
      return "1455928972";
    case "Ard App":
      return "1369846744";
    case "Arig bank":
      return "6444022675";
    case "Social Pay":
      return "1152919460";
    case "Toki App":
      return "1504679492";
    case "Monpay":
      return "978594162";
    default:
      return "";
  }
}
