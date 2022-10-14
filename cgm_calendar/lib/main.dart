import 'package:cgm_calendar/global.dart';
import 'package:cgm_calendar/pages/welcome_page.dart';
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

      runApp(
        const CgmCalanderApp(),
      );
    },
  );
}

class CgmCalanderApp extends StatelessWidget {
  const CgmCalanderApp({
    Key? key,
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
        builder: (context, child) => WelcomePage(),
      ),
    );
  }
}
