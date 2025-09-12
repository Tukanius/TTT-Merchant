// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/income_models/income_model.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/income_confirm_page.dart';
import 'package:ttt_merchant_flutter/utils/utils.dart';

class IncomeDetailPageArguments {
  final Income data;

  IncomeDetailPageArguments({required this.data});
}

class IncomeDetailPage extends StatefulWidget {
  final Income data;
  static const routeName = "IncomeDetailPage";
  const IncomeDetailPage({super.key, required this.data});

  @override
  State<IncomeDetailPage> createState() => _IncomeDetailPageState();
}

class _IncomeDetailPageState extends State<IncomeDetailPage> {
  int stepIndex = 2;
  bool isLoading = false;
  final steps = [
    TimelineStepData(
      title: 'Захиалга баталгаажсан',
      subtitle: 'Тээврийн компанид руу шилжүүлсэн',
      time: '2025/08/20 14:00',
    ),
    TimelineStepData(
      title: 'Тээвэрлэлт',
      subtitle: 'Тээврийн хэрэгсэл ачааг авахаар очиж байна.',
      time: '2025/08/20 14:10',
    ),
    TimelineStepData(
      title: 'Агуулахаас гарсан',
      subtitle: 'Захиалга тээвэрлэлтэд гарсан.',
      time: '2025/08/20 15:00',
    ),
    TimelineStepData(
      title: 'Хүлээн авсан',
      subtitle: 'Түлшийг хүлээлгэн өгсөн.',
      time: '2025/08/20 16:30',
    ),
  ];
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
      body: Stack(
        children: [
          SingleChildScrollView(
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
                                  Row(
                                    children: [
                                      // // Text(
                                      // //   '750 КГ',
                                      // //   style: TextStyle(
                                      // //     color: black600,
                                      // //     fontSize: 12,
                                      // //     fontWeight: FontWeight.w400,
                                      // //   ),
                                      // // ),
                                      // // SizedBox(width: 4),
                                      // Container(
                                      //   width: 2,
                                      //   height: 2,
                                      //   decoration: BoxDecoration(
                                      //     borderRadius: BorderRadius.circular(12),
                                      //     color: black600,
                                      //   ),
                                      // ),
                                      // SizedBox(width: 4),
                                      Text(
                                        '${widget.data.quantity ?? '-'} ш',
                                        style: TextStyle(
                                          color: black950,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset('assets/svg/car.svg'),
                                      SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //                           Container(
                                          //   decoration: BoxDecoration(
                                          //     borderRadius: BorderRadius.circular(100),
                                          //     color: green.withOpacity(0.1),
                                          //   ),
                                          //   padding: EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                                          //   child: Text(
                                          //     '${widget.data.transportStatus}',
                                          //     style: TextStyle(
                                          //       color: green,
                                          //       fontSize: 10,
                                          //       fontWeight: FontWeight.w500,
                                          //     ),
                                          //   ),
                                          // ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color:
                                                  widget.data.inOutType == "IN"
                                                  ? green.withOpacity(0.1)
                                                  : widget.data.inOutType ==
                                                        "OUT"
                                                  ? redColor.withOpacity(0.1)
                                                  : green.withOpacity(0.1),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 9,
                                              vertical: 4,
                                            ),
                                            child: Text(
                                              '${widget.data.inOutType == "IN"
                                                  ? "Орлого"
                                                  : widget.data.inOutType == "OUT"
                                                  ? "Зарлага"
                                                  : '${widget.data.transportStatus}'}',
                                              style: TextStyle(
                                                color:
                                                    widget.data.inOutType ==
                                                        "IN"
                                                    ? green
                                                    : widget.data.inOutType ==
                                                          "OUT"
                                                    ? redColor
                                                    : green,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          // Container(
                                          //   decoration: BoxDecoration(
                                          //     borderRadius:
                                          //         BorderRadius.circular(100),
                                          //     color: orange.withOpacity(0.1),
                                          //   ),
                                          //   padding: EdgeInsets.symmetric(
                                          //     horizontal: 8,
                                          //     vertical: 4,
                                          //   ),
                                          //   child: Text(
                                          //     '${widget.data.transportStatus}',
                                          //     style: TextStyle(
                                          //       color: orange,
                                          //       fontSize: 12,
                                          //       fontWeight: FontWeight.w400,
                                          //     ),
                                          //   ),
                                          // ),
                                          SizedBox(height: 4),
                                          Text(
                                            '${widget.data.quantity ?? '-'} ш',
                                            style: TextStyle(
                                              color: black950,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
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
                                          'Агуулхаас гарсан огноо',
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

                                          '${DateFormat('yyyy/MM/dd HH:mm').format(DateTime.parse(widget.data.inOutStatusDate!).toLocal())}',
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
                            ],
                          ),
                        ),
                        // OrderTimeline(
                        //   steps: steps,
                        //   stepIndex: 0,
                        //   orange: orange,
                        //   white50: white50,
                        //   white100: white100,
                        //   black950: black950,
                        //   black600: black600,
                        //   black400: black400,
                        // ),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: white,
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                    '${DateFormat('yyyy/MM/dd HH:mm').format(DateTime.parse(widget.data.createdAt!).toLocal())}',
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
                                    '${widget.data.code ?? '#'}',
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
                                    '${widget.data.quantity ?? '-'} ш',
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
                                    'Захиалга баталсан:',
                                    style: TextStyle(
                                      color: black800,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    // 'Б.Эрдэнэ',
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
                                width: MediaQuery.of(context).size.width,
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
                                    '${widget.data.transportCompany ?? '-'}',
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
                                    '${widget.data.vehiclePlateNo ?? '-'}',
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
                              //       '${widget.data}',
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
                                width: MediaQuery.of(context).size.width,
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
                              Column(
                                children: widget.data.products!
                                    .map(
                                      (item) => Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${item.product}',
                                                style: TextStyle(
                                                  color: black800,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                '${item.quantity} x ${Utils().formatCurrencyDouble(item.price?.toDouble() ?? 0)}₮',
                                                style: TextStyle(
                                                  color: black950,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
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
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       '1ш: 5,000₮',
                              //       style: TextStyle(
                              //         color: black800,
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.w400,
                              //       ),
                              //     ),
                              //     Text(
                              //       '400x5,000₮',
                              //       style: TextStyle(
                              //         color: black800,
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.w400,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 150),
                ],
              ),
            ),
          ),
          widget.data.verifiedStatus == "VERIFIED"
              ? SizedBox()
              : Align(
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
                            '${Utils().formatCurrencyDouble(widget.data.totalAmount?.toDouble() ?? 0)}₮',
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
                                    // onSubmit();
                                    Navigator.of(context).pushNamed(
                                      IncomeConfirmPage.routeName,
                                      arguments: IncomeConfirmPageArguments(
                                        data: widget.data,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
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
                                                              color: white,
                                                              strokeWidth: 2.5,
                                                            ),
                                                      )
                                                    : Center(
                                                        child:
                                                            CupertinoActivityIndicator(
                                                              color: white,
                                                            ),
                                                      ),
                                              )
                                            : Text(
                                                'Баталгаажуулах',
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
                  ),
                ),
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

class OrderTimeline extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      color: white50,
      child: Column(
        children: List.generate(steps.length, (i) {
          final item = steps[i];

          // connector-уудын логик
          final bool topActive = i == 0 ? true : (i - 1) < stepIndex;
          final bool bottomActive = i < stepIndex;

          // node-ийн icon (svg)
          final String icon = (i < stepIndex || i == stepIndex)
              ? 'assets/svg/step_access.svg' // done/current
              : 'assets/svg/step_denied.svg'; // next

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Column(
                  children: [
                    _connector(topActive ? orange : white100),
                    SvgPicture.asset(icon),
                    _connector(
                      i == 3
                          ? white50
                          : bottomActive
                          ? orange
                          : white100,
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
                          color: black950,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.subtitle,
                        style: TextStyle(
                          color: black600,
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
                    color: black400,
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
