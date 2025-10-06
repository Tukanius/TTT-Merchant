import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';
import 'package:ttt_merchant_flutter/models/card_models/wallet_transaction.dart';
import 'package:ttt_merchant_flutter/utils/utils.dart';

class WalletHistoryCard extends StatefulWidget {
  final WalletTransaction data;
  const WalletHistoryCard({super.key, required this.data});

  @override
  State<WalletHistoryCard> createState() => _WalletHistoryCardState();
}

class _WalletHistoryCardState extends State<WalletHistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: black100)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                widget.data.type == "DEBIT"
                    ? 'assets/svg/debit.svg'
                    : widget.data.type == "CREDIT"
                    ? 'assets/svg/credit.svg'
                    : 'assets/svg/coaltype.svg',
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${DateFormat('yyyy/MM/dd HH:mm').format(DateTime.parse(widget.data.createdAt!).toLocal())}',
                    style: TextStyle(
                      color: black400,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '${widget.data.description}',
                    style: TextStyle(
                      color: black950,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Үлдэгдэл: ${Utils().formatCurrencyDouble(widget.data.balanceAfter?.toDouble() ?? 0)}₮',
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
            '${widget.data.type == "DEBIT" ? '-' : '+'} ${Utils().formatCurrencyDouble(widget.data.amount?.toDouble() ?? 0)}₮',
            style: TextStyle(
              color: widget.data.type == "DEBIT" ? redWallet : greenWallet,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
