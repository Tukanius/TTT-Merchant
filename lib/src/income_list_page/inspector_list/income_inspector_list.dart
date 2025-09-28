// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ttt_merchant_flutter/api/product_api.dart';
import 'package:ttt_merchant_flutter/components/app_bar/custom_app_bar.dart';
import 'package:ttt_merchant_flutter/components/cards/income_page_cards/inspector_list_card.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/controller/refresher.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/components/ui/form_textfield.dart';
import 'package:ttt_merchant_flutter/models/result.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/inspector_list/search_vehicle.dart';

class IncomeInspectorList extends StatefulWidget {
  static const routeName = "IncomeInspectorList";
  const IncomeInspectorList({super.key});

  @override
  State<IncomeInspectorList> createState() => _IncomeInspectorListState();
}

class _IncomeInspectorListState extends State<IncomeInspectorList>
    with AfterLayoutMixin {
  // int selectedIndex = 0;
  int? selectedIndexTile;
  TextEditingController controller = TextEditingController();
  // final Map<String, String> tabFilters = {
  //   'Нийт': 'ALL',
  //   'Өнөөдөр': 'TODAY',
  //   '7 Хоног': 'WEEK',
  //   '1 Сар': 'MONTH',
  //   '1 Жил': 'YEAR',
  // };
  bool isLoadingPage = true;
  Result inspectorList = Result();

  int page = 1;
  int limit = 10;
  bool isLoadingList = true;

  listOfInspector(page, limit, {String? query}) async {
    inspectorList = await ProductApi().getInspectorList(
      ResultArguments(
        offset: Offset(page: page, limit: limit),
        filter: Filter(receiptStatus: "FACTORY_APPROVED"),
      ),
    );
    setState(() {
      isLoadingList = false;
    });
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      await listOfInspector(page, limit);
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
      isLoadingList = true;
      limit = 10;
    });
    await listOfInspector(page, limit);
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
    await listOfInspector(page, limit);
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

  Timer? timer;

  onChange(String query) async {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        isLoadingList = true;
      });
      await listOfInspector(page, limit, query: query);
      setState(() {
        isLoadingList = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsetsGeometry.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Захиалга хайх',
                        style: TextStyle(
                          color: black950,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),
                      FormTextField(
                        controller: controller,
                        inputType: TextInputType.text,
                        contentPadding: EdgeInsets.all(12),
                        dense: true,
                        colortext: black,
                        readOnly: true,
                        color: white,
                        name: 'vehicleNumberFilter',
                        hintTextStyle: TextStyle(
                          color: black400,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        hintText: 'Улсын дугаар хайх',
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 12),
                            SvgPicture.asset('assets/svg/search.svg'),
                            SizedBox(width: 8),
                          ],
                        ),
                        onTap: () async {
                          final result = await Navigator.of(context).pushNamed(
                            SearchVehicle.routeName,
                            arguments: SearchVehicleArguments(
                              textEditingController: controller,
                              onClick: (value, value2) {
                                print('======testingsearch=====');
                                // setState(() {
                                //   searchedResult = value;
                                //   search.text = value2;
                                //   if (value.rows?.isEmpty == false) {
                                //     fitResult = value.rows!
                                //         .map((item) => LatLng(
                                //               (item.latitude as num?)
                                //                       ?.toDouble() ??
                                //                   0.0,
                                //               (item.longitude as num?)
                                //                       ?.toDouble() ??
                                //                   0.0,
                                //             ))
                                //         .toList();
                                //     _fitBounds(fitResult);
                                //     updateMarkersStays(value);
                                //   }
                                // });

                                print('======testingsearch=====');
                              },
                              // onSearch: (value) {
                              //   setState(() {
                              //     properties = value;
                              //     fitResult = [
                              //       LatLng(value.latitude!.toDouble(),
                              //           value.longitude!.toDouble())
                              //     ];
                              //     _fitBounds(fitResult);
                              //     markers.add(
                              //       Marker(
                              //         onTap: () async {
                              //           await getData('property', value, true);
                              //         },
                              //         markerId: MarkerId("${value.id}"),
                              //         position: LatLng(value.latitude!.toDouble(),
                              //             value.longitude!.toDouble()),
                              //         icon: customIconGer,
                              //       ),
                              //     );
                              //     // _updateMarkersStays(value);
                              //   });
                              // },
                            ),
                          );
                          print(result);
                          print('====result====');

                          // if (result == true) {
                          //   setState(() {
                          //     showResult = true;
                          //   });
                          // } else {
                          //   setState(() {
                          //     showResult = false;
                          //   });
                          // }
                        },
                        // suffixIcon: Row(
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: [
                        //     SizedBox(width: 12),
                        //     GestureDetector(
                        //       onTap: () {
                        //         showModalBottomSheet(
                        //           context: context,
                        //           shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.vertical(
                        //               top: Radius.circular(8),
                        //             ),
                        //           ),
                        //           builder: (context) {
                        //             return CustomTableCalendar(
                        //               onDateSelected: (start, end) async {
                        //                 setState(() {
                        //                   startDate = start;
                        //                   endDate = end;
                        //                 });
                        //                 await listOfInOut(
                        //                   page,
                        //                   limit,
                        //                   queryVehicle: controller.text,
                        //                   startDate:
                        //                       startDate != '' &&
                        //                           startDate != null
                        //                       ? startDate.toString()
                        //                       : '',
                        //                   endDate:
                        //                       endDate != '' && endDate != null
                        //                       ? endDate.toString()
                        //                       : '',
                        //                 );
                        //                 Navigator.pop(context);
                        //               },
                        //             );
                        //           },
                        //         );
                        //       },
                        //       child: Container(
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(12),
                        //           color: white50,
                        //           border: Border.all(color: white100),
                        //         ),
                        //         padding: EdgeInsets.only(
                        //           left: 10,
                        //           right: 8,
                        //           top: 8,
                        //           bottom: 8,
                        //         ),
                        //         child: Row(
                        //           children: [
                        //             SvgPicture.asset(
                        //               'assets/svg/calendar.svg',
                        //               height: 20,
                        //               width: 20,
                        //             ),
                        //             SizedBox(width: 4),
                        //             Text(
                        //               formattedDate,
                        //               style: TextStyle(
                        //                 color: black950,
                        //                 fontSize: 14,
                        //                 fontWeight: FontWeight.w500,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(width: 4),
                        //   ],
                        // ),
                        borderColor: white100,
                        borderRadius: 12,
                        onChanged: (value) {
                          // onChange(value);
                        },
                      ),
                      SizedBox(height: 16),
                      isLoadingList
                          ? CustomLoader()
                          : (inspectorList.rows != null &&
                                inspectorList.rows!.isNotEmpty)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Баталгаажсан захиалгууд',
                                  style: TextStyle(
                                    color: black950,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 12),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Column(
                                    children: List.generate(
                                      inspectorList.rows!.length,
                                      (index) {
                                        final isExpanded =
                                            selectedIndexTile == index;
                                        final item = inspectorList.rows![index];
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
                                          child: InspectorListCard(
                                            isExtended: isExpanded,
                                            data: item,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          // Column(
                          //     children: incomeHistory.rows!
                          //         .map(
                          //           (data) => Column(
                          //             children: [
                          //               IncomeDoneHistoryCard(data: data,isExtended: isExpanded,),
                          //               const SizedBox(height: 16),
                          //             ],
                          //           ),
                          //         )
                          //         .toList(),
                          //   )
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

                      // GestureDetector(
                      //   onTap: () {
                      //     showModalBottomSheet(
                      //       context: context,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.vertical(
                      //           top: Radius.circular(8),
                      //         ),
                      //       ),
                      //       builder: (context) {
                      //         return CustomTableCalendar(
                      //           onDateSelected: (start, end) {
                      //             setState(() {
                      //               startDate = start;
                      //               endDate = end;
                      //             });
                      //             Navigator.pop(context);
                      //           },
                      //         );
                      //       },
                      //     );
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
                      //         SvgPicture.asset('assets/svg/calendar.svg'),
                      //         SizedBox(width: 12),
                      //         Text(
                      //           formattedDate,
                      //           style: TextStyle(
                      //             color: black950,
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 16),
                      // isLoadingHistoryIncome
                      //     ? CustomLoader()
                      //     : (incomeSaleMan.rows != null &&
                      //           incomeSaleMan.rows!.isNotEmpty)
                      //     ? Column(
                      //         children: incomeSaleMan.rows!
                      //             .map(
                      //               (data) => Column(
                      //                 children: [
                      //                   IncomeSalemanHistoryCard(data: data),
                      //                   SizedBox(height: 16),
                      //                 ],
                      //               ),
                      //             )
                      //             .toList(),
                      //       )
                      //     : Column(
                      //         children: [
                      //           SizedBox(height: 12),
                      //           Center(
                      //             child: const Text(
                      //               'Түүх алга байна',
                      //               style: TextStyle(
                      //                 color: black600,
                      //                 fontSize: 14,
                      //                 fontWeight: FontWeight.w400,
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
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
