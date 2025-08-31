// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';

class QrReadScreenArguments {
  final Function() onNavigateMain;
  QrReadScreenArguments({required this.onNavigateMain});
}

class QrReadScreen extends StatefulWidget {
  final Function() onNavigateMain;

  static const routeName = "QrReadScreen";
  const QrReadScreen({super.key, required this.onNavigateMain});

  @override
  State<QrReadScreen> createState() => _QrReadScreenState();
}

class _QrReadScreenState extends State<QrReadScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isNavigated = false;
  bool isFlashOn = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid || Platform.isIOS) {
      if (controller != null) {
        controller!.pauseCamera();
      }
    }
    if (controller != null) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: buildQrView(context),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
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
                          SizedBox(width: 12),
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

                    // SvgPicture.asset(
                    //   'assets/svg/qrscan.svg',
                    //   height: 32,
                    // ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.of(context)
                    //         .pushNamed(EnterReceiptPage.routeName);
                    //   },
                    //   child: SvgPicture.asset(
                    //     'assets/svg/code.svg',
                    //     height: 32,
                    //   ),
                    // ),
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
                      await controller?.toggleFlash();
                      bool? flashStatus = await controller?.getFlashStatus();
                      setState(() {
                        isFlashOn = flashStatus ?? false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: white.withOpacity(0.2),
                        border: Border.all(color: white.withOpacity(0.2)),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/svg/flash.svg'),
                          SizedBox(width: 8),
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

  Widget buildQrView(BuildContext context) {
    var scanArea =
        (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: white,
        borderRadius: 10,
        borderLength: 25,
        borderWidth: 5,
        cutOutSize: scanArea,
        overlayColor: black.withOpacity(0.4),
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (!isNavigated) {
        setState(() {
          result = scanData;
        });
        if (result != null) {
          print('======RESULT======');
          print(result!.format);
          print(result!.code);
          print(result!.rawBytes);
          print('======RESULT======');
          isNavigated = true;

          // Navigator.of(context)
          //     .pushNamed(
          //       QrSuccessPage.routeName,
          //       arguments: QrSuccessPageArguments(token: result!.code),
          //     )
          //     .then((_) {
          //       isNavigated = false;
          //     });
        }
      }
    });
  }

  void _onPermissionSet(
    BuildContext context,
    QRViewController ctrl,
    bool p,
  ) async {
    print('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      final status = await Permission.camera.status;

      if (status.isPermanentlyDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Камерын зөвшөөрлийг тохиргооноос идэвхжүүлнэ үү.'),
            action: SnackBarAction(
              label: 'Тохиргоо руу очих',
              onPressed: () {
                openAppSettings();
              },
            ),
          ),
        );
      } else {
        final newPermission = await Permission.camera.request();
        if (newPermission.isGranted) {
          controller?.resumeCamera();
        } else {
          openAppSettings();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Камерын зөвшөөрөл шаардлагатай.')),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
