import 'package:cgm_calendar/model/month_model.dart';
import 'package:cgm_calendar/widgets/cell_one_month.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MonthPage extends StatelessWidget {
  final MonthModel monthModel;

  const MonthPage({Key? key, required this.monthModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        elevation: 1,
        title: Text(
          monthModel.getYearAndMonth(),
          style: TextStyle(fontSize: 20.sp),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20.h),
          child: GridView.builder(
            itemCount: 7,
            shrinkWrap: true,
            primary: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisExtent: 20.h,
            ),
            itemBuilder: (context, index) {
              return Center(
                child: Text(
                  _weekDayName(index),
                  style: TextStyle(color: Colors.black, fontSize: 10.sp),
                ),
              );
            },
          ),
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
      body: Column(
        children: [
          CellOneMonth(
            monthModel: monthModel,
            showTitle: false,
            crossAxisSpacing: 10.h,
            fontSize: 15.sp,
            itemMargin: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
          ),
          Expanded(
              child: Container(
            color: Colors.green,
          )),
        ],
      ),
    );
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
