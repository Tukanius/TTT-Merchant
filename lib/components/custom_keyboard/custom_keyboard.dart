import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';

Widget buildCustomKeyboard(
  TextEditingController pinController,
  int keyNumber,
  Function() onTap,
) {
  return GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      childAspectRatio: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
    ),
    itemCount: 12,
    itemBuilder: (context, index) {
      if (index == 9) {
        return _buildKey(
          SvgPicture.asset('assets/svg/back_space.svg'),
          onTap: () {
            if (pinController.text.isNotEmpty) {
              pinController.text = pinController.text.substring(
                0,
                pinController.text.length - 1,
              );
            }
          },
        );
      } else if (index == 11) {
        return _buildKey(
          SvgPicture.asset('assets/svg/check.svg'),
          onTap: onTap,
        );
      }
      String number = (index == 10) ? '0' : '${index + 1}';
      return _buildKey(
        Text(
          number,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: gray900,
          ),
        ),
        onTap: () {
          if (pinController.text.length < keyNumber) {
            pinController.text += number;
          }
        },
      );
    },
  );
}

Widget _buildKey(Widget child, {required VoidCallback onTap}) {
  return Material(
    color: transparent,
    shape: const CircleBorder(),
    child: InkWell(
      onTap: onTap,
      // customBorder: const CircleBorder(),
      highlightColor: gray200,
      splashColor: transparent,
      child: Container(
        decoration: BoxDecoration(
          color: white,
          border: Border(bottom: BorderSide(color: white200)),
          borderRadius: BorderRadius.circular(100),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: child,
      ),
    ),
  );
}
