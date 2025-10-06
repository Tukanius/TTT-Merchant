// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/src/home_page/home_page_distributor.dart';
import 'package:ttt_merchant_flutter/src/home_page/home_page_storeman.dart';
import 'package:ttt_merchant_flutter/src/purchase_request_page/purchase_request_tools/check_card_modal.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/distributor_income/income_list_distributor.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/storeman_income/income_list_storeman.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/inspector_list/income_inspector_list.dart';
import 'package:ttt_merchant_flutter/src/not_found_user.dart';
import 'package:ttt_merchant_flutter/src/profile_page/profile_page_distributor.dart';
import 'package:ttt_merchant_flutter/src/profile_page/profile_page_inspector.dart';
import 'package:ttt_merchant_flutter/src/sales_list_page/sales_list_page.dart';
import 'package:ttt_merchant_flutter/src/profile_page/profile_page_storeman.dart';
import 'package:ttt_merchant_flutter/src/purchase_request_page/purchase_request_tools/qr_read_screen.dart';
import 'package:ttt_merchant_flutter/components/updater/updater.dart';
import 'package:ttt_merchant_flutter/src/wallet_page/wallet_page.dart';

class MainPageArguments {
  final int? changeIndex;
  final String userType;
  MainPageArguments({required this.userType, this.changeIndex});
}

class MainPage extends StatefulWidget {
  final int? changeIndex;
  final String userType;

  static const routeName = "MainPage";
  const MainPage({super.key, this.changeIndex, required this.userType});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _selectedIndex = widget.changeIndex ?? 0;

  List<Widget> get widgetOptions {
    if (widget.userType == "STORE_MAN") {
      return [
        HomePageStoreman(onChangePage: (index) => onItemTapped(index)),
        IncomeListStoreman(),
        ProfilePageStoreman(onChangePage: (index) => onItemTapped(index)),
      ];
    } else if (widget.userType == "DISTRIBUTOR") {
      return [
        HomePageDistributor(onChangePage: (index) => onItemTapped(index)),
        SalesListPage(),
        WalletPage(),
        IncomeListPage(),
        ProfilePageDistributor(onChangePage: (index) => onItemTapped(index)),
      ];
    } else if (widget.userType == "FACTORY_INSPECTOR") {
      return [
        IncomeInspectorList(),
        ProfilePageInspector(onChangePage: (index) => onItemTapped(index)),
      ];
    } else {
      return [NotFoundUser()];
    }
  }

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
    return UpdaterComponent(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          floatingActionButton:
              widget.userType == "STORE_MAN" ||
                  widget.userType == "FACTORY_INSPECTOR"
              ? null
              : _selectedIndex == 0
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(QrReadScreen.routeName);
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
                  child: widget.userType == "STORE_MAN"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildNavItem(
                              selectedIconPath: 'assets/svg/home_selected.svg',
                              unselectedIconPath:
                                  'assets/svg/home_unselected.svg',
                              index: 0,
                              selectedIndex: _selectedIndex,
                              onTap: onItemTapped,
                            ),
                            _buildNavItem(
                              selectedIconPath: 'assets/svg/truck_selected.svg',
                              unselectedIconPath:
                                  'assets/svg/truck_unselected.svg',
                              index: 1,
                              selectedIndex: _selectedIndex,
                              onTap: onItemTapped,
                            ),
                            _buildNavItem(
                              selectedIconPath:
                                  'assets/svg/profile_selected.svg',
                              unselectedIconPath:
                                  'assets/svg/profile_unselected.svg',
                              index: 2,
                              selectedIndex: _selectedIndex,
                              onTap: onItemTapped,
                            ),
                          ],
                        )
                      : widget.userType == "DISTRIBUTOR"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildNavItem(
                              selectedIconPath: 'assets/svg/home_selected.svg',
                              unselectedIconPath:
                                  'assets/svg/home_unselected.svg',
                              index: 0,
                              selectedIndex: _selectedIndex,
                              onTap: onItemTapped,
                            ),
                            _buildNavItem(
                              selectedIconPath: 'assets/svg/shop_selected.svg',
                              unselectedIconPath:
                                  'assets/svg/shop_unselected.svg',
                              index: 1,
                              selectedIndex: _selectedIndex,
                              onTap: onItemTapped,
                            ),
                            _buildNavItem(
                              selectedIconPath:
                                  'assets/svg/wallet_selected.svg',
                              unselectedIconPath:
                                  'assets/svg/wallet_unselected.svg',
                              index: 2,
                              selectedIndex: _selectedIndex,
                              onTap: onItemTapped,
                            ),
                            _buildNavItem(
                              selectedIconPath: 'assets/svg/truck_selected.svg',
                              unselectedIconPath:
                                  'assets/svg/truck_unselected.svg',
                              index: 3,
                              selectedIndex: _selectedIndex,
                              onTap: onItemTapped,
                            ),
                            _buildNavItem(
                              selectedIconPath:
                                  'assets/svg/profile_selected.svg',
                              unselectedIconPath:
                                  'assets/svg/profile_unselected.svg',
                              index: 4,
                              selectedIndex: _selectedIndex,
                              onTap: onItemTapped,
                            ),
                          ],
                        )
                      : widget.userType == "FACTORY_INSPECTOR"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildNavItem(
                              selectedIconPath: 'assets/svg/truck_selected.svg',
                              unselectedIconPath:
                                  'assets/svg/truck_unselected.svg',
                              index: 0,
                              selectedIndex: _selectedIndex,
                              onTap: onItemTapped,
                            ),
                            _buildNavItem(
                              selectedIconPath:
                                  'assets/svg/profile_selected.svg',
                              unselectedIconPath:
                                  'assets/svg/profile_unselected.svg',
                              index: 1,
                              selectedIndex: _selectedIndex,
                              onTap: onItemTapped,
                            ),
                          ],
                        )
                      : SizedBox(),
                )
              : null,
        ),
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
