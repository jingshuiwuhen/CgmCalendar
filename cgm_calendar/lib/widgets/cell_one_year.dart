import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';

class CellOneYear extends StatelessWidget {
  const CellOneYear({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) =>
          Padding(padding: EdgeInsets.fromLTRB(sx(10), sy(10), sx(10), sy(10))),
    );
  }
}
