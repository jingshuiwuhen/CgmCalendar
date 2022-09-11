import 'package:cgm_calendar/add_schedule_helper.dart';
import 'package:cgm_calendar/app_shared_pref.dart';
import 'package:cgm_calendar/db/db_manager.dart';
import 'package:cgm_calendar/db/schedule_db_model.dart';
import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/models/year_model.dart';
import 'package:cgm_calendar/pages/welcome_page.dart';
import 'package:cgm_calendar/pages/year_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'generated/l10n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then(
    (_) async {
      Global.init();
      Global.info = await PackageInfo.fromPlatform();

      YearModel oldestYear = Global.oldYears.last;
      await DBManager.db
          .deleteTimeOutSchedules(int.parse("${oldestYear.year}01010000"));
      List<ScheduleDBModel> models = await DBManager.db.getAll();
      for (ScheduleDBModel model in models) {
        AddScheduleHelper.addToCalendar(model);
      }

      String token = await AppSharedPref.loadAccessToken();
      runApp(
        CgmCalanderApp(
          token: token,
        ),
      );
    },
  );
}

class CgmCalanderApp extends StatelessWidget {
  final String token;
  const CgmCalanderApp({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: ScreenUtilInit(
        designSize: const Size(414, 896),
        builder: (context, child) => WelcomePage(
          token: token,
        ),
      ),
    );
  }
}
