import 'package:cgm_calendar/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CellDateTimePicker extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final Function(DateTime) onDateChanged;
  final Function(DateTime) onTimeChanged;
  bool isNotRightTime;
  Function()? onClick;

  CellDateTimePicker({
    Key? key,
    required this.title,
    required this.date,
    required this.time,
    required this.onDateChanged,
    required this.onTimeChanged,
    this.isNotRightTime = false,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  if (onClick != null) {
                    onClick!();
                  }
                  showModalBottomSheet(
                    context: context,
                    builder: ((context) => CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: DateTime.parse(
                              date.replaceAll(RegExp(r'/'), "-")),
                          minimumYear: Global.oldYears.last.year,
                          maximumYear: Global.newYears.last.year,
                          onDateTimeChanged: ((value) => onDateChanged(value)),
                        )),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: 5.h,
                    bottom: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: EdgeInsets.fromLTRB(
                    10.w,
                    6.h,
                    10.w,
                    6.h,
                  ),
                  child: Text(
                    date,
                    style: TextStyle(
                      color: isNotRightTime ? Colors.grey : Colors.black,
                      decoration:
                          isNotRightTime ? TextDecoration.lineThrough : null,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (onClick != null) {
                    onClick!();
                  }
                  showModalBottomSheet(
                    context: context,
                    builder: ((context) => CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          initialDateTime: DateTime.parse(
                              "${date.replaceAll(RegExp(r'/'), "-")} $time:00"),
                          use24hFormat: true,
                          onDateTimeChanged: ((value) => onTimeChanged(value)),
                        )),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: 5.h,
                    bottom: 5.h,
                    left: 5.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: EdgeInsets.fromLTRB(
                    10.w,
                    6.h,
                    10.w,
                    6.h,
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      color: isNotRightTime ? Colors.grey : Colors.black,
                      decoration:
                          isNotRightTime ? TextDecoration.lineThrough : null,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
