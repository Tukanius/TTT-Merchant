// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ttt_merchant_flutter/api/sales_api.dart';
import 'package:ttt_merchant_flutter/components/cards/home_page_cards/distributor_residual.dart';
import 'package:ttt_merchant_flutter/components/custom_app_bar/custom_app_bar.dart';
import 'package:ttt_merchant_flutter/components/cards/home_page_cards/sale_history_card.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/controller/refresher.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/general/general_init.dart';
import 'package:ttt_merchant_flutter/models/general/residual.dart';
import 'package:ttt_merchant_flutter/models/result.dart';
import 'package:ttt_merchant_flutter/provider/general_provider.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/distributor_income/income_distributor_history.dart';

class HomePageDistributor extends StatefulWidget {
  final Function(int) onChangePage;
  static const routeName = "HomePageDistributor";
  const HomePageDistributor({super.key, required this.onChangePage});

  @override
  State<HomePageDistributor> createState() => _HomePageDistributorState();
}

class _HomePageDistributorState extends State<HomePageDistributor>
    with AfterLayoutMixin {
  int? selectedIndexTile;
  bool isLoadingPage = true;
  String? selectedValue;
  GeneralInit general = GeneralInit();
  Result salesHistory = Result();
  bool isLoadingHistory = true;
  int page = 1;
  int limit = 10;
  Residual? selectedResidual;

  listOfHistory(page, limit) async {
    salesHistory = await SalesApi().getPurchaseHistory(
      ResultArguments(
        offset: Offset(page: page, limit: limit),
        filter: Filter(dateType: 'ALL'),
      ),
    );
    selectedResidual = general.residual?.first;
    if (!mounted) return;
    setState(() {
      isLoadingHistory = false;
    });
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      general = await Provider.of<GeneralProvider>(
        context,
        listen: false,
      ).init();
      await listOfHistory(page, limit);
      if (!mounted) return;
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      print(e);
      if (!mounted) return;
      setState(() {
        isLoadingPage = true;
        ;
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
    general = await Provider.of<GeneralProvider>(context, listen: false).init();
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
                      DistributorResidual(generalInit: general),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Борлуулалтын түүх',
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
                              ).pushNamed(IncomeDistributorHistory.routeName);
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
                      isLoadingHistory
                          ? CustomLoader()
                          : (salesHistory.rows != null &&
                                salesHistory.rows!.isNotEmpty)
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
                      SizedBox(height: mediaQuery.padding.bottom),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
