// ignore_for_file: deprecated_member_use

import 'dart:async';
// import 'dart:io';

import 'package:after_layout/after_layout.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:table_calendar/table_calendar.dart';
import 'package:ttt_merchant_flutter/api/product_api.dart';
import 'package:ttt_merchant_flutter/components/cards/sale_page_cards/sale_history_card.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/controller/refresher.dart';
import 'package:ttt_merchant_flutter/components/table_calendar/table_calendar.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/result.dart';
import 'package:ttt_merchant_flutter/src/sales_list_page/sales_request_page.dart';

class SalesListPage extends StatefulWidget {
  static const routeName = 'SalesListPage';
  const SalesListPage({super.key});

  @override
  State<SalesListPage> createState() => _SalesListPageState();
}

class _SalesListPageState extends State<SalesListPage> with AfterLayoutMixin {
  int selectedIndex = 0;
  int? selectedIndexTile;
  final List<String> tabs = [
    'Хүсэлт илгээсэн',
    'Төлбөр төлөх',
    'Төлбөр төлөгдсөн',
    'Хүлээн авсан',
    'Бүгд',
  ];

  bool isLoadingPage = true;
  String? selectedValue;
  Result salesHistory = Result();
  bool isLoadingHistory = true;
  int page = 1;
  int limit = 10;
  bool isLoading = false;
  listOfHistory(page, limit) async {
    salesHistory = await ProductApi().getSalesHistory(
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
      await listOfHistory(page, limit);
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoadingPage = true;
      });
    }
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
    await listOfHistory(page, limit);
    refreshController.refreshCompleted();
  }

  onLoading() async {
    if (!mounted) return;
    setState(() {
      limit += 10;
    });
    await listOfHistory(page, limit);
    refreshController.loadComplete();
  }

  DateTime? startDate;
  DateTime? endDate;

  String get formattedDate {
    if (startDate == null && endDate == null) {
      final now = DateTime.now();
      return "${now.year}/${now.month.toString().padLeft(2, '0')}";
    } else if (startDate != null && endDate == null) {
      return "${startDate!.year}/${startDate!.month.toString().padLeft(2, '0')}/${startDate!.day.toString().padLeft(2, '0')}";
    } else if (startDate != null && endDate != null) {
      return "${startDate!.year}/${startDate!.month.toString().padLeft(2, '0')}/${startDate!.day.toString().padLeft(2, '0')} - "
          "${endDate!.year}/${endDate!.month.toString().padLeft(2, '0')}/${endDate!.day.toString().padLeft(2, '0')}";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: false,
        elevation: 1,
        automaticallyImplyLeading: false,
        titleSpacing: 12,
        title: Text(
          'Татан авалт',
          style: TextStyle(
            color: black950,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(SalesRequestPage.routeName);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: white,
                    border: Border.all(color: white100),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svg/download.svg'),
                      SizedBox(width: 6),
                      Text(
                        'Таталт хийх',
                        style: TextStyle(
                          color: black950,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(16 + 16),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: List.generate(tabs.length, (index) {
                    final bool isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () async {
                        setState(() {
                          selectedIndex = index;
                          isLoadingHistory = true;
                        });

                        await listOfHistory(page, limit);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: isSelected ? orange : Colors.white,
                          border: Border.all(
                            color: isSelected ? orange : white100,
                          ),
                        ),
                        child: Text(
                          tabs[index],
                          style: TextStyle(
                            color: isSelected ? white : black600,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
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
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                            ),
                            builder: (context) {
                              return CustomTableCalendar(
                                onDateSelected: (start, end) {
                                  setState(() {
                                    startDate = start;
                                    endDate = end;
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            },
                          );
                        },
                        child: Container(
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
                                formattedDate,
                                style: TextStyle(
                                  color: black950,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 16),
                      Text(
                        'Татан авалтын түүх',
                        style: TextStyle(
                          color: black600,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 16),
                      isLoadingHistory == true
                          ? CustomLoader()
                          : salesHistory.rows != null &&
                                salesHistory.rows?.isEmpty == false
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Column(
                                children: List.generate(
                                  salesHistory.rows!.length,
                                  (index) {
                                    final isExpanded =
                                        selectedIndexTile == index;
                                    final item = salesHistory.rows![index];
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
                                      child: SaleHistoryCard(
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

                      SizedBox(height: mediaQuery.padding.bottom + 50),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
