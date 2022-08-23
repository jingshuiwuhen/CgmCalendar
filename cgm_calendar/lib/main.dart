import 'package:cgm_calendar/add_schedule_helper.dart';
import 'package:cgm_calendar/db/db_manager.dart';
import 'package:cgm_calendar/db/schedule_db_model.dart';
import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/pages/year_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sprintf/sprintf.dart';

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
      DateTime now = DateTime.now();
      await DBManager.db.deleteTimeOutSchedules(int.parse(
          "${now.year}${sprintf("%02i", [now.month])}${sprintf("%02i", [
            now.day
          ])}${sprintf("%02i", [now.hour])}${sprintf("%02i", [now.minute])}"));
      List<ScheduleDBModel> models = await DBManager.db.getAll();
      for (ScheduleDBModel model in models) {
        AddScheduleHelper.addToCalendar(model);
      }
      runApp(const CgmCalanderApp());
    },
  );
}

class CgmCalanderApp extends StatelessWidget {
  const CgmCalanderApp({Key? key}) : super(key: key);

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
        builder: (context, child) => YearPage(),
      ),
    );
  }
}
