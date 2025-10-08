// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
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
import 'package:ttt_merchant_flutter/models/result.dart';
import 'package:ttt_merchant_flutter/provider/general_provider.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/storeman_income/income_storeman_history.dart';

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
  bool isLoadingHistory = true;
  int filterIndex = 0;

  // User user = User();
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      general = await Provider.of<GeneralProvider>(
        context,
        listen: false,
      ).init();
      await listOfHistory(page, limit, filterIndex);
      setState(() {
        isLoadingPage = false;
      });

      print('===loader===');
      print(isLoadingHistory);
      print('===loader===');
    } catch (e) {
      print(e);
      setState(() {
        isLoadingPage = false;
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
                query: queryVehicle,
                requestStatus: "DONE",
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
                query: queryVehicle,
                requestStatus: "DONE",
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
      isLoadingHistory = true;
      isLoadingPage = true;
      limit = 10;
    });
    general = await Provider.of<GeneralProvider>(context, listen: false).init();
    setState(() {
      isLoadingPage = false;
    });
    await listOfHistory(page, limit, filterIndex);
    refreshController.refreshCompleted();
  }

  onLoading() async {
    if (!mounted) return;
    setState(() {
      limit += 10;
    });
    await listOfHistory(page, limit, filterIndex);
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
                          InkWell(
                            onTap: () {
                              Navigator.of(
                                context,
                              ).pushNamed(IncomeStoremanHistory.routeName);
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Бүгд',
                                  style: TextStyle(
                                    color: black800,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 6),
                                SvgPicture.asset('assets/svg/arrow_right.svg'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                setState(() {
                                  filterIndex = 0;
                                });
                                await listOfHistory(page, limit, filterIndex);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: white,
                                ),
                                padding: EdgeInsets.only(top: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Орлого',
                                      style: TextStyle(
                                        color: filterIndex == 0
                                            ? black950
                                            : black600,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    filterIndex == 0
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                              top: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: black950,
                                            ),
                                            height: 2,
                                            width:
                                                35, // ⚡ Текстийн урттай тааруулах — динамик бол textWidth ашиглаж болно
                                          )
                                        : SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                setState(() {
                                  filterIndex = 1;
                                });
                                await listOfHistory(page, limit, filterIndex);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: white,
                                ),
                                padding: EdgeInsets.only(top: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Зарлага',
                                      style: TextStyle(
                                        color: filterIndex == 1
                                            ? black950
                                            : black600,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    filterIndex == 1
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                              top: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: black950,
                                            ),
                                            height: 2,
                                            width:
                                                35, // ⚡ Текстийн урттай тааруулах — динамик бол textWidth ашиглаж болно
                                          )
                                        : SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),

                      isLoadingHistory
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
