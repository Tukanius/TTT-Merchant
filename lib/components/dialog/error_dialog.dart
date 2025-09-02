// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';

class ErrorDialog {
  final BuildContext? context;
  final Duration duration = const Duration(seconds: 30);

  ErrorDialog({this.context});

  void show(String message, {VoidCallback? onPress}) {
    // final local = Provider.of<LocalizationProvider>(context!, listen: false);

    final currentContext = context;
    showDialog(
      context: currentContext!,
      barrierDismissible: true,
      builder: (context) {
        // Future.delayed(duration, () {
        //   dialogService!.dialogComplete();
        //   if (Navigator.of(context, rootNavigator: true).canPop()) {
        //   }
        // });
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: gray200),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SvgPicture.asset('assets/svg/error.svg'),
                SizedBox(height: 12),
                // SvgPicture.asset('assets/svg/error_dialog.svg'),
                Text(
                  'Амжилтгүй',
                  style: TextStyle(
                    color: redColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  style: const TextStyle(
                    color: black400,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                  ),

                  textAlign: TextAlign.center,
                ),
                // GestureDetector(
                //   onTap: () {
                //         Navigator.of(context).pop();

                //   },
                //   child: Text(
                //     local.translate('close'),
                //     style: TextStyle(
                //       color: primary,
                //       fontWeight: FontWeight.w600,
                //       fontSize: 14,
                //     ),
                //   ),
                // ),
                ButtonBar(
                  buttonMinWidth: 100,
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                      ),
                      child: Text(
                        'Хаах',
                        style: TextStyle(
                          color: black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
