// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/purchase/purchase_model.dart';
import 'package:ttt_merchant_flutter/src/home_page/purchase_request_tools/create_payment.dart';
import 'package:ttt_merchant_flutter/utils/utils.dart';

class SaleHistoryCard extends StatefulWidget {
  final bool isExtended;
  final Purchase data;
  const SaleHistoryCard({
    super.key,
    required this.isExtended,
    required this.data,
  });

  @override
  State<SaleHistoryCard> createState() => _SaleHistoryCardState();
}

class _SaleHistoryCardState extends State<SaleHistoryCard> {
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
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        // color: green.withOpacity(0.4),
                        color: widget.data.orderStatus == "NEW"
                            ? redColor.withOpacity(0.4)
                            : widget.data.orderStatus == "DONE"
                            ? green.withOpacity(0.4)
                            : redColor.withOpacity(0.4),
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${DateFormat('yyyy/MM/dd HH:mm').format(DateTime.parse(widget.data.createdAt!).toLocal())}',
                          style: TextStyle(
                            color: black950,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'ID:${widget.data.code}',
                          style: TextStyle(
                            color: black400,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  '${(widget.data.quantity ?? 0)} ш',
                  style: TextStyle(
                    color: orange,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
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
                      'Борлуулалтын мэдээлэл',
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
                          'Борлуулсан төрөл:',
                          style: TextStyle(
                            color: black800,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${widget.data.salesType == "CARD"
                              ? 'Карт'
                              : widget.data.salesType == "QR"
                              ? 'QR'
                              : '-'}',
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
                          'Борлуулагч:',
                          style: TextStyle(
                            color: black800,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${widget.data.distributor?.name ?? '-'}',
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
                          'Худалдан авагч:',
                          style: TextStyle(
                            color: black800,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${widget.data.appUser != null ? widget.data.appUser?.firstName : '${widget.data.cardNo ?? '-'}'}',
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
                          'Борлуулалт төлөв:',
                          style: TextStyle(
                            color: black800,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${widget.data.orderStatus == "NEW"
                              ? 'Хүлээгдэж байна'
                              : widget.data.orderStatus == "DONE"
                              ? 'Амжилттай'
                              : '-'}',
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
                      'Үнийн мэдээлэл',
                      style: TextStyle(
                        color: black400,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
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
                                      '${item.name}:',
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
                      // Utils().formatTextCustom(dataReceive.fee ?? 0)
                      '${Utils().formatCurrencyDouble(widget.data.totalAmount!.toDouble())}₮',
                      style: TextStyle(
                        color: orange,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    widget.data.orderStatus == "NEW" &&
                            widget.data.invoice != null
                        ? Column(
                            children: [
                              SizedBox(height: 14),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        // onSubmit();
                                        // Navigator.of(context).pushNamed(
                                        //   QpayPaymentPage.routeName,
                                        //   arguments: QpayPaymentPageArguments(
                                        //     id: widget.data.invoice!.id!,
                                        //   ),
                                        // );
                                        await Navigator.of(context).pushNamed(
                                          CreatePayment.routeName,
                                          arguments: CreatePaymentArguments(
                                            id: widget.data.invoice!.id!,
                                            data: widget.data.products!,
                                            totalAmount:
                                                widget.data.totalAmount!,
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
                                            Text(
                                              'Төлбөр төлөх',
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
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
