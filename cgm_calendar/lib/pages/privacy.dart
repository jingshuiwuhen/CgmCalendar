import 'package:cgm_calendar/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  String _htmlStr = "";

  @override
  void initState() {
    super.initState();
    readHtmlFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        elevation: 1,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            10.w,
            10.h,
            10.w,
            10.h,
          ),
          child: SingleChildScrollView(
            child: HtmlWidget(_htmlStr),
          ),
        ),
      ),
    );
  }

  Future<void> readHtmlFile() async {
    String url = "assets/htmls/privacy_en.html";
    if (Global.localeStr().compareTo("zh_CN") == 0) {
      url = "assets/htmls/privacy_zh.html";
    } else if (Global.localeStr().compareTo("ja_JP") == 0) {
      url = "assets/htmls/privacy_jp.html";
    }
    _htmlStr = await rootBundle.loadString(url);
    setState(() {
      _htmlStr;
    });
  }
}
