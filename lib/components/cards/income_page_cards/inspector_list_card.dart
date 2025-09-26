// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/inspector_models/inspector_model.dart';

class IncomeDoneHistoryCard extends StatefulWidget {
  final InspectorModel data;
  final bool isExtended;

  const IncomeDoneHistoryCard({
    super.key,
    required this.data,
    required this.isExtended,
  });

  @override
  State<IncomeDoneHistoryCard> createState() => _IncomeDoneHistoryCardState();
}

class _IncomeDoneHistoryCardState extends State<IncomeDoneHistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        border: Border(bottom: BorderSide(color: white100)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // SvgPicture.asset(
                    //   widget.data.inOutType == "IN"
                    //       ? 'assets/svg/in.svg'
                    //       : 'assets/svg/out.svg',
                    // ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.data.quantity ?? '0'} ширхэг',
                          style: TextStyle(
                            color: black950,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 2),
                        // Row(
                        //   children: [
                        //     Container(
                        //       width: 4,
                        //       height: 4,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(100),
                        //         color: widget.data.inOutType == "IN"
                        //             ? green
                        //             : redColor,
                        //       ),
                        //     ),
                        //     Text(
                        //       ' ${widget.data.inOutType == "IN" ? 'Орлого' : 'Зарлага'}',
                        //       style: TextStyle(
                        //         color: widget.data.inOutType == "IN"
                        //             ? green
                        //             : redColor,
                        //         fontSize: 12,
                        //         fontWeight: FontWeight.w400,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${DateFormat('yyyy/MM/dd HH:mm').format(DateTime.parse(widget.data.createdAt!).toLocal())}',
                      style: TextStyle(
                        color: black400,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      // '${widget.data.vehiclePlateNo?.toUpperCase() ?? '-'}',
                      '123',
                      style: TextStyle(
                        color: orange,
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
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: white50,
                border: Border(
                  right: BorderSide(color: white100),
                  left: BorderSide(color: white100),
                ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        '${widget.data.quantity} ш',
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
                        'Баталгаажсан тоо:',
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Илгээх агуулах:',
                  //       style: TextStyle(
                  //         color: black800,
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //     Text(
                  //       widget.data.type == "IN"
                  //           ? '${widget.data.toInventory ?? '-'}'
                  //           : '${widget.data.fromInventory ?? '-'}',

                  //       style: TextStyle(
                  //         color: black950,
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 4),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Хүлээн авах цэг:',
                  //       style: TextStyle(
                  //         color: black800,
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //     Text(
                  //       widget.data.type == "OUT"
                  //           ? '${widget.data.toInventory ?? '-'}'
                  //           : '${widget.data.fromInventory ?? '-'}',
                  //       style: TextStyle(
                  //         color: black950,
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  // Column(
                  //   children: widget.data.products!
                  //       .map(
                  //         (item) => Column(
                  //           children: [
                  //             Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text(
                  //                   '${item.name ?? '-'}:',
                  //                   style: TextStyle(
                  //                     color: black800,
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w500,
                  //                   ),
                  //                 ),
                  //                 Text(
                  //                   '${item.quantity} x ${Utils().formatCurrencyDouble(item.price?.toDouble() ?? 0)}₮',
                  //                   style: TextStyle(
                  //                     color: black950,
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w600,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //             SizedBox(height: 2),
                  //           ],
                  //         ),
                  //       )
                  //       .toList(),
                  // ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
