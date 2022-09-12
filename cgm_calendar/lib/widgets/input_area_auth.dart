import 'dart:async';
import 'package:cgm_calendar/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class InputAreaAuth extends StatefulWidget {
  InputAreaAuth({
    Key? key,
    this.controller,
    this.onPressed,
  }) : super(key: key);

  final TextEditingController? controller;
  bool isBtnEnable = true;
  final Future<bool> Function()? onPressed;

  @override
  State<StatefulWidget> createState() => _InputAreaAuthState();
}

class _InputAreaAuthState extends State<InputAreaAuth> {
  Timer? _timer;
  int _countDownTime = -1;

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: TextField(
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            maxLines: 1,
            decoration: InputDecoration(
              isDense: true,
              hintText: S.of(context).verification_code,
              hintStyle: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey,
              ),
              border: InputBorder.none,
            ),
            controller: widget.controller,
          ),
        ),
        TextButton(
          onPressed: widget.isBtnEnable
              ? () async {
                  if (_countDownTime > 0) {
                    return;
                  }
                  if (widget.onPressed != null && !await widget.onPressed!()) {
                    return;
                  }
                  if (_countDownTime < 1) {
                    _startCountDown(context);
                  }
                }
              : null,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.fromLTRB(
                5.w,
                0,
                5.w,
                0,
              ),
            ),
            side: MaterialStateProperty.all(
              BorderSide(
                color: widget.isBtnEnable ? Colors.blue : Colors.grey,
              ),
            ),
          ),
          child: Text(
            _setAuthGetBtnString(context),
            style: TextStyle(
              color: widget.isBtnEnable ? Colors.blue : Colors.grey,
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }

  void _startCountDown(BuildContext context) {
    _countDownTime = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countDownTime < 1) {
        _timer?.cancel();
      } else {
        setState(() {
          _countDownTime--;
        });
      }
    });
  }

  String _setAuthGetBtnString(BuildContext context) {
    if (_countDownTime == -1) {
      return S.of(context).get_code;
    } else {
      return "$_countDownTime${S.of(context).second}";
    }
  }
}
