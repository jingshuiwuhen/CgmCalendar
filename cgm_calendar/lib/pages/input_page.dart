import 'package:cgm_calendar/generated/l10n.dart';
import 'package:cgm_calendar/view_models/input_page_view_model.dart';
import 'package:cgm_calendar/widgets/input_area_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Inputpage extends StatelessWidget {
  final bool isLogin;
  const Inputpage({
    Key? key,
    required this.isLogin,
  }) : super(key: key);

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
          isLogin ? S.of(context).login : S.of(context).register,
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
        child: ChangeNotifierProvider(
          create: (_) => InputPageViewModel(context),
          builder: (context, child) {
            InputPageViewModel rViewModel = context.read<InputPageViewModel>();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(
                    10.w,
                    5.h,
                    10.w,
                    5.h,
                  ),
                  margin: EdgeInsets.only(
                    top: 0.1.sh,
                    left: 0.1.sw,
                    right: 0.1.sw,
                  ),
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
                        controller: rViewModel.emailEditingController,
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: S.of(context).email,
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                      Divider(
                        height: 1.h,
                        color: Colors.grey,
                      ),
                      Visibility(
                        visible: !isLogin,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InputAreaAuth(
                              controller: rViewModel.authCodeEditingController,
                              onPressed: () {
                                return rViewModel.requestEmailAuthCode();
                              },
                            ),
                            Divider(
                              height: 1.h,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      TextField(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                        ),
                        controller: rViewModel.passwordEditingController,
                        maxLines: 1,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: S.of(context).password,
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 0.1.sh,
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        isLogin ? Colors.blue[200] : Colors.green[200],
                      ),
                      minimumSize: MaterialStateProperty.all(
                        Size(
                          0.8.sw,
                          0.045.sh,
                        ),
                      ),
                    ),
                    child: Text(
                      isLogin ? S.of(context).login : S.of(context).register,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
