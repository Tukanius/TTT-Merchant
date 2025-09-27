// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ttt_merchant_flutter/api/auth_api.dart';
import 'package:ttt_merchant_flutter/api/balance_api.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/dialog/error_dialog.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/card_balance.dart';
import 'package:ttt_merchant_flutter/models/check_card.dart';
import 'package:ttt_merchant_flutter/models/user.dart';
import 'package:ttt_merchant_flutter/src/purchase_request_page/purchase_request_page.dart';
import 'package:ttt_merchant_flutter/src/purchase_request_page/purchase_request_tools/user_card_request_page.dart';
// import 'package:ttt_merchant_flutter/src/home_page/purchase_request_tools/purchase_request_page.dart';

class QrReadScreen extends StatefulWidget {
  static const routeName = "QrReadScreen";
  const QrReadScreen({super.key});

  @override
  State<QrReadScreen> createState() => _QrReadScreenState();
}

class _QrReadScreenState extends State<QrReadScreen> with AfterLayoutMixin {
  // Barcode? result;
  // QRViewController? controller;
  User user = User();
  final MobileScannerController controller = MobileScannerController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isNavigated = false;
  bool isFlashOn = false;
  bool isErrorShown = false;
  bool isLoadingPage = true;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      user = await AuthApi().me(false);
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

  @override
  Widget build(BuildContext context) {
    return isLoadingPage == true
        ? Scaffold(body: CustomLoader())
        : PopScope(
            canPop: true,
            child: Scaffold(
              body: Stack(
                children: [
                  SizedBox.expand(
                    child: MobileScanner(
                      errorBuilder: (_, _) {
                        return Container(
                          color: black.withOpacity(0.3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 200,
                                child: Text(
                                  'Тохиргоо хэсгээс камер зөвшөөрөл нээнэ үү !',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      controller: controller,
                      onDetect: (capture) async {
                        final List<Barcode> barcodes = capture.barcodes;
                        for (final barcode in barcodes) {
                          if (barcode.rawValue == null) continue;
                          if (!isNavigated && !isErrorShown) {
                            print('========barcode====');
                            // print(barcode.displayValue);R
                            print(barcode.rawValue);
                            print('========barcode====');
                            try {
                              // final data = jsonDecode(barcode.rawValue!);
                              // print('========testdata====');
                              // print(data);
                              // print('========testdata====');
                              try {
                                CardBalance cardData = CardBalance();
                                CheckCard card = CheckCard()
                                  ..str = barcode.rawValue
                                  ..distributorRegnum = user.registerNo;
                                cardData = await BalanceApi().getCardBalanceV2(
                                  card,
                                );
                                if (cardData.card != null) {
                                  isNavigated = true;
                                  await controller.stop();

                                  Navigator.of(context)
                                      .pushReplacementNamed(
                                        PurchaseRequestPage.routeName,
                                        arguments: PurchaseRequestPageArguments(
                                          data: cardData,
                                          payType: "QR",
                                        ),
                                      )
                                      .then((_) async {
                                        isNavigated = false;
                                        // await controller.start();
                                      });
                                } else {
                                  isNavigated = true;
                                  await controller.stop();
                                  Navigator.of(context)
                                      .pushReplacementNamed(
                                        UserCardRequestPage.routeName,
                                        arguments: UserCardRequestPageArguments(
                                          data: cardData,
                                        ),
                                      )
                                      .then((_) async {
                                        isNavigated = false;
                                        // await controller.start();
                                      });
                                }

                                print('=eee=ee=e=e==');
                                print(cardData);
                                print('=eee=ee=e=e==');
                              } catch (e) {
                                print('test');
                              }

                              // 1. virtual card HOTULA unshina 10 min delaytai screen shot hiiged res hiingut screenshot oo unshuulna
                              // 2. civilId asuudalgu bnu card bnu geed butsaana
                              // 3. ymarch cardgu tohioldold ugaariin medregch biyt cardtai hun gehdee manai deer virtual cardgu bh heregtei
                              // 4. yu yuchgui huselt yvuulsan bol huselt yvuulsan ugui bol
                              //   export enum CARD_REQUEST_STATUS {
                              //   NEW = "NEW",
                              //   CONFIRMED = "CONFIRMED",
                              //   CANCELLED = "CANCELLED",   ene uyd bolon null uyd  dahin yvuulj bolno
                              //   CONFIRMED_BY_SD = "CONFIRMED_BY_SD"
                              // }

                              // try {
                              //   CardBalance cardData = CardBalance();
                              //   CheckCivil civilData = CheckCivil()
                              //     ..civilId = barcode.rawValue
                              //     ..distributorRegnum = user.registerNo;
                              //   cardData = await BalanceApi().getCivilId(
                              //     civilData,
                              //   );
                              //   isNavigated = true;
                              //   await controller.stop();
                              //   // cardData.cardRequest == null ?
                              //   // &&
                              //   //     cardData.cardRequest?.requestStatus ==
                              //   //         "CANCELLED" ?
                              //   Navigator.of(context)
                              //       .pushReplacementNamed(
                              //         PurchaseRequestPage.routeName,
                              //         arguments: PurchaseRequestPageArguments(
                              //           data: cardData,
                              //           payType: "QR",
                              //         ),
                              //       )
                              //       .then((_) async {
                              //         isNavigated = false;
                              //         // await controller.start();
                              //       });
                              // } catch (e) {
                              //   print(e);
                              // }
                              // if (jsonDecode(barcode.rawValue!)['card'] !=
                              //         null &&
                              //     jsonDecode(
                              //           barcode.rawValue!,
                              //         )['card']['cardNo'] !=
                              //         null) {
                              //   final data = jsonDecode(barcode.rawValue!);

                              //   String cardNo = data['card']['cardNo'];
                              //   String appUserJson = data['appUser'];
                              //   CheckCard card = CheckCard()
                              //     ..cardNumber = cardNo
                              //     ..appUserId = appUserJson;
                              //   CardBalance cardData = CardBalance();
                              //   cardData = await BalanceApi().getCardBalance(
                              //     card,
                              //   );

                              //   isNavigated = true;
                              //   await controller.stop();

                              //   Navigator.of(context)
                              //       .pushReplacementNamed(
                              //         PurchaseRequestPage.routeName,
                              //         arguments: PurchaseRequestPageArguments(
                              //           data: cardData,
                              //           payType: "QR",
                              //         ),
                              //       )
                              //       .then((_) async {
                              //         isNavigated = false;
                              //         // await controller.start();
                              //       });
                              // } else {
                              //   final data = jsonDecode(barcode.rawValue!);
                              //   // cardNo байхгүй үед өөр API дуудах
                              //   // String civilId = data;
                              //   print('=====civilId====');
                              //   print(data);
                              //   print('=====civilId====');
                              // }
                            } catch (e) {
                              if (!isErrorShown) {
                                isErrorShown = true;
                                ErrorDialog(
                                  context: context,
                                ).show('QR код буруу байна.');
                                Future.delayed(const Duration(seconds: 2), () {
                                  isErrorShown = false;
                                });
                              }
                            }
                          }
                        }
                      },
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        color: transparent,
                        borderRadius: BorderRadius.circular(33),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              children: [
                                Center(
                                  child: SvgPicture.asset(
                                    'assets/svg/arrow_left_wide.svg',
                                    color: white,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'QR унших',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).padding.bottom + 150,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await controller.toggleTorch();
                            setState(() {
                              isFlashOn = controller.torchEnabled;
                            });
                            // final status = await controller.to;
                            // setState(() {
                            // isFlashOn = status == TorchState.on;
                            // });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: white.withOpacity(0.2),
                              border: Border.all(color: white.withOpacity(0.2)),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/svg/flash.svg'),
                                const SizedBox(width: 8),
                                Text(
                                  'Гэрэл асаах',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
    // if (!_hasPermission) {
    //   return Scaffold(
    //     body: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           const Text("Камерын зөвшөөрөл шаардлагатай."),
    //           const SizedBox(height: 12),
    //           ElevatedButton(
    //             onPressed: () {
    //               openAppSettings();
    //             },
    //             child: const Text("Тохиргоо руу очих"),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // } else {

    // }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
