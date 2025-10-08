// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/in_out_types.dart';
import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/income_list_model.dart';
import 'package:ttt_merchant_flutter/src/income_list_page/storeman_income/income_storeman_detail.dart';

class IncomeSalemanHistoryCard extends StatefulWidget {
  final IncomeListModel data;
  const IncomeSalemanHistoryCard({super.key, required this.data});

  @override
  State<IncomeSalemanHistoryCard> createState() =>
      _IncomeSalemanHistoryCardState();
}

class _IncomeSalemanHistoryCardState extends State<IncomeSalemanHistoryCard> {
  String getLastStatusTime(List<InOutTypes> statuses) {
    if (statuses.isEmpty)
      return "${DateFormat('yyyy/MM/dd HH:mm').format(DateTime.parse(widget.data.createdAt!).toLocal())}";
    statuses.sort(
      (a, b) => DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!)),
    );
    final latest = statuses.first;
    return DateFormat(
      'yyyy/MM/dd HH:mm',
    ).format(DateTime.parse(latest.date!).toLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: white,
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
                      '${widget.data.orderNo ?? "#0"}',
                      style: TextStyle(
                        color: black950,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${getLastStatusTime(widget.data.requestStatusHistories ?? [])}',
                      style: TextStyle(
                        color: black400,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: widget.data.requestStatus == "NEW"
                        ? primary.withOpacity(0.1)
                        : widget.data.requestStatus == "PENDING"
                        ? orange.withOpacity(0.1)
                        : green.withOpacity(0.1),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  child: Text(
                    '${widget.data.requestStatus == "NEW"
                        ? 'Хуваарилагдсан'
                        : widget.data.requestStatus == "PENDING"
                        ? 'Агуулахаас гарсан'
                        : widget.data.requestStatus == "DONE"
                        ? 'Хүлээн авсан'
                        : "-"}',
                    style: TextStyle(
                      color: widget.data.requestStatus == "NEW"
                          ? primary
                          : widget.data.requestStatus == "PENDING"
                          ? orange
                          : green,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: white50, width: 2),
                top: BorderSide(color: white50, width: 2),
              ),
              color: white,
            ),
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: white100),
                      ),
                      child: Icon(Icons.person, color: black600),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // '${widget.data.staffUser?.lastName?[0].toUpperCase() ?? ''}. ${widget.data.staffUser?.firstName ?? '-'}',
                                  '${widget.data.vehiclePlateNo?.toUpperCase() ?? '-'}',
                                  style: TextStyle(
                                    color: black950,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  '${widget.data.driverName ?? '-'}',
                                  style: TextStyle(
                                    color: black950,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 4),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Тоо ширхэг',
                                  style: TextStyle(
                                    color: black950,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  '${widget.data.quantity ?? '-'} Ш',
                                  style: TextStyle(
                                    color: orange,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 8),
                // Text(
                //   'Тээвэр төлөвлөгдсөн',
                //   style: TextStyle(
                //     color: black800,
                //     fontSize: 12,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                // SizedBox(height: 4),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(100),
                //           color: orange,
                //         ),
                //         padding: EdgeInsets.symmetric(vertical: 4),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [SvgPicture.asset('assets/svg/truck.svg')],
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: 4),
                //     Expanded(
                //       child: Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(100),
                //           color: orange,
                //         ),
                //         padding: EdgeInsets.symmetric(vertical: 4),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [SvgPicture.asset('assets/svg/truck.svg')],
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: 4),
                //     Expanded(
                //       child: Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(100),
                //           color: orange,
                //         ),
                //         padding: EdgeInsets.symmetric(vertical: 4),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [SvgPicture.asset('assets/svg/truck.svg')],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
          Container(
            color: white,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${widget.data.fromInventory?.name}',
                    style: TextStyle(
                      color: black950,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SvgPicture.asset('assets/svg/arrow_right.svg'),
                Expanded(
                  child: Text(
                    '${widget.data.toInventory?.name}',
                    style: TextStyle(
                      color: black950,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                IncomeStoremanDetail.routeName,
                arguments: IncomeStoremanDetailArguments(
                  id: widget.data.id!,
                  inOutType: widget.data.type!,
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                color: orange,
              ),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
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
        ],
      ),
    );
  }
}
