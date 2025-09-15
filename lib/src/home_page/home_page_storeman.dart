// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:after_layout/after_layout.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ttt_merchant_flutter/api/product_api.dart';
import 'package:ttt_merchant_flutter/components/app_bar/custom_app_bar.dart';
import 'package:ttt_merchant_flutter/components/cards/income_page_cards/income_done_history_card.dart';
// import 'package:ttt_merchant_flutter/components/cards/income_page_cards/income_history_card.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/controller/refresher.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/general/general_init.dart';
import 'package:ttt_merchant_flutter/models/general/residual.dart';
import 'package:ttt_merchant_flutter/models/result.dart';
import 'package:ttt_merchant_flutter/provider/general_provider.dart';
// import 'package:ttt_merchant_flutter/services/notification.dart';
// import 'package:ttt_merchant_flutter/services/notification.dart';
// import 'package:ttt_merchant_flutter/services/notification.dart';
// import 'package:ttt_merchant_flutter/utils/utils.dart';

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
    incomeHistory = await ProductApi().getIncomeSaleMan(
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
                      Container(
                        // padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Үлдэгдэл',
                                style: TextStyle(
                                  color: black400,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            general.residual != null
                                ? SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: general.residual!
                                          .map(
                                            (data) => Row(
                                              children: [
                                                SizedBox(width: 12),

                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadiusGeometry.circular(
                                                              8,
                                                            ),
                                                        child: Image.asset(
                                                          height: 158,
                                                          width: 158,
                                                          'assets/images/default.jpg',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      SizedBox(height: 6),
                                                      Text(
                                                        '${data.name}',
                                                        style: TextStyle(
                                                          color: black950,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(height: 2),
                                                      Text(
                                                        'Үлдэгдэл: ${data.residual} ш',
                                                        style: TextStyle(
                                                          color:
                                                              data.residual == 0
                                                              ? redColor
                                                              : black600,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(height: 2),
                                                      Text(
                                                        'Жин: ${data.weight ?? '-'}',
                                                        style: TextStyle(
                                                          color: black600,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 16),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  )
                                : SizedBox(),
                            //     ? Container(
                            //         decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(100),
                            //           color: white50,
                            //         ),
                            //         padding: EdgeInsets.symmetric(vertical: 4),
                            //         child: DropdownButtonHideUnderline(
                            //           child: DropdownButton2<String>(
                            //             value: selectedResidual?.id,
                            //             isDense: true,
                            //             iconStyleData: IconStyleData(
                            //               icon: Row(
                            //                 mainAxisSize: MainAxisSize.min,
                            //                 children: [
                            //                   // const SizedBox(width: 6),
                            //                   SvgPicture.asset(
                            //                     'assets/svg/dropdown.svg',
                            //                   ),
                            //                   const SizedBox(width: 8),
                            //                 ],
                            //               ),
                            //             ),

                            //             selectedItemBuilder: (context) {
                            //               return general.residual!.map((data) {
                            //                 return Row(
                            //                   mainAxisSize: MainAxisSize.min,
                            //                   children: [
                            //                     SvgPicture.asset(
                            //                       'assets/svg/residual.svg',
                            //                     ),
                            //                     const SizedBox(width: 12),
                            //                     Text(
                            //                       data.name ?? '',
                            //                       style: const TextStyle(
                            //                         color: black950,
                            //                         fontSize: 14,
                            //                         fontWeight: FontWeight.w400,
                            //                       ),
                            //                       maxLines: 1,
                            //                       overflow:
                            //                           TextOverflow.ellipsis,
                            //                     ),
                            //                   ],
                            //                 );
                            //               }).toList();
                            //             },
                            //             onChanged: (newValue) {
                            //               setState(() {
                            //                 selectedResidual = general.residual!
                            //                     .firstWhere(
                            //                       (e) => e.id == newValue,
                            //                     );
                            //               });
                            //             },
                            //             dropdownStyleData: DropdownStyleData(
                            //               decoration: BoxDecoration(
                            //                 color: Colors.white,
                            //                 borderRadius: BorderRadius.circular(
                            //                   10,
                            //                 ),
                            //                 border: Border.all(color: white100),
                            //               ),
                            //               padding: EdgeInsets.all(6),
                            //             ),
                            //             menuItemStyleData: MenuItemStyleData(
                            //               selectedMenuItemBuilder:
                            //                   (context, child) {
                            //                     return Container(
                            //                       decoration: BoxDecoration(
                            //                         color: orange,
                            //                         borderRadius:
                            //                             BorderRadius.circular(
                            //                               6,
                            //                             ),
                            //                       ),
                            //                       child: child,
                            //                     );
                            //                   },
                            //             ),
                            //             items: general.residual!.map((data) {
                            //               final isSelected =
                            //                   data.id == selectedResidual?.id;
                            //               return DropdownMenuItem<String>(
                            //                 value: data.id,
                            //                 child: Text(
                            //                   data.name ?? '',
                            //                   style: TextStyle(
                            //                     color: isSelected
                            //                         ? white
                            //                         : black950,
                            //                     fontSize: 14,
                            //                     fontWeight: FontWeight.w400,
                            //                   ),
                            //                 ),
                            //               );
                            //             }).toList(),
                            //           ),
                            //         ),
                            //       )
                            //     : const SizedBox(),

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
                            // SizedBox(height: 12),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
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

                      SizedBox(height: mediaQuery.padding.bottom + 24),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
