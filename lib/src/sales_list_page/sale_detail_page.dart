// ignore_for_file: deprecated_member_use

// import 'dart:io';

// import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ttt_merchant_flutter/api/sales_api.dart';
import 'package:ttt_merchant_flutter/components/custom_loader/custom_loader.dart';
import 'package:ttt_merchant_flutter/components/controller/refresher.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/sales_models/request_statuses.dart';
import 'package:ttt_merchant_flutter/models/sales_models/sales_model.dart';
import 'package:ttt_merchant_flutter/src/sales_list_page/sale_payment.dart';
// import 'package:ttt_merchant_flutter/src/income_list_page/income_confirm_page.dart';
import 'package:ttt_merchant_flutter/utils/utils.dart';

// Sales
class SaleDetailPageArguments {
  final String id;

  SaleDetailPageArguments({required this.id});
}

class SaleDetailPage extends StatefulWidget {
  final String id;
  static const routeName = "SaleDetailPage";
  const SaleDetailPage({super.key, required this.id});

  @override
  State<SaleDetailPage> createState() => _SaleDetailPageState();
}

class _SaleDetailPageState extends State<SaleDetailPage> with AfterLayoutMixin {
  int stepIndex = 0;
  bool isLoading = false;
  bool isLoadingPage = true;
  Sales data = Sales();
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      data = await SalesApi().getSaleDetailData(widget.id);

      stepIndex = _getStepIndex(data.requestStatus);

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

  int _getStepIndex(String? status) {
    switch (status) {
      case "NEW":
        return 0;
      case "SALES_APPROVED":
        return 1;
      case "FINANCE_APPROVED":
        return 2;
      case "DONE":
        return 3;
      case "REJECTED":
        return 4;

      default:
        return 0;
    }
  }

  List<TimelineStepData> buildSteps(List<RequestStatuses> statuses) {
    final Map<String, RequestStatuses> statusMap = {
      for (var s in statuses) s.status!: s,
    };
    return [
      TimelineStepData(
        title: 'Хүсэлт илгээсэн',
        subtitle: 'Татан авах хүсэлт илгээгдлээ.',
        time: statusMap["NEW"] != null
            ? DateFormat(
                'yyyy/MM/dd HH:mm',
              ).format(DateTime.parse(statusMap["NEW"]!.date!).toLocal())
            : "-",
      ),
      TimelineStepData(
        title: 'Хүсэлт зөвшөөрсөн',
        subtitle: 'Татан авах хүсэлт зөвшөөрсөн.',
        time: statusMap["SALES_APPROVED"] != null
            ? DateFormat('yyyy/MM/dd HH:mm').format(
                DateTime.parse(statusMap["SALES_APPROVED"]!.date!).toLocal(),
              )
            : "-",
      ),
      TimelineStepData(
        title: 'Захиалгын төлбөр',
        subtitle: 'Татан авалтын төлбөр төлөгдсөн байна.',
        time: statusMap["FINANCE_APPROVED"] != null
            ? DateFormat('yyyy/MM/dd HH:mm').format(
                DateTime.parse(statusMap["FINANCE_APPROVED"]!.date!).toLocal(),
              )
            : "-",
      ),
      TimelineStepData(
        title: 'Хүлээн авсан',
        subtitle: 'Түлшийг хүлээн авах.',
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
    data = await SalesApi().getSaleDetailData(widget.id);
    setState(() {
      stepIndex = _getStepIndex(data.requestStatus);
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
          'Татан авалт дэлгэрэнгүй',
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
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
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
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svg/car.svg',
                                              ),
                                              SizedBox(width: 8),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 4,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            100,
                                                          ),
                                                      color:
                                                          data.requestStatus ==
                                                              "REJECTED"
                                                          ? redColor
                                                                .withOpacity(
                                                                  0.1,
                                                                )
                                                          : data.requestStatus ==
                                                                "DONE"
                                                          ? green.withOpacity(
                                                              0.1,
                                                            )
                                                          : data.requestStatus ==
                                                                "NEW"
                                                          ? primary.withOpacity(
                                                              0.1,
                                                            )
                                                          : orange.withOpacity(
                                                              0.1,
                                                            ),
                                                    ),
                                                    child: Text(
                                                      '${data.requestStatus == "NEW"
                                                          ? 'Хүсэлт илгээсэн'
                                                          : data.requestStatus == "DONE"
                                                          ? 'Хүлээн авах'
                                                          : data.requestStatus == "REJECTED"
                                                          ? 'Татгалзсан'
                                                          : data.requestStatus == "FINANCE_APPROVED"
                                                          ? 'Төлбөр төлөгдсөн'
                                                          : data.requestStatus == "SALES_APPROVED"
                                                          ? 'Төлбөр хүлээгдэж байна'
                                                          : '-'}',
                                                      style: TextStyle(
                                                        color:
                                                            data.requestStatus ==
                                                                "REJECTED"
                                                            ? redColor
                                                            : data.requestStatus ==
                                                                  "DONE"
                                                            ? green
                                                            : data.requestStatus ==
                                                                  "NEW"
                                                            ? primary
                                                            : orange,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    '${data.totalCount ?? '-'} ш',
                                                    style: TextStyle(
                                                      color: black950,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Захиалга илгээсэн огноо',
                                                  style: TextStyle(
                                                    color: black600,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  textAlign: TextAlign.end,
                                                ),
                                                SizedBox(height: 2),
                                                Text(
                                                  textAlign: TextAlign.end,

                                                  '${DateFormat('yyyy/MM/dd HH:mm').format(DateTime.parse(data.createdAt!).toLocal())}',
                                                  style: TextStyle(
                                                    color: black950,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    stepIndex != 4
                                        ? Column(
                                            children: [
                                              SizedBox(height: 16),
                                              OrderTimeline(
                                                steps: buildSteps(
                                                  data.requestStatuses!,
                                                ),
                                                stepIndex: stepIndex,
                                                orange: orange,
                                                white50: white50,
                                                white100: white100,
                                                black950: black950,
                                                black600: black600,
                                                black400: black400,
                                              ),
                                            ],
                                          )
                                        : SizedBox.shrink(),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: white,
                                      ),
                                      padding: EdgeInsets.all(16),
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
                                                // '${widget.data.quantity ?? '-'} ш',
                                                // '123',
                                                '${data.totalCount ?? '-'} ш',
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
                                                '- ш',
                                                style: TextStyle(
                                                  color: black950,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
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
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Column(
                                            children: data.requestProduct!
                                                .map(
                                                  (item) => Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            '${item.product?.name}',
                                                            style: TextStyle(
                                                              color: black800,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${item.totalCount} x ${Utils().formatCurrencyDouble(item.product?.price?.toDouble() ?? 0)}₮',
                                                            style: TextStyle(
                                                              color: black950,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                data.requestStatus == "SALES_APPROVED"
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
                                Text(
                                  'Нийт дүн:',
                                  style: TextStyle(
                                    color: black950,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '${Utils().formatCurrencyDouble(data.totalAmount?.toDouble() ?? 0)}₮',
                                  style: TextStyle(
                                    color: orange,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                            SalePayment.routeName,
                                            arguments: SalePaymentArguments(
                                              payAmount: data.totalAmount!
                                                  .toInt(),
                                              id: data.id!,
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
                                                      'Төлбөр төлөх',
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

  final int stepIndex;

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
