// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ttt_merchant_flutter/api/inventory_api.dart';
import 'package:ttt_merchant_flutter/components/cards/income_page_cards/income_saleman_history_card.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/controller/refresher.dart';
import 'package:ttt_merchant_flutter/components/table_calendar/table_calendar.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/components/ui/form_textfield.dart';
import 'package:ttt_merchant_flutter/models/inspector_models/result.dart';

class IncomeListStoreman extends StatefulWidget {
  static const routeName = "IncomeListStoreman";
  const IncomeListStoreman({super.key});

  @override
  State<IncomeListStoreman> createState() => _IncomeListStoremanState();
}

class _IncomeListStoremanState extends State<IncomeListStoreman>
    with AfterLayoutMixin {
  int? selectedIndexTile;

  bool isLoadingPage = true;
  Result incomeHistory = Result();
  Result incomeSaleMan = Result();

  int page = 1;
  int limit = 10;
  int filterIndex = 0;
  bool isLoadingHistoryIncome = true;
  int selectedIndexFilter = 0;
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      await listOfInOut(page, limit, index: 0);
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

  listOfInOut(
    page,
    limit, {
    int? index,
    String? queryVehicle,
    String? status,
    String? startDate,
    String? endDate,
  }) async {
    // final String selectedTab = tabs[selectedIndex];
    // final String dateType = tabFilters[selectedTab] ?? 'ALL';
    incomeSaleMan = await InventoryApi().getIncomeSaleMan(
      ResultArguments(
        offset: Offset(page: page, limit: limit),
        filter: Filter(
          // status: "NEW",
          type: filterIndex == 0 ? "IN" : "OUT",
          query: queryVehicle,
          inOutType: status,
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
      isLoadingPage = true;
      limit = 10;
    });
    setState(() {
      isLoadingPage = false;
    });
    await listOfInOut(
      page,
      limit,
      index: filterIndex,
      queryVehicle: controller.text,
      startDate: startDate != '' && startDate != null
          ? startDate.toString()
          : '',
      endDate: endDate != '' && endDate != null ? endDate.toString() : '',
    );
    // widget.data
    // await listOfInOut(page, limit, index: filterIndex);
    // await listOfHistory(page, limit);
    refreshController.refreshCompleted();
  }

  onLoading() async {
    if (!mounted) return;
    setState(() {
      limit += 10;
    });
    await listOfInOut(
      page,
      limit,
      index: filterIndex,
      queryVehicle: controller.text,
      startDate: startDate != '' && startDate != null
          ? startDate.toString()
          : '',
      endDate: endDate != '' && endDate != null ? endDate.toString() : '',
    );
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
          "${endDate!.month.toString().padLeft(2, '0')}/${endDate!.day.toString().padLeft(2, '0')}";
    }
    return "";
  }

  Timer? timer;
  TextEditingController controller = TextEditingController();

  onChange(String query) async {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        isLoadingHistoryIncome = true;
      });
      await listOfInOut(page, limit, index: filterIndex, queryVehicle: query);
      setState(() {
        isLoadingHistoryIncome = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          centerTitle: false,
          elevation: 1,
          automaticallyImplyLeading: false,
          titleSpacing: 12,
          title: Text(
            'Агуулахын хөдөлгөөн',
            style: TextStyle(
              color: black950,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Row(
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
                ],
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 16,
                          right: 16,
                        ),
                        child: FormTextField(
                          controller: controller,
                          inputType: TextInputType.text,
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
                          hintText: 'Улсын дугаар, жолооч, гэрээний дугаар...',
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
                                          await listOfInOut(
                                            page,
                                            limit,
                                            queryVehicle: controller.text,
                                            startDate:
                                                startDate != '' &&
                                                    startDate != null
                                                ? startDate.toString()
                                                : '',
                                            endDate:
                                                endDate != '' && endDate != null
                                                ? endDate.toString()
                                                : '',
                                          );
                                          Navigator.pop(context);
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
                      Padding(
                        padding: EdgeInsetsGeometry.only(
                          right: 16,
                          left: 16,
                          bottom: 16,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 16),
                            isLoadingHistoryIncome
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
                            SizedBox(
                              height:
                                  MediaQuery.of(context).padding.bottom + 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
