import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';

class NotifyPage extends StatefulWidget {
  static const routeName = "NotifyPage";
  const NotifyPage({super.key});

  @override
  State<NotifyPage> createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
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
          'Мэдэгдэл',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [1]
              .map(
                (test) => Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: white,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/svg/notify_detail.svg'),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Түлшний үлдэгдэл дуусаж байна.',
                                style: TextStyle(
                                  color: zero,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Үлдэгдэл: - ш',
                                style: TextStyle(
                                  color: black600,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
