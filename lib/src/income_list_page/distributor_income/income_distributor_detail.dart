// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ttt_merchant_flutter/api/inventory_api.dart';
import 'package:ttt_merchant_flutter/components/controller/refresher.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/dist_income_model.dart';
import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/in_out_types.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/distributor_income/income_confirm_page.dart';
import 'package:ttt_merchant_flutter/utils/utils.dart';

class IncomeDistributorDetailArguments {
  final String id;

  IncomeDistributorDetailArguments({required this.id});
}

class IncomeDistributorDetail extends StatefulWidget {
  final String id;
  static const routeName = "IncomeDistributorDetail";
  const IncomeDistributorDetail({super.key, required this.id});

  @override
  State<IncomeDistributorDetail> createState() =>
      _IncomeDistributorDetailState();
}

class _IncomeDistributorDetailState extends State<IncomeDistributorDetail>
    with AfterLayoutMixin {
  int stepIndex = 0;
  bool isLoading = false;
  bool isLoadingPage = true;
  DistIncomeModel data = DistIncomeModel();

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      data = await InventoryApi().getDistributorIncome(widget.id);
      print('====inoiuttype=====');
      print(data.inOutType?.length);
      print('====inoiuttype=====');
      stepIndex = _getStepIndex(data.inOutType);
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  int _getStepIndex(String? status) {
    switch (status) {
      case "NEW":
        return 0;
      case "PENDING":
        return 1;
      case "DONE":
        return 2;
      default:
        return 0;
    }
  }

  List<TimelineStepData> buildSteps(List<InOutTypes> statuses) {
    final Map<String, InOutTypes> statusMap = {
      for (var s in statuses) s.status!: s,
    };
    return [
      TimelineStepData(
        title: 'Хуваарилагдсан ',
        subtitle: 'Жолоочид хуваарилагдсан.',
        time: statusMap["NEW"] != null
            ? DateFormat(
                'yyyy/MM/dd HH:mm',
              ).format(DateTime.parse(statusMap["NEW"]!.date!).toLocal())
            : "-",
      ),
      TimelineStepData(
        title: 'Агуулахаас гарсан',
        subtitle: 'Түлш тээвэрлэгдэж байна.',
        time: statusMap["PENDING"] != null
            ? DateFormat(
                'yyyy/MM/dd HH:mm',
              ).format(DateTime.parse(statusMap["PENDING"]!.date!).toLocal())
            : "-",
      ),
      TimelineStepData(
        title: 'Хүлээн авсан',
        subtitle: 'Түлшийг хүлээлгэн өгсөн.',
        time: statusMap["DONE"] != null
            ? DateFormat(
                'yyyy/MM/dd HH:mm',
              ).format(DateTime.parse(statusMap["DONE"]!.date!).toLocal())
            : "-",
      ),
    ];
  }

  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() {
      isLoadingPage = true;
    });
    data = await InventoryApi().getDistributorIncome(widget.id);
    setState(() {
      stepIndex = _getStepIndex(data.inOutType);
      isLoadingPage = false;
    });
    refreshController.refreshCompleted();
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
          'Дэлгэрэнгүй',
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
      ),
      backgroundColor: white50,
      body: isLoadingPage == true
          ? CustomLoader()
          : Stack(
              children: [
                Refresher(
                  color: orange,
                  refreshController: refreshController,
                  onRefresh: onRefresh,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: white,
                              border: Border.all(color: white100),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsetsGeometry.all(16),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svg/ttt_mini.svg',
                                              ),
                                              SizedBox(width: 6),
                                              Text(
                                                'ТАВАН ТОЛГОЙ ТҮЛШ ХХК',
                                                style: TextStyle(
                                                  color: black,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Row(
                                          //   children: [
                                          //     // // Text(
                                          //     // //   '750 КГ',
                                          //     // //   style: TextStyle(
                                          //     // //     color: black600,
                                          //     // //     fontSize: 12,
                                          //     // //     fontWeight: FontWeight.w400,
                                          //     // //   ),
                                          //     // // ),
                                          //     // // SizedBox(width: 4),
                                          //     // Container(
                                          //     //   width: 2,
                                          //     //   height: 2,
                                          //     //   decoration: BoxDecoration(
                                          //     //     borderRadius: BorderRadius.circular(12),
                                          //     //     color: black600,
                                          //     //   ),
                                          //     // ),
                                          //     // SizedBox(width: 4),
                                          //     Text(
                                          //       '${data.quantity ?? '-'} ш',
                                          //       style: TextStyle(
                                          //         color: black950,
                                          //         fontSize: 12,
                                          //         fontWeight: FontWeight.w700,
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/svg/car.svg',
                                                ),
                                                SizedBox(width: 12),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${data.vehiclePlateNo?.toUpperCase()}',
                                                        style: TextStyle(
                                                          color: black950,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${data.driverName}',
                                                        style: TextStyle(
                                                          color: black600,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        '-',
                                                        style: TextStyle(
                                                          color: black950,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        textAlign:
                                                            TextAlign.end,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      SizedBox(height: 2),
                                                      Text(
                                                        textAlign:
                                                            TextAlign.end,
                                                        '-',
                                                        style: TextStyle(
                                                          color: black600,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                OrderTimeline(
                                  steps: buildSteps(data.inOutTypes!),
                                  stepIndex: stepIndex,
                                  orange: orange,
                                  white50: white50,
                                  white100: white100,
                                  black950: black950,
                                  black600: black600,
                                  black400: black400,
                                ),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: white,
                                  ),

                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Захиалгын мэдээлэл',
                                        style: TextStyle(
                                          color: black400,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Захиалга үүссэн огноо:',
                                            style: TextStyle(
                                              color: black800,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '${DateFormat('yyyy/MM/dd HH:mm').format(DateTime.parse(data.createdAt!).toLocal())}',
                                            style: TextStyle(
                                              color: black950,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Захиалгын дугаар:',
                                            style: TextStyle(
                                              color: black800,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '${data.code ?? '#'}',
                                            style: TextStyle(
                                              color: black950,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Захиалсан тоо :',
                                            style: TextStyle(
                                              color: black800,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '${data.quantity ?? '-'} ш',
                                            style: TextStyle(
                                              color: black950,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Баталгаажсан тоо:',
                                            style: TextStyle(
                                              color: black800,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '-',
                                            style: TextStyle(
                                              color: black950,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // SizedBox(height: 4),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Text(
                                      //       'Баталгаажсан тоо:',
                                      //       style: TextStyle(
                                      //         color: black800,
                                      //         fontSize: 14,
                                      //         fontWeight: FontWeight.w500,
                                      //       ),
                                      //     ),
                                      //     Text(
                                      //       '1,500 ш',
                                      //       style: TextStyle(
                                      //         color: black950,
                                      //         fontSize: 14,
                                      //         fontWeight: FontWeight.w600,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      SizedBox(height: 14),
                                      Container(
                                        width: MediaQuery.of(
                                          context,
                                        ).size.width,
                                        height: 1,
                                        color: white200,
                                      ),
                                      SizedBox(height: 14),
                                      Text(
                                        'Тээврийн мэдээлэл',
                                        style: TextStyle(
                                          color: black400,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Илгээх агуулах:',
                                            style: TextStyle(
                                              color: black800,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '${data.toInventory?.name ?? '-'}',
                                            style: TextStyle(
                                              color: black950,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Хүлээн авах цэг:',
                                            style: TextStyle(
                                              color: black800,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '${data.fromInventory?.name ?? '-'}',
                                            style: TextStyle(
                                              color: black950,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // SizedBox(height: 4),
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //   children: [
                                      //     Text(
                                      //       'Нярав:',
                                      //       style: TextStyle(
                                      //         color: black800,
                                      //         fontSize: 14,
                                      //         fontWeight: FontWeight.w500,
                                      //       ),
                                      //     ),
                                      //     Text(
                                      //       '${data}',
                                      //       style: TextStyle(
                                      //         color: black950,
                                      //         fontSize: 14,
                                      //         fontWeight: FontWeight.w600,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      SizedBox(height: 14),
                                      Container(
                                        width: MediaQuery.of(
                                          context,
                                        ).size.width,
                                        height: 1,
                                        color: white200,
                                      ),
                                      SizedBox(height: 14),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Захиалсан бараа',
                                            style: TextStyle(
                                              color: black400,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          // Text(
                                          //   '20,000.00₮',
                                          //   style: TextStyle(
                                          //     color: black950,
                                          //     fontSize: 16,
                                          //     fontWeight: FontWeight.w600,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      SizedBox(height: 8),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Нийт дүн:',
                                            style: TextStyle(
                                              color: black800,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '${Utils().formatCurrencyDouble(data.totalAmount?.toDouble() ?? 0)}₮',
                                            style: TextStyle(
                                              color: black950,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),

                                      Column(
                                        children: data.products!
                                            .map(
                                              (item) => Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '${item.name}:',
                                                        style: TextStyle(
                                                          color: black800,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${item.quantity} x ${Utils().formatCurrencyDouble(item.price?.toDouble() ?? 0)}₮',
                                                        style: TextStyle(
                                                          color: black950,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 2),
                                                ],
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom + 150,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                data.inOutType == "PENDING"
                    ? Align(
                        alignment: AlignmentDirectional.bottomCenter,
                        child: Container(
                          color: white,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 16,
                              right: 16,
                              left: 16,
                              bottom: Platform.isIOS
                                  ? MediaQuery.of(context).padding.bottom
                                  : MediaQuery.of(context).padding.bottom + 16,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Нийт дүн:',
                                      style: TextStyle(
                                        color: black950,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '${Utils().formatCurrencyDouble(data.totalAmount?.toDouble() ?? 0)}₮',
                                      style: TextStyle(
                                        color: orange,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          // onSubmit();
                                          Navigator.of(context).pushNamed(
                                            IncomeConfirmPage.routeName,
                                            arguments:
                                                IncomeConfirmPageArguments(
                                                  data: data,
                                                ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            color: orange,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              isLoading == true
                                                  ? Container(
                                                      // margin: EdgeInsets.only(right: 15),
                                                      width: 17,
                                                      height: 17,
                                                      child: Platform.isAndroid
                                                          ? Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                    color:
                                                                        white,
                                                                    strokeWidth:
                                                                        2.5,
                                                                  ),
                                                            )
                                                          : Center(
                                                              child:
                                                                  CupertinoActivityIndicator(
                                                                    color:
                                                                        white,
                                                                  ),
                                                            ),
                                                    )
                                                  : Text(
                                                      'Баталгаажуулах',
                                                      style: TextStyle(
                                                        color: white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                      )
                    : SizedBox(),
              ],
            ),
    );
  }
}

class TimelineStepData {
  final String title;
  final String subtitle;
  final String time;
  TimelineStepData({
    required this.title,
    required this.subtitle,
    required this.time,
  });
}

class OrderTimeline extends StatefulWidget {
  final List<TimelineStepData> steps;

  /// 0-ээс эхлэх индекс. Жишээ нь 1 гэвэл 0 = done, 1 = current, 2+ = next
  final int stepIndex;

  // Та эдгээр өнгийг өөрийнхтэйгээ тааруулаад солиорой.
  final Color orange;
  final Color white50;
  final Color white100;
  final Color black950;
  final Color black600;
  final Color black400;

  const OrderTimeline({
    super.key,
    required this.steps,
    required this.stepIndex,
    required this.orange,
    required this.white50,
    required this.white100,
    required this.black950,
    required this.black600,
    required this.black400,
  });

  @override
  State<OrderTimeline> createState() => _OrderTimelineState();
}

class _OrderTimelineState extends State<OrderTimeline> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.white50,
      child: Column(
        children: List.generate(widget.steps.length, (i) {
          final item = widget.steps[i];

          // connector-уудын логик
          final bool topActive = i == 0 ? true : (i - 1) < widget.stepIndex;
          final bool bottomActive = i < widget.stepIndex;

          // node-ийн icon (svg)
          final String icon = (i < widget.stepIndex || i == widget.stepIndex)
              ? 'assets/svg/step_access.svg' // done/current
              : 'assets/svg/step_denied.svg'; // next

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Column(
                  children: [
                    _connector(topActive ? widget.orange : widget.white100),
                    SvgPicture.asset(icon),
                    _connector(
                      i == 3
                          ? widget.white50
                          : bottomActive
                          ? widget.orange
                          : widget.white100,
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          color: widget.black950,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.subtitle,
                        style: TextStyle(
                          color: widget.black600,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  item.time,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: widget.black400,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _connector(Color color) {
    return Container(width: 7, height: 20, color: color);
  }
}
