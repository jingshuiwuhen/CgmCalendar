import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Inputpage extends StatelessWidget {
  const Inputpage({Key? key}) : super(key: key);

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
          "test",
          style: TextStyle(
            fontSize: 24.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 40.h,
        ),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
              ),
              controller: controller,
              maxLines: 1,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                isDense: true,
                errorText: errorText,
                errorStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(12),
                  color: Colors.red,
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey,
                ),
              ),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
