// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ttt_merchant_flutter/api/inventory_api.dart';
import 'package:ttt_merchant_flutter/components/cards/income_page_cards/income_history_card.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/controller/refresher.dart';
import 'package:ttt_merchant_flutter/components/table_calendar/table_calendar.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/components/ui/form_textfield.dart';
import 'package:ttt_merchant_flutter/models/result.dart';

class IncomeListPage extends StatefulWidget {
  static const routeName = "IncomeListPage";
  const IncomeListPage({super.key});

  @override
  State<IncomeListPage> createState() => _IncomeListPageState();
}

class _IncomeListPageState extends State<IncomeListPage> with AfterLayoutMixin {
  final List<String> tabs = [
    'Бүгд',
    'Хуваарилагдсан',
    'Агуулахаас гарсан',
    'Хүлээн авсан',
  ];
  final Map<String, String> tabFilters = {
    'Бүгд': "",
    'Хуваарилагдсан': "NEW",
    'Агуулахаас гарсан': "PENDING",
    'Хүлээн авсан': "DONE",
  };
  bool isLoadingPage = true;
  bool isLoadingHistory = true;
  Result incomeHistory = Result();
  ScrollController scrollController = ScrollController();
  int page = 1;
  int limit = 10;
  int selectedIndexFilter = 0;

  DateTime? startDate;
  DateTime? endDate;
  Timer? timer;
  TextEditingController controller = TextEditingController();
  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

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

  listOfHistory(
    page,
    limit, {
    String? queryVehicle,
    String? startDate,
    String? endDate,
    String? requestStatus,
  }) async {
    incomeHistory = await InventoryApi().getIncomeInList(
      ResultArguments(
        offset: Offset(page: page, limit: limit),
        filter: Filter(
          query: queryVehicle,
          requestStatus: requestStatus,
          startDate: startDate != '' && startDate != null
              ? DateFormat("yyyy-MM-dd").format(DateTime.parse(startDate))
              : '',
          endDate: endDate != '' && endDate != null
              ? DateFormat("yyyy-MM-dd").format(DateTime.parse(endDate))
              : '',
        ),
      ),
    );
    setState(() {
      isLoadingHistory = false;
    });
  }

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() {
      isLoadingHistory = true;
      limit = 10;
    });
    final selectedTab = tabs[selectedIndexFilter];
    final filter = tabFilters[selectedTab];
    await listOfHistory(
      page,
      limit,
      queryVehicle: controller.text,
      requestStatus: filter,
      startDate: startDate != '' && startDate != null
          ? startDate.toString()
          : '',
      endDate: endDate != '' && endDate != null ? endDate.toString() : '',
    );
    refreshController.refreshCompleted();
  }

  onLoading() async {
    if (!mounted) return;
    setState(() {
      limit += 10;
    });
    final selectedTab = tabs[selectedIndexFilter];
    final filter = tabFilters[selectedTab];
    await listOfHistory(
      page,
      limit,
      queryVehicle: controller.text,
      requestStatus: filter,
      startDate: startDate != '' && startDate != null
          ? startDate.toString()
          : '',
      endDate: endDate != '' && endDate != null ? endDate.toString() : '',
    );
    refreshController.loadComplete();
  }

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

  onChange(String query) async {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      final selectedTab = tabs[selectedIndexFilter];
      final filter = tabFilters[selectedTab];
      await listOfHistory(
        page,
        limit,
        requestStatus: filter,
        queryVehicle: query,
        startDate: startDate != '' && startDate != null
            ? startDate.toString()
            : '',
        endDate: endDate != '' && endDate != null ? endDate.toString() : '',
      );
    });
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
          'Түлш тээвэрлэлт',
          style: TextStyle(
            color: black950,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(25 + 0),
        //   child: Container(
        //     alignment: Alignment.centerLeft,
        //     child: Column(
        //       children: [
        //         Container(
        //           alignment: Alignment.centerLeft,
        //           padding: EdgeInsets.symmetric(vertical: 8),
        //           child: SingleChildScrollView(
        //             scrollDirection: Axis.horizontal,
        //             child: Container(
        //               padding: EdgeInsets.symmetric(horizontal: 16),
        //               child: Row(
        //                 children: List.generate(tabs.length, (index) {
        //                   final bool isSelected = selectedIndexFilter == index;
        //                   return GestureDetector(
        //                     onTap: () {
        //                       setState(() {
        //                         selectedIndexFilter = index;
        //                       });
        //                     },
        //                     child: Container(
        //                       margin: EdgeInsets.only(right: 10),
        //                       padding: EdgeInsets.symmetric(
        //                         vertical: 6,
        //                         horizontal: 10,
        //                       ),
        //                       decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.circular(100),
        //                         color: isSelected ? orange : Colors.white,
        //                         border: Border.all(
        //                           color: isSelected ? orange : white100,
        //                         ),
        //                       ),
        //                       child: Text(
        //                         tabs[index],
        //                         style: TextStyle(
        //                           color: isSelected ? white : black600,
        //                           fontSize: 12,
        //                           fontWeight: FontWeight.w500,
        //                         ),
        //                       ),
        //                     ),
        //                   );
        //                 }),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
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
                controller: scrollController,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        right: 16,
                        left: 16,
                      ),
                      child: FormTextField(
                        inputType: TextInputType.text,
                        controller: controller,
                        contentPadding: EdgeInsets.all(0),
                        dense: true,
                        colortext: black,
                        color: white,
                        name: 'vehicleNumberFilter',
                        hintTextStyle: TextStyle(
                          color: black400,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        hintText: 'Хайх',
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 12),
                            SvgPicture.asset('assets/svg/search.svg'),
                            SizedBox(width: 8),
                          ],
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 12),
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
                                      onDateSelected: (start, end) async {
                                        setState(() {
                                          startDate = start;
                                          endDate = end;
                                        });
                                        Navigator.pop(context);
                                        final selectedTab =
                                            tabs[selectedIndexFilter];
                                        final filter = tabFilters[selectedTab];
                                        await listOfHistory(
                                          page,
                                          limit,
                                          queryVehicle: controller.text,
                                          requestStatus: filter,
                                          startDate:
                                              startDate != null &&
                                                  startDate != ''
                                              ? startDate.toString()
                                              : '',
                                          endDate:
                                              endDate != null && endDate != ''
                                              ? endDate.toString()
                                              : '',
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: white50,
                                  border: Border.all(color: white100),
                                ),
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 8,
                                  top: 8,
                                  bottom: 8,
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/calendar.svg',
                                      height: 20,
                                      width: 20,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      formattedDate,
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
                            SizedBox(width: 4),
                          ],
                        ),
                        borderColor: white100,
                        borderRadius: 12,
                        onChanged: (value) {
                          onChange(value);
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(width: 16),
                            Row(
                              children: List.generate(tabs.length, (index) {
                                final bool isSelected =
                                    selectedIndexFilter == index;
                                return GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      selectedIndexFilter = index;
                                    });
                                    final selectedTab =
                                        tabs[selectedIndexFilter];
                                    final filter = tabFilters[selectedTab];
                                    scrollController.animateTo(
                                      scrollController.position.minScrollExtent,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeOut,
                                    );
                                    await listOfHistory(
                                      page,
                                      limit,
                                      requestStatus: filter,
                                      queryVehicle: controller.text,
                                      startDate:
                                          startDate != null && startDate != ''
                                          ? startDate.toString()
                                          : '',
                                      endDate: endDate != null && endDate != ''
                                          ? endDate.toString()
                                          : '',
                                    );
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
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.all(16),
                      child: Column(
                        children: [
                          isLoadingHistory
                              ? CustomLoader()
                              : incomeHistory.rows != null &&
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
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom + 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
