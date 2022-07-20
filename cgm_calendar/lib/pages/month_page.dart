import 'package:cgm_calendar/model/month_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MonthPage extends StatelessWidget {
  MonthModel monthModel;

  MonthPage({Key? key, required this.monthModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
        flexibleSpace: GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          primary: false,
          children: _headWeekdayWidgets(),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
            )
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.calendar_today,
                  color: Colors.red,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu,
                  color: Colors.red,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.info_outline,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(),
    );
  }

  List<Widget> _headWeekdayWidgets() {
    List<Widget> target = List.empty(growable: true);
    for (int i = 0; i < 7; i++) {
      target.add(Text(
        _weekDayName(i),
        style: TextStyle(color: Colors.black, fontSize: 10.sp),
      ));
    }
    return target;
  }

  String _weekDayName(int weekday) {
    switch (weekday) {
      case 0:
        return "日";
      case 1:
        return "一";
      case 2:
        return "二";
      case 3:
        return "三";
      case 4:
        return "四";
      case 5:
        return "五";
      default:
        return "六";
    }
  }
}
