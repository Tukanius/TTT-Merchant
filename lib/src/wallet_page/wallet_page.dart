// ignore_for_file: deprecated_member_use

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ttt_merchant_flutter/api/balance_api.dart';
import 'package:ttt_merchant_flutter/components/app_bar/custom_app_bar.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/controller/refresher.dart';
import 'package:ttt_merchant_flutter/components/table_calendar/table_calendar.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/components/wallet_card/wallet_history_card.dart';
import 'package:ttt_merchant_flutter/models/general/general_balance.dart';
// import 'package:ttt_merchant_flutter/models/general/general_init.dart';
import 'package:ttt_merchant_flutter/models/result.dart';
import 'package:ttt_merchant_flutter/provider/general_provider.dart';
import 'package:ttt_merchant_flutter/src/wallet_page/wallet_recharge.dart';
import 'package:ttt_merchant_flutter/utils/utils.dart';

class WalletPage extends StatefulWidget {
  static const routeName = "WalletPage";
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> with AfterLayoutMixin {
  bool isLoadingPage = true;
  int selectFilter = 0;
  Result walletList = Result();
  bool isLoadingHistory = true;
  int page = 1;
  int limit = 10;
  GeneralBalance generalBalance = GeneralBalance();
  TextEditingController controller = TextEditingController();
  @override
  afterFirstLayout(BuildContext context) async {
    try {
      generalBalance = await Provider.of<GeneralProvider>(
        context,
        listen: false,
      ).initBalance();
      await listOfHistory(page, limit);
      print('=========loadhistory=========');
      print(isLoadingHistory);
      print('=========loadhistory=========');
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  listOfHistory(page, limit, {String? startDate, String? endDate}) async {
    walletList = await BalanceApi().getWalletHistory(
      ResultArguments(
        offset: Offset(page: page, limit: limit),
        filter: Filter(
          type: 'ALL',
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

  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() {
      isLoadingPage = true;
      isLoadingHistory = true;
    });
    generalBalance = await Provider.of<GeneralProvider>(
      context,
      listen: false,
    ).initBalance();
    setState(() {
      isLoadingPage = false;
    });
    await listOfHistory(
      page,
      limit,
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
    await listOfHistory(
      page,
      limit,
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
          "${endDate!.year}/${endDate!.month.toString().padLeft(2, '0')}/${endDate!.day.toString().padLeft(2, '0')}";
    }
    return "";
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
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              right: 0,
                              child: SvgPicture.asset(
                                'assets/svg/wallet_bg.svg',
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Үлдэгдэл',
                                    style: TextStyle(
                                      color: black950,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${Utils().formatCurrencyDouble(generalBalance.lastBalance?.toDouble() ?? 0)}₮',
                                    style: TextStyle(
                                      color: black950,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 36),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            controller.text = '0';
                                            final result =
                                                await Navigator.of(
                                                  context,
                                                ).pushNamed(
                                                  WalletRecharge.routeName,
                                                  arguments:
                                                      WalletRechargeArguments(
                                                        textController:
                                                            controller,
                                                      ),
                                                );
                                            if (result == true) {
                                              onRefresh();
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: orange,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Данс цэнэглэх',
                                                  style: TextStyle(
                                                    color: white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
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
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Гүйлгээний түүх',
                        style: TextStyle(
                          color: black950,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 12),
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
                                  await listOfHistory(
                                    page,
                                    limit,
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
                      // SizedBox(height: 16),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(12),
                      //     color: white,
                      //   ),
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: 2,
                      //     vertical: 8,
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: GestureDetector(
                      //           onTap: () {
                      //             setState(() {
                      //               selectFilter = 0;
                      //             });
                      //           },
                      //           child: Container(
                      //             padding: EdgeInsets.symmetric(vertical: 5),
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 Text(
                      //                   'Өчигдөр',
                      //                   style: TextStyle(
                      //                     color: selectFilter == 0
                      //                         ? orange
                      //                         : black950,
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.w500,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         width: 1,
                      //         height: 16,
                      //         color: black.withOpacity(0.1),
                      //       ),
                      //       Expanded(
                      //         child: GestureDetector(
                      //           onTap: () {
                      //             setState(() {
                      //               selectFilter = 1;
                      //             });
                      //           },

                      //           child: Container(
                      //             padding: EdgeInsets.symmetric(vertical: 5),
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 Text(
                      //                   '7 хоног',
                      //                   style: TextStyle(
                      //                     color: selectFilter == 1
                      //                         ? orange
                      //                         : black950,
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.w500,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         width: 1,
                      //         height: 16,
                      //         color: black.withOpacity(0.1),
                      //       ),
                      //       Expanded(
                      //         child: GestureDetector(
                      //           onTap: () {
                      //             setState(() {
                      //               selectFilter = 2;
                      //             });
                      //           },
                      //           child: Container(
                      //             padding: EdgeInsets.symmetric(vertical: 5),
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 Text(
                      //                   'Сар',
                      //                   style: TextStyle(
                      //                     color: selectFilter == 2
                      //                         ? orange
                      //                         : black950,
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.w500,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 12),
                      isLoadingHistory == true
                          ? CustomLoader()
                          : walletList.rows != null &&
                                walletList.rows?.isEmpty == false
                          ? Column(
                              children: [
                                Column(
                                  children: walletList.rows!
                                      .map(
                                        (data) => Column(
                                          children: [
                                            WalletHistoryCard(data: data),
                                            SizedBox(height: 12),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).padding.bottom +
                                      150,
                                ),
                              ],
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
                ),
              ),
            ),
    );
  }
}
