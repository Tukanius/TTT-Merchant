import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ttt_merchant_flutter/api/inventory_api.dart';
import 'package:ttt_merchant_flutter/components/cards/income_page_cards/income_done_history_card.dart';
import 'package:ttt_merchant_flutter/components/controller/refresher.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/table_calendar/table_calendar.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/result.dart';

class IncomeStoremanHistory extends StatefulWidget {
  static const routeName = "IncomeStoremanHistory";
  const IncomeStoremanHistory({super.key});

  @override
  State<IncomeStoremanHistory> createState() => _IncomeStoremanHistoryState();
}

class _IncomeStoremanHistoryState extends State<IncomeStoremanHistory>
    with AfterLayoutMixin {
  Result incomeHistory = Result();
  bool isLoadingPage = true;
  bool isLoadingHistory = true;
  int filterIndex = 0;
  int page = 1;
  int limit = 10;
  DateTime? startDate;
  DateTime? endDate;
  String? selectedValue;
  dynamic selectedItem;
  int? selectedIndexTile;

  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );
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

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      await listOfHistory(page, limit, filterIndex);
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  listOfHistory(
    page,
    limit,
    filterIndex, {
    String? queryVehicle,
    String? startDate,
    String? endDate,
  }) async {
    filterIndex == 0
        ? incomeHistory = await InventoryApi().getIncomeInList(
            ResultArguments(
              offset: Offset(page: page, limit: limit),
              filter: Filter(
                listtype: 'ALL',
                startDate: startDate != '' && startDate != null
                    ? DateFormat("yyyy-MM-dd").format(DateTime.parse(startDate))
                    : '',
                endDate: endDate != '' && endDate != null
                    ? DateFormat("yyyy-MM-dd").format(DateTime.parse(endDate))
                    : '',
              ),
            ),
          )
        : incomeHistory = await InventoryApi().getIncomeOutList(
            ResultArguments(
              offset: Offset(page: page, limit: limit),
              filter: Filter(
                listtype: 'ALL',
                startDate: startDate != '' && startDate != null
                    ? DateFormat("yyyy-MM-dd").format(DateTime.parse(startDate))
                    : '',
                endDate: endDate != '' && endDate != null
                    ? DateFormat("yyyy-MM-dd").format(DateTime.parse(endDate))
                    : '',
              ),
            ),
          );
    if (incomeHistory.totals!.isNotEmpty) {
      selectedItem = incomeHistory.totals!.first;
    }
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
    await listOfHistory(
      page,
      limit,
      filterIndex,
      startDate: startDate != '' && startDate != null
          ? startDate.toString()
          : '',
      endDate: endDate != '' && endDate != null ? endDate.toString() : '',
    );
    // widget.data
    // await listOfHistory(page, limit, index: filterIndex);
    // await listOfHistory(page, limit);
    refreshController.refreshCompleted();
  }

  onLoading() async {
    if (!mounted) return;
    setState(() {
      limit += 10;
    });
    await listOfHistory(
      page,
      limit,
      filterIndex,
      startDate: startDate != '' && startDate != null
          ? startDate.toString()
          : '',
      endDate: endDate != '' && endDate != null ? endDate.toString() : '',
    );
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
          'Агуулахын хөдөлгөөн',
          style: TextStyle(
            color: black950,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 16),
              SvgPicture.asset('assets/svg/arrow_left_wide.svg'),
            ],
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
                          await listOfHistory(
                            page,
                            limit,
                            filterIndex,
                            startDate: startDate != '' && startDate != null
                                ? startDate.toString()
                                : '',
                            endDate: endDate != '' && endDate != null
                                ? endDate.toString()
                                : '',
                          );
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
                                  color: filterIndex == 0 ? black950 : black800,
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
                          await listOfHistory(
                            page,
                            limit,
                            filterIndex,
                            startDate: startDate != '' && startDate != null
                                ? startDate.toString()
                                : '',
                            endDate: endDate != '' && endDate != null
                                ? endDate.toString()
                                : '',
                          );
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
                                  color: filterIndex == 1 ? black950 : black800,

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     top: 16,
                    //     right: 16,
                    //     left: 16,
                    //   ),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(12),
                    //       color: white,
                    //       border: Border.all(color: white100),
                    //     ),
                    //     child: DropdownButtonHideUnderline(
                    //       child: DropdownButton2<dynamic>(
                    //         value: selectedItem,
                    //         isExpanded: true,
                    //         iconStyleData: IconStyleData(
                    //           icon: Row(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: [
                    //               const SizedBox(width: 6),
                    //               SvgPicture.asset('assets/svg/dropdown.svg'),
                    //               const SizedBox(width: 18),
                    //             ],
                    //           ),
                    //         ),
                    //         onChanged: (newValue) {
                    //           setState(() {
                    //             selectedItem = newValue;
                    //           });
                    //         },
                    //         items: incomeHistory.totals!.map((data) {
                    //           final product = data['product'];
                    //           return DropdownMenuItem<dynamic>(
                    //             value: data,
                    //             child: Row(
                    //               children: [
                    //                 SvgPicture.asset('assets/svg/residual.svg'),
                    //                 const SizedBox(width: 8),
                    //                 Expanded(
                    //                   child: Text(
                    //                     '${product['name']}',
                    //                     style: const TextStyle(
                    //                       color: black950,
                    //                       fontSize: 14,
                    //                       fontWeight: FontWeight.w400,
                    //                     ),
                    //                     maxLines: 1,
                    //                     overflow: TextOverflow.ellipsis,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           );
                    //         }).toList(),

                    //         dropdownStyleData: DropdownStyleData(
                    //           decoration: BoxDecoration(
                    //             color: Colors.white,
                    //             borderRadius: BorderRadius.circular(10),
                    //             border: Border.all(color: Colors.grey.shade300),
                    //           ),
                    //         ),

                    //         menuItemStyleData: MenuItemStyleData(
                    //           selectedMenuItemBuilder: (context, child) =>
                    //               Container(
                    //                 decoration: BoxDecoration(
                    //                   color: Colors.orange.shade100,
                    //                   borderRadius: BorderRadius.circular(6),
                    //                 ),
                    //                 child: child,
                    //               ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 16),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16),
                    //   child: Text(
                    //     'Нийт үлдэгдэл',
                    //     style: TextStyle(
                    //       color: black950,
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...incomeHistory.totals!
                              .map(
                                (data) => Row(
                                  children: [
                                    SizedBox(width: 16),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width *
                                          0.7,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: white,
                                      ),
                                      padding: EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '${data['product']['name']}',
                                                  style: TextStyle(
                                                    color: black950,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      'Үлдэгдэл',
                                                      style: TextStyle(
                                                        color: orange,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${data['balance']} ш',
                                                      style: TextStyle(
                                                        color: black950,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 12),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Орлого',
                                                      style: TextStyle(
                                                        color: orange,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${data['in']} ш',
                                                      style: TextStyle(
                                                        color: black950,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    // SizedBox(height: 2),
                                                    // Text(
                                                    //   '1234 Тн',
                                                    //   style: TextStyle(
                                                    //     color: black600,
                                                    //     fontSize: 12,
                                                    //     fontWeight:
                                                    //         FontWeight.w400,
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 12),
                                              Container(
                                                width: 1,
                                                height: 30,
                                                color: black100,
                                              ),
                                              SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,

                                                  children: [
                                                    Text(
                                                      'Зарлага',
                                                      style: TextStyle(
                                                        color: orange,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${data['out']} ш',
                                                      style: TextStyle(
                                                        color: black950,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    // SizedBox(height: 2),
                                                    // Text(
                                                    //   '1234 Тн',
                                                    //   style: TextStyle(
                                                    //     color: black600,
                                                    //     fontSize: 12,
                                                    //     fontWeight:
                                                    //         FontWeight.w400,
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                              // SizedBox(width: 12),
                                              // Container(
                                              //   width: 1,
                                              //   height: 40,
                                              //   color: black100,
                                              // ),
                                              // SizedBox(width: 12),
                                              // Expanded(
                                              //   child: Column(
                                              //     crossAxisAlignment:
                                              //         CrossAxisAlignment.start,
                                              //     children: [
                                              //       Text(
                                              //         'Үлдэгдэл',
                                              //         style: TextStyle(
                                              //           color: orange,
                                              //           fontSize: 12,
                                              //           fontWeight:
                                              //               FontWeight.w400,
                                              //         ),
                                              //       ),
                                              //       Text(
                                              //         '${data['balance']} ш',
                                              //         style: TextStyle(
                                              //           color: black950,
                                              //           fontSize: 14,
                                              //           fontWeight:
                                              //               FontWeight.w700,
                                              //         ),
                                              //       ),
                                              //       SizedBox(height: 2),
                                              //     ],
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                          SizedBox(width: 16),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
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
                                  await listOfHistory(
                                    page,
                                    limit,
                                    filterIndex,
                                    startDate:
                                        startDate != null && startDate != ''
                                        ? startDate.toString()
                                        : '',
                                    endDate: endDate != null && endDate != ''
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
                    ),
                    // SizedBox(height: 12),
                    // Text(
                    //   'Үлдэгдэл',
                    //   style: TextStyle(
                    //     color: black400,
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.w400,
                    //   ),
                    // ),
                    // SizedBox(height: 12),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           '${selectedResidual?.residual != null ? Utils().formatCurrencyDouble(selectedResidual!.residual!.toDouble()) : '-'} ш',
                    //           style: TextStyle(
                    //             color: orange,
                    //             fontSize: 20,
                    //             fontWeight: FontWeight.w700,
                    //           ),
                    //         ),
                    //         SizedBox(height: 2),
                    //         Text(
                    //           '= ${selectedResidual?.weight ?? '-'}',
                    //           style: TextStyle(
                    //             color: black600,
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w400,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),
                    Padding(
                      padding: EdgeInsetsGeometry.only(
                        right: 16,
                        left: 16,
                        bottom: 16,
                      ),
                      child: Column(
                        children: [
                          isLoadingPage
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
