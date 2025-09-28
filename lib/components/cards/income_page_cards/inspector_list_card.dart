// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/inspector_models/inspector_model.dart';

class InspectorListCard extends StatefulWidget {
  final InspectorModel data;
  final bool isExtended;

  const InspectorListCard({
    super.key,
    required this.data,
    required this.isExtended,
  });

  @override
  State<InspectorListCard> createState() => _InspectorListCardState();
}

class _InspectorListCardState extends State<InspectorListCard> {
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.data.vehiclePlateNo?.toUpperCase() ?? '0'}',
                      style: TextStyle(
                        color: black950,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2),
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: widget.data.receiptStatus == "CANCELED"
                            ? redColor.withOpacity(0.1)
                            : widget.data.receiptStatus == "NEW" ||
                                  widget.data.receiptStatus == "PENDING" ||
                                  widget.data.receiptStatus ==
                                      "FINANCE_APPROVED"
                            ? orange.withOpacity(0.1)
                            : green.withOpacity(0.1),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                      child: Text(
                        '${widget.data.receiptStatus == "NEW"
                            ? 'Шинэ'
                            : widget.data.receiptStatus == "PENDING"
                            ? 'Хүлээгдэж буй'
                            : widget.data.receiptStatus == "FACTORY_APPROVED"
                            ? 'Баталгаажсан'
                            : widget.data.receiptStatus == "FINANCE_APPROVED"
                            ? 'Төлбөр баталгаажсан'
                            : widget.data.receiptStatus == "CANCELED"
                            ? 'Татгазсан'
                            : widget.data.receiptStatus == "DONE"
                            ? 'Амжилттай'
                            : "-"}',
                        style: TextStyle(
                          color: widget.data.receiptStatus == "CANCELED"
                              ? redColor
                              : widget.data.receiptStatus == "NEW" ||
                                    widget.data.receiptStatus == "PENDING" ||
                                    widget.data.receiptStatus ==
                                        "FINANCE_APPROVED"
                              ? orange
                              : green,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${widget.data.orderProductCount ?? '-'}Тонн',
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
                        'Код:',
                        style: TextStyle(
                          color: black800,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${widget.data.contractNo}',
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
                        'Ачаатай жин:',
                        style: TextStyle(
                          color: black800,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${widget.data.ladedWeight ?? '#'}',
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
                        'Ачаагүй жин:',
                        style: TextStyle(
                          color: black800,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${widget.data.unladedWeight ?? '-'}',
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
                        'Цэвэр жин:',
                        style: TextStyle(
                          color: black800,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${widget.data.netWeight ?? '-'}',
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
                  // SizedBox(height: 14),
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   height: 1,
                  //   color: white200,
                  // ),
                  // SizedBox(height: 14),
                  // Text(
                  //   'Тээврийн мэдээлэл',
                  //   style: TextStyle(
                  //     color: black400,
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w400,
                  //   ),
                  // ),
                  // SizedBox(height: 8),
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
                  // SizedBox(height: 4),
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
                  // SizedBox(height: 14),
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   height: 1,
                  //   color: white200,
                  // ),
                  // SizedBox(height: 14),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Захиалсан бараа',
                  //       style: TextStyle(
                  //         color: black400,
                  //         fontSize: 12,
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //     ),
                  //     // Text(
                  //     //   '20,000.00₮',
                  //     //   style: TextStyle(
                  //     //     color: black950,
                  //     //     fontSize: 16,
                  //     //     fontWeight: FontWeight.w600,
                  //     //   ),
                  //     // ),
                  //   ],
                  // ),
                  // SizedBox(height: 8),
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
