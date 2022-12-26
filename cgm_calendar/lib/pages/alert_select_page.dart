import 'package:cgm_calendar/generated/l10n.dart';
import 'package:cgm_calendar/pages/common_string.dart';
import 'package:cgm_calendar/view_models/set_schedule_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertSelectPage extends StatelessWidget {
  final AlertType alertType;
  const AlertSelectPage({
    super.key,
    required this.alertType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.red,
          ),
        ),
        title: Text(
          S.of(context).alert,
          style: TextStyle(
            fontSize: 24.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        height: double.infinity,
        width: double.infinity,
        color: Colors.grey[200],
        child: Container(
          width: 0.9.sw,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          child: ListView.separated(
            itemCount: AlertType.values.length,
            separatorBuilder: (BuildContext context, int index) => Divider(
              color: Colors.grey[200],
              height: 2.h,
              indent: 10.w,
            ),
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () => Navigator.pop(context, AlertType.values[index]),
              child: Padding(
                padding: EdgeInsets.fromLTRB(5.w, 5.h, 5.w, 5.h),
                child: Row(
                  children: [
                    Text(
                      CommonString.getAlertStr(
                          context, AlertType.values[index]),
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Visibility(
                        visible: alertType == AlertType.values[index],
                        child: Icon(
                          Icons.check_rounded,
                          color: Colors.redAccent,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
