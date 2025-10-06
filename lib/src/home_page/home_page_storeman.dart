// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ttt_merchant_flutter/api/inventory_api.dart';
import 'package:ttt_merchant_flutter/components/cards/home_page_cards/storeman_residual.dart';
import 'package:ttt_merchant_flutter/components/custom_app_bar/custom_app_bar.dart';
import 'package:ttt_merchant_flutter/components/cards/income_page_cards/income_done_history_card.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/controller/refresher.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/general/general_init.dart';
import 'package:ttt_merchant_flutter/models/general/residual.dart';
import 'package:ttt_merchant_flutter/models/inspector_models/result.dart';
import 'package:ttt_merchant_flutter/provider/general_provider.dart';

class HomePageStoreman extends StatefulWidget {
  final Function(int) onChangePage;
  static const routeName = "HomePageStoreman";
  const HomePageStoreman({super.key, required this.onChangePage});

  @override
  State<HomePageStoreman> createState() => _HomePageStoremanState();
}

class _HomePageStoremanState extends State<HomePageStoreman>
    with AfterLayoutMixin {
  int? selectedIndexTile;
  bool isLoadingPage = true;
  String? selectedValue;
  GeneralInit general = GeneralInit();
  int page = 1;
  int limit = 10;
  Residual? selectedResidual;
  Result incomeHistory = Result();
  bool isLoadingHistoryIncome = true;
  // User user = User();
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      general = await Provider.of<GeneralProvider>(
        context,
        listen: false,
      ).init();
      await listOfInOut(page, limit);
      setState(() {
        isLoadingPage = false;
      });

      print('===loader===');
      print(isLoadingHistoryIncome);
      print('===loader===');
    } catch (e) {
      print(e);
      setState(() {
        isLoadingPage = false;
      });
    }
  }

  listOfInOut(page, limit) async {
    // final String selectedTab = tabs[selectedIndex];
    // final String dateType = tabFilters[selectedTab] ?? 'ALL';
    incomeHistory = await InventoryApi().getIncomeSaleMan(
      ResultArguments(
        offset: Offset(page: page, limit: limit),
        filter: Filter(status: "DONE", type: "ALL"),
      ),
    );
    selectedResidual = general.residual?.first;
    setState(() {
      isLoadingHistoryIncome = false;
    });
  }

  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() {
      isLoadingHistoryIncome = true;
      isLoadingPage = true;
      limit = 10;
    });
    general = await Provider.of<GeneralProvider>(context, listen: false).init();
    setState(() {
      isLoadingPage = false;
    });
    await listOfInOut(page, limit);
    refreshController.refreshCompleted();
  }

  onLoading() async {
    if (!mounted) return;
    setState(() {
      limit += 10;
    });
    await listOfInOut(page, limit);
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      backgroundColor: white50,
      body: isLoadingPage == true
          ? CustomLoader()
          : Refresher(
              color: orange,
              refreshController: refreshController,
              onLoading: onLoading,
              onRefresh: onRefresh,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${general.inventory?.name ?? '-'}',
                        style: TextStyle(
                          color: black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16),
                      StoremanResidual(generalInit: general),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Агуулахын хөдөлгөөн',
                            style: TextStyle(
                              color: black800,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     widget.onChangePage(1);
                          //   },
                          //   child: Row(
                          //     children: [
                          //       Text(
                          //         'Бүгд',
                          //         style: TextStyle(
                          //           color: black800,
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.w500,
                          //         ),
                          //       ),
                          //       SizedBox(width: 6),
                          //       SvgPicture.asset('assets/svg/arrow_right.svg'),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 12),
                      isLoadingHistoryIncome
                          ? CustomLoader()
                          : (incomeHistory.rows != null &&
                                incomeHistory.rows!.isNotEmpty)
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Column(
                                children: List.generate(
                                  incomeHistory.rows!.length,
                                  (index) {
                                    final isExpanded =
                                        selectedIndexTile == index;
                                    final item = incomeHistory.rows![index];
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (selectedIndexTile == index) {
                                            selectedIndexTile = null;
                                          } else {
                                            selectedIndexTile = index;
                                          }
                                        });
                                      },
                                      child: IncomeDoneHistoryCard(
                                        isExtended: isExpanded,
                                        data: item,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                SizedBox(height: 12),
                                Center(
                                  child: const Text(
                                    'Түүх алга байна',
                                    style: TextStyle(
                                      color: black600,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                      SizedBox(height: mediaQuery.padding.bottom),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
