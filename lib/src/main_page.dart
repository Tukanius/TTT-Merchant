// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/src/home_page/home_page.dart';
import 'package:ttt_merchant_flutter/src/home_page/add_sales/check_card_modal.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/income_list_page.dart';
import 'package:ttt_merchant_flutter/src/orderlist_page/orderlist_page.dart';
import 'package:ttt_merchant_flutter/src/profile_page/profile_page.dart';
import 'package:ttt_merchant_flutter/src/home_page/add_sales/qr_read_screen.dart';

class MainPageArguments {
  final int? changeIndex;
  MainPageArguments({this.changeIndex});
}

class MainPage extends StatefulWidget {
  final int? changeIndex;

  static const routeName = "MainPage";
  const MainPage({super.key, this.changeIndex});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _selectedIndex = widget.changeIndex ?? 0;

  List<Widget> get widgetOptions => <Widget>[
    HomePage(),
    OrderlistPage(),
    IncomeListPage(),
    ProfilePage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(
      context,
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: white,
        statusBarBrightness: Brightness.light,
        // systemNavigationBarDividerColor:
      ),
    );
    final mediaQuery = MediaQuery.of(context);
    return PopScope(
      canPop: true,
      child: Scaffold(
        floatingActionButton: _selectedIndex == 0
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        QrReadScreen.routeName,
                        arguments: QrReadScreenArguments(
                          onNavigateMain: () => onItemTapped(0),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: orange,
                      ),
                      child: SvgPicture.asset('assets/svg/qr_code.svg'),
                    ),
                  ),
                  SizedBox(height: 12),
                  GestureDetector(
                    onTap: () async {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: transparent,
                        builder: (context) {
                          return CheckCardModal();
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: orange,
                      ),
                      padding: EdgeInsets.all(16),
                      child: SvgPicture.asset(
                        'assets/svg/edit.svg',
                        height: 28,
                        width: 28,
                        color: white,
                      ),
                    ),
                  ),
                ],
              )
            : null,
        extendBodyBehindAppBar: true,
        body: Center(child: widgetOptions.elementAt(_selectedIndex)),
        backgroundColor: white,
        extendBody: true,
        bottomNavigationBar: !isKeyboardVisible
            ? Container(
                decoration: BoxDecoration(color: white),
                padding: EdgeInsets.only(
                  top: 16,
                  bottom: Platform.isIOS
                      ? mediaQuery.padding.bottom
                      : mediaQuery.padding.bottom + 16,
                  right: 12,
                  left: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNavItem(
                      selectedIconPath: 'assets/svg/home_selected.svg',
                      unselectedIconPath: 'assets/svg/home_unselected.svg',
                      index: 0,
                      selectedIndex: _selectedIndex,
                      onTap: onItemTapped,
                    ),
                    _buildNavItem(
                      selectedIconPath: 'assets/svg/shop_selected.svg',
                      unselectedIconPath: 'assets/svg/shop_unselected.svg',
                      index: 1,
                      selectedIndex: _selectedIndex,
                      onTap: onItemTapped,
                    ),
                    _buildNavItem(
                      selectedIconPath: 'assets/svg/truck_selected.svg',
                      unselectedIconPath: 'assets/svg/truck_unselected.svg',
                      index: 2,
                      selectedIndex: _selectedIndex,
                      onTap: onItemTapped,
                    ),
                    _buildNavItem(
                      selectedIconPath: 'assets/svg/menu_selected.svg',
                      unselectedIconPath: 'assets/svg/menu_unselected.svg',
                      index: 3,
                      selectedIndex: _selectedIndex,
                      onTap: onItemTapped,
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}

Widget _buildNavItem({
  required String selectedIconPath,
  required String unselectedIconPath,
  required int index,
  required int selectedIndex,
  required Function(int) onTap,
}) {
  return Expanded(
    child: InkWell(
      onTap: () => onTap(index),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6),
        child: SvgPicture.asset(
          selectedIndex == index ? selectedIconPath : unselectedIconPath,
        ),
      ),
    ),
  );
}
