// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/sales_models/sales_model.dart';
import 'package:ttt_merchant_flutter/src/sales_list_page/sale_detail_page.dart';
import 'package:ttt_merchant_flutter/utils/utils.dart';

class SaleHistoryCard extends StatefulWidget {
  final bool isExtended;
  final Sales data;
  const SaleHistoryCard({
    super.key,
    required this.isExtended,
    required this.data,
  });

  @override
  State<SaleHistoryCard> createState() => _SaleHistoryCardState();
}

class _SaleHistoryCardState extends State<SaleHistoryCard> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      decoration: BoxDecoration(
        color: white,
        border: Border(bottom: BorderSide(color: white100)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.data.totalCount ?? 0} Ширхэг Түлш',
                      style: TextStyle(
                        color: black950,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 2),
                    Text(
                      '${DateFormat('yyyy/MM/dd HH:mm').format(DateTime.parse(widget.data.createdAt!).toLocal())}',
                      style: TextStyle(
                        color: black400,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: green.withOpacity(0.1),
                      ),
                      child: Text(
                        '${widget.data.requestType == "NEW"
                            ? 'Шинэ'
                            : widget.data.requestType == "DONE"
                            ? 'Тооцоо хийгдсэн'
                            : widget.data.requestType == "REJECTED"
                            ? 'Татгалзсан'
                            : widget.data.requestType == "APPROVED"
                            ? 'Зөвшөөрсөн'
                            : '-'}',
                        style: TextStyle(
                          color: green,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${Utils().formatCurrencyDouble(widget.data.totalAmount?.toDouble() ?? 0)}₮',
                      style: TextStyle(
                        color: black950,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (widget.isExtended) ...[
            Container(
              decoration: BoxDecoration(
                color: white50,
                border: Border(
                  right: BorderSide(color: white100),
                  left: BorderSide(color: white100),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          '${widget.data.code}',
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Захиалсан цэг:',
                          style: TextStyle(
                            color: black800,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${widget.data.distributor != null ? widget.data.distributor?.name : '-'}',
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Захиалсан ажилтан:',
                          style: TextStyle(
                            color: black800,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${widget.data.user?.firstName ?? '-'}',
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
                      width: mediaQuery.size.width,
                      height: 1,
                      color: black200,
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Захиалсан бараа:',
                      style: TextStyle(
                        color: black400,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8),
                    Column(
                      children: widget.data.requestProduct!
                          .map(
                            (item) => Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${item.product?.name}:',
                                      style: TextStyle(
                                        color: black800,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${item.totalCount} x ',
                                          style: TextStyle(
                                            color: black950,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '${Utils().formatCurrencyDouble(item.product?.price?.toDouble() ?? 0)}₮',
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
                                SizedBox(height: 2),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final boxWidth = constraints.constrainWidth();
                              const dashWidth = 20.0;
                              const dashSpace = 6.0;
                              final dashCount =
                                  (boxWidth / (dashWidth + dashSpace)).floor();

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(dashCount, (_) {
                                  return Container(
                                    width: dashWidth,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      color: orange,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              // onSubmit();
                              Navigator.of(context).pushNamed(
                                SaleDetailPage.routeName,
                                arguments: SaleDetailPageArguments(
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                          'Дэлгэрэнгүй',
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
                    SizedBox(height: 14),
                    Text(
                      'Нийт дүн:',
                      style: TextStyle(
                        color: black950,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '${Utils().formatCurrencyDouble(widget.data.totalAmount?.toDouble() ?? 0)}₮',
                      style: TextStyle(
                        color: orange,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),

      //  ExpansionTile(
      //   enabled: true,

      //   tilePadding: EdgeInsets.symmetric(
      //     horizontal: 14,
      //     vertical: 0,
      //   ),
      //   backgroundColor: white,
      //   collapsedBackgroundColor: white,
      //   title:
      //   trailing:
      //   children: [],
      // ),
    );
  }
}
