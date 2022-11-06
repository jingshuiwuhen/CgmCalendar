import 'package:cgm_calendar/generated/l10n.dart';
import 'package:cgm_calendar/pages/input_page.dart';
import 'package:cgm_calendar/pages/year_page.dart';
import 'package:cgm_calendar/view_models/welcome_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class WelcomePage extends StatelessWidget {
  bool _isFirst = true;
  late WelcomePageViewModel wViewModel;
  WelcomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WelcomePageViewModel(),
      builder: (context, child) {
        if (_isFirst) {
          WelcomePageViewModel rViewModel =
              context.read<WelcomePageViewModel>();
          wViewModel = context.watch<WelcomePageViewModel>();
          rViewModel.init(context, () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => YearPage(),
              ),
              (route) => false,
            );
          });
          _isFirst = false;
        }

        return Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Image.asset(
                  'assets/images/welcome.png',
                  fit: BoxFit.contain,
                ),
              ),
              Visibility(
                visible: wViewModel.signState == SignState.idle,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 30.h,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Inputpage(
                                isLogin: true,
                              ),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue[200]),
                          minimumSize: MaterialStateProperty.all(
                            Size(
                              0.6.sw,
                              0.045.sh,
                            ),
                          ),
                        ),
                        child: Text(
                          S.of(context).login,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Inputpage(
                                isLogin: false,
                              ),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green[200]),
                          minimumSize: MaterialStateProperty.all(
                            Size(
                              0.6.sw,
                              0.045.sh,
                            ),
                          ),
                        ),
                        child: Text(
                          S.of(context).register,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => YearPage(),
                            ),
                            (route) => false,
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey),
                          minimumSize: MaterialStateProperty.all(
                            Size(
                              0.6.sw,
                              0.045.sh,
                            ),
                          ),
                        ),
                        child: Text(
                          S.of(context).skip,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
