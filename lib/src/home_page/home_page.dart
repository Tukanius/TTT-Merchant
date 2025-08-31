// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ttt_merchant_flutter/api/product_api.dart';
import 'package:ttt_merchant_flutter/components/cards/home_page_cards/sale_history_card.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/refresher/refresher.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/general/general_init.dart';
import 'package:ttt_merchant_flutter/models/general/residual.dart';
import 'package:ttt_merchant_flutter/models/result.dart';
import 'package:ttt_merchant_flutter/provider/general_provider.dart';
import 'package:ttt_merchant_flutter/src/home_page/purchase_request_page.dart';
import 'package:ttt_merchant_flutter/src/home_page/sales_history_page.dart';
import 'package:ttt_merchant_flutter/src/notify_page/notify_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = "HomePage";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin {
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
    salesHistory = await ProductApi().getPurchaseHistory(
      ResultArguments(
        offset: Offset(page: page, limit: limit),
        filter: Filter(dateType: 'ALL'),
      ),
    );
    selectedResidual = general.residual?.first;
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
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: false,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: SvgPicture.asset('assets/svg/TTT.svg'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(NotifyPage.routeName);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      child: Center(
                        child: SvgPicture.asset('assets/svg/notify.svg'),
                      ),
                    ),
                    Positioned(
                      right: 7,
                      top: 4,
                      child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: rednotify,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16),
              ],
            ),
          ),
        ],
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
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            general.residual != null
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: white50,
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        value: selectedResidual?.id,
                                        isDense: true,
                                        iconStyleData: IconStyleData(
                                          icon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // const SizedBox(width: 6),
                                              SvgPicture.asset(
                                                'assets/svg/dropdown.svg',
                                              ),
                                              const SizedBox(width: 6),
                                            ],
                                          ),
                                        ),
                                        selectedItemBuilder: (context) {
                                          return general.residual!.map((data) {
                                            return Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/svg/residual.svg',
                                                ),
                                                const SizedBox(width: 12),
                                                Text(
                                                  data.name ?? '',
                                                  style: const TextStyle(
                                                    color: black950,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            );
                                          }).toList();
                                        },
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedResidual = general.residual!
                                                .firstWhere(
                                                  (e) => e.id == newValue,
                                                );
                                          });
                                        },
                                        dropdownStyleData: DropdownStyleData(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(color: white100),
                                          ),
                                          padding: EdgeInsets.all(6),
                                        ),
                                        menuItemStyleData: MenuItemStyleData(
                                          selectedMenuItemBuilder:
                                              (context, child) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    color: orange,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          6,
                                                        ),
                                                  ),
                                                  child: child,
                                                );
                                              },
                                        ),
                                        items: general.residual!.map((data) {
                                          final isSelected =
                                              data.id == selectedResidual?.id;
                                          return DropdownMenuItem<String>(
                                            value: data.id,
                                            child: Text(
                                              data.name ?? '',
                                              style: TextStyle(
                                                color: isSelected
                                                    ? white
                                                    : black950,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),

                            SizedBox(height: 12),
                            Text(
                              'Үлдэгдэл',
                              style: TextStyle(
                                color: black400,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${selectedResidual?.residual ?? '-'} ш',
                                      style: TextStyle(
                                        color: orange,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      '= ${selectedResidual?.weight ?? '-'}',
                                      style: TextStyle(
                                        color: black600,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(
                                  context,
                                ).pushNamed(PurchaseRequestPage.routeName);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: orange,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '+ Татан авалт',
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
                          ],
                        ),
                      ),
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
                              ).pushNamed(SalesHistoryPage.routeName);
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

                      isLoadingHistory == true
                          ? CustomLoader()
                          : ClipRRect(
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
