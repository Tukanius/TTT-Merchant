import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';

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
                  Navigator.of(context).pop();
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
