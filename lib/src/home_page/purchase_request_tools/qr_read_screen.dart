// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ttt_merchant_flutter/api/product_api.dart';
import 'package:ttt_merchant_flutter/components/dialog/error_dialog.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/check_card.dart';
import 'package:ttt_merchant_flutter/src/home_page/purchase_request_tools/purchase_request_page.dart';
// import 'package:ttt_merchant_flutter/src/home_page/purchase_request_tools/purchase_request_page.dart';

class QrReadScreen extends StatefulWidget {
  static const routeName = "QrReadScreen";
  const QrReadScreen({super.key});

  @override
  State<QrReadScreen> createState() => _QrReadScreenState();
}

class _QrReadScreenState extends State<QrReadScreen> {
  // Barcode? result;
  // QRViewController? controller;
  final MobileScannerController controller = MobileScannerController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isNavigated = false;
  bool isFlashOn = false;
  bool isErrorShown = false;

  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final status = await Permission.camera.status;
    if (status.isDenied || status.isRestricted) {
      final newStatus = await Permission.camera.request();
      if (!newStatus.isGranted) {
        setState(() {
          _hasPermission = true;
        });
      }
    } else if (status.isPermanentlyDenied) {
      setState(() {
        _hasPermission = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasPermission) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Камерын зөвшөөрөл шаардлагатай."),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  openAppSettings();
                },
                child: const Text("Тохиргоо руу очих"),
              ),
            ],
          ),
        ),
      );
    } else {
      return PopScope(
        canPop: true,
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox.expand(
                child: MobileScanner(
                  controller: controller,
                  onDetect: (capture) async {
                    final List<Barcode> barcodes = capture.barcodes;
                    for (final barcode in barcodes) {
                      if (barcode.rawValue == null) continue;
                      if (!isNavigated && !isErrorShown) {
                        try {
                          final data = jsonDecode(barcode.rawValue!);
                          final String cardNo = data['card']['cardNo'];
                          CheckCard card = CheckCard()..cardNumber = cardNo;

                          card = await ProductApi().getCardBalance(card);

                          isNavigated = true;
                          await controller.stop();

                          Navigator.of(context)
                              .pushReplacementNamed(
                                PurchaseRequestPage.routeName,
                                arguments: PurchaseRequestPageArguments(
                                  data: card,
                                  payType: "QR",
                                ),
                              )
                              .then((_) async {
                                isNavigated = false;
                                await controller.start();
                              });
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
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
