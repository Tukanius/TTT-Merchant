// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ttt_merchant_flutter/api/product_api.dart';
import 'package:ttt_merchant_flutter/components/cards/income_page_cards/income_history_card.dart';
import 'package:ttt_merchant_flutter/components/cards/income_page_cards/income_saleman_history_card.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/refresher/refresher.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/result.dart';

class IncomeListPage extends StatefulWidget {
  final String userType;
  static const routeName = "IncomeListPage";
  const IncomeListPage({super.key, required this.userType});

  @override
  State<IncomeListPage> createState() => _IncomeListPageState();
}

class _IncomeListPageState extends State<IncomeListPage> with AfterLayoutMixin {
  // int selectedIndex = 0;
  int? selectedIndexTile;
  final List<String> tabs = [
    'Бүгд',
    'Хүлээгдэж байгаа',
    'Баталгаажсан',
    'Тээвэрлэж буй',
  ];

  // final Map<String, String> tabFilters = {
  //   'Нийт': 'ALL',
  //   'Өнөөдөр': 'TODAY',
  //   '7 Хоног': 'WEEK',
  //   '1 Сар': 'MONTH',
  //   '1 Жил': 'YEAR',
  // };
  bool isLoadingPage = true;
  Result incomeHistory = Result();
  Result incomeSaleMan = Result();

  bool isLoadingHistory = true;
  int page = 1;
  int limit = 10;
  int filterIndex = 0;
  bool isLoadingHistoryIncome = true;

  listOfHistory(page, limit) async {
    incomeHistory = await ProductApi().getIncomeHistory(
      ResultArguments(
        offset: Offset(page: page, limit: limit),
        filter: Filter(date: 'ALL'),
      ),
    );
    setState(() {
      isLoadingHistory = false;
    });
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      widget.userType == "STORE_MAN"
          ? await listOfInOut(page, limit, index: 0)
          : await listOfHistory(page, limit);
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

  listOfInOut(page, limit, {int? index}) async {
    // final String selectedTab = tabs[selectedIndex];
    // final String dateType = tabFilters[selectedTab] ?? 'ALL';
    incomeSaleMan = await ProductApi().getIncomeSaleMan(
      ResultArguments(
        offset: Offset(page: page, limit: limit),
        filter: Filter(status: "NEW", type: filterIndex == 0 ? "IN" : "OUT"),
      ),
    );
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
      isLoadingHistory = true;
      isLoadingPage = true;
      limit = 10;
    });
    setState(() {
      isLoadingPage = false;
    });
    await listOfInOut(page, limit, index: filterIndex);
    await listOfHistory(page, limit);
    refreshController.refreshCompleted();
  }

  onLoading() async {
    if (!mounted) return;
    setState(() {
      limit += 10;
    });
    await listOfInOut(page, limit, index: filterIndex);
    await listOfHistory(page, limit);
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: false,
        elevation: 1,
        automaticallyImplyLeading: false,
        titleSpacing: 12,
        title: Text(
          'ХҮЛЭЭН АВАХ ЗАХИАЛГА',
          style: TextStyle(
            color: black950,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: widget.userType == "STORE_MAN"
            ? PreferredSize(
                preferredSize: Size.fromHeight(25),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              filterIndex = 0;
                            });
                            await listOfInOut(page, limit, index: 0);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: filterIndex == 0 ? black950 : white,
                                ),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Орлого',
                                  style: TextStyle(
                                    color: filterIndex == 0
                                        ? black950
                                        : black800,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              filterIndex = 1;
                            });
                            await listOfInOut(page, limit, index: 1);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: filterIndex == 1 ? black950 : white,
                                ),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Зарлага',
                                  style: TextStyle(
                                    color: filterIndex == 1
                                        ? black950
                                        : black800,

                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null,
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(8 + 16),
        //   child: Container(
        //     alignment: Alignment.centerLeft,
        //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        //     child: SingleChildScrollView(
        //       scrollDirection: Axis.horizontal,
        //       child: Row(
        //         children: List.generate(tabs.length, (index) {
        //           final bool isSelected = selectedIndex == index;
        //           return GestureDetector(
        //             onTap: () {
        //               setState(() {
        //                 selectedIndex = index;
        //               });
        //             },
        //             child: Container(
        //               margin: EdgeInsets.only(right: 10),
        //               padding: EdgeInsets.symmetric(
        //                 vertical: 6,
        //                 horizontal: 10,
        //               ),
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(100),
        //                 color: isSelected ? orange : Colors.white,
        //                 border: Border.all(
        //                   color: isSelected ? orange : white100,
        //                 ),
        //               ),
        //               child: Text(
        //                 tabs[index],
        //                 style: TextStyle(
        //                   color: isSelected ? white : black600,
        //                   fontSize: 12,
        //                   fontWeight: FontWeight.w500,
        //                 ),
        //               ),
        //             ),
        //           );
        //         }),
        //       ),
        //     ),
        //   ),
        // ),
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
                  padding: EdgeInsetsGeometry.all(16),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: white,
                          border: Border.all(color: white100),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/svg/calendar.svg'),
                            SizedBox(width: 12),
                            Text(
                              '2025/08',
                              style: TextStyle(
                                color: black950,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Column(
                        children: [
                          widget.userType != "STORE_MAN"
                              ? const SizedBox.shrink()
                              : isLoadingHistoryIncome
                              ? CustomLoader()
                              : (incomeSaleMan.rows != null &&
                                    incomeSaleMan.rows!.isNotEmpty)
                              ? Column(
                                  children: incomeSaleMan.rows!
                                      .map(
                                        (data) => Column(
                                          children: [
                                            IncomeSalemanHistoryCard(
                                              data: data,
                                            ),
                                            SizedBox(height: 16),
                                          ],
                                        ),
                                      )
                                      .toList(),
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
                          widget.userType != "DISTRIBUTOR"
                              ? const SizedBox.shrink()
                              : isLoadingHistory
                              ? CustomLoader()
                              : incomeHistory.rows != null ||
                                    incomeHistory.rows?.isEmpty == false
                              ? Column(
                                  children: incomeHistory.rows!
                                      .map(
                                        (data) => Column(
                                          children: [
                                            IncomeHistoryCard(data: data),
                                            SizedBox(height: 16),
                                          ],
                                        ),
                                      )
                                      .toList(),
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
                        ],
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
