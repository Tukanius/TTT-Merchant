// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/src/home_page/purchase_request_page.dart';
import 'package:ttt_merchant_flutter/src/profile_page/purchase_request_detail_page.dart';

class PurchaseRequestHistoryPage extends StatefulWidget {
  static const routeName = "PurchaseRequestHistoryPage";
  const PurchaseRequestHistoryPage({super.key});

  @override
  State<PurchaseRequestHistoryPage> createState() =>
      _PurchaseRequestHistoryPageState();
}

class _PurchaseRequestHistoryPageState
    extends State<PurchaseRequestHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: false,
        elevation: 1,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Text(
          'ТАТАН АВАХ ХҮСЭЛТ',
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
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushNamed(PurchaseRequestPage.routeName);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: white,
                    border: Border.all(color: white100),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svg/download.svg'),
                      SizedBox(width: 6),
                      Text(
                        'Таталт хийх',
                        style: TextStyle(
                          color: black950,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
        ],
      ),
      backgroundColor: white50,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [1, 2, 3]
                .map(
                  (qwe) => Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: white,
                          border: Border.all(color: white100),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/svg/ttt_mini.svg'),
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
                                    Text(
                                      '750 КГ',
                                      style: TextStyle(
                                        color: black600,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Container(
                                      width: 2,
                                      height: 2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: black600,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '120 шуудай',
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
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/svg/car.svg'),
                                    SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                            color: orange.withOpacity(0.1),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          child: Text(
                                            'Захиалга баталгаажсан',
                                            style: TextStyle(
                                              color: orange,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '110 шуудай нүүрс',
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
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

                                        '2025/08/29 15:30',
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
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 7,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: orange,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Container(
                                    height: 7,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: white100,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 4),

                                Expanded(
                                  child: Container(
                                    height: 7,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: white100,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 4),

                                Expanded(
                                  child: Container(
                                    height: 7,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: white100,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  PurchaseRequestDetailPage.routeName,
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
                                    Text(
                                      'Дэлгэрэнгүй',
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
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
