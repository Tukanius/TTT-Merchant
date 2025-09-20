// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ttt_merchant_flutter/components/ui/color.dart';

class CustomTableCalendar extends StatefulWidget {
  final Function(DateTime? start, DateTime? end) onDateSelected;
  const CustomTableCalendar({super.key, required this.onDateSelected});

  @override
  State<CustomTableCalendar> createState() => _CustomTableCalendarState();
}

class _CustomTableCalendarState extends State<CustomTableCalendar> {
  bool isLoading = false;
  DateTime? rangeStart;
  DateTime? rangeEnd;
  DateTime focusedDay = DateTime.now();
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOn;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        color: white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8),
          Container(
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: white200,
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: TableCalendar(
              shouldFillViewport: true,
              firstDay: DateTime.now().subtract(const Duration(days: 365)),
              lastDay: DateTime.now().add(const Duration(days: 365)),
              focusedDay: focusedDay,
              rangeSelectionMode: rangeSelectionMode,
              rangeStartDay: rangeStart,
              rangeEndDay: rangeEnd,
              onRangeSelected: (start, end, focus) {
                setState(() {
                  rangeStart = start;
                  rangeEnd = end;
                  focusedDay = focus;
                  rangeSelectionMode = RangeSelectionMode.toggledOn;
                });
              },
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextFormatter: (date, locale) =>
                    "${date.year} он ${date.month} сар",
                titleTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: black950,
                ),
                leftChevronIcon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: orange,
                ),
                rightChevronIcon: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: orange,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                dowTextFormatter: (date, locale) {
                  const days = ['Да', 'Мя', 'Лх', 'Пү', 'Ба', 'Бя', 'Ня'];
                  return days[date.weekday - 1];
                },
                weekdayStyle: TextStyle(
                  color: black400,
                  // fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                weekendStyle: TextStyle(
                  color: black400,
                  // fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: orange.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                todayTextStyle: TextStyle(
                  color: orange,
                  fontWeight: FontWeight.bold,
                ),
                selectedTextStyle: TextStyle(
                  color: orange,
                  fontWeight: FontWeight.bold,
                ),
                rangeStartDecoration: BoxDecoration(
                  color: orange.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                rangeStartTextStyle: TextStyle(
                  color: orange,
                  fontWeight: FontWeight.bold,
                ),
                rangeEndDecoration: BoxDecoration(
                  color: orange.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                rangeEndTextStyle: TextStyle(
                  color: orange,
                  fontWeight: FontWeight.bold,
                ),
                rangeHighlightColor: orange.withOpacity(0.12),
                withinRangeDecoration: BoxDecoration(color: transparent),
                withinRangeTextStyle: TextStyle(
                  color: orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(children: [
            
            ],
          ),
          SizedBox(height: 16),
          Row(children: [

            ],
          ),
          Row(
            children: [
              SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.onDateSelected(null, null);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: white100),
                      color: white,
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
                                        child: CircularProgressIndicator(
                                          color: white,
                                          strokeWidth: 2.5,
                                        ),
                                      )
                                    : Center(
                                        child: CupertinoActivityIndicator(
                                          color: white,
                                        ),
                                      ),
                              )
                            : Text(
                                'Цэвэрлэх',
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
              ),
              SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.onDateSelected(rangeStart, rangeEnd);
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
                                        child: CircularProgressIndicator(
                                          color: white,
                                          strokeWidth: 2.5,
                                        ),
                                      )
                                    : Center(
                                        child: CupertinoActivityIndicator(
                                          color: white,
                                        ),
                                      ),
                              )
                            : Text(
                                'Сонгох',
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
              SizedBox(width: 16),
            ],
          ),
          SizedBox(
            height: Platform.isIOS
                ? MediaQuery.of(context).padding.bottom
                : MediaQuery.of(context).padding.bottom + 16,
          ),
        ],
      ),
    );
  }
}
