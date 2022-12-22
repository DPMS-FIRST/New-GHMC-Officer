import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

class ReusableToast extends StatelessWidget {
  const ReusableToast(
      {super.key,
      required this.toastmsg,
      this.toastlenghth,
      this.bgcolor,
      this.textcolor,
      this.fontsize, this.toastgravity});
  final String toastmsg;
  final Toast? toastlenghth;
  final Color? bgcolor;
  final Color? textcolor;
  final double? fontsize;
  final ToastGravity? toastgravity;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (() {
          Fluttertoast.showToast(
              msg: toastmsg,
              toastLength: toastlenghth,
              gravity: toastgravity,
              timeInSecForIosWeb: 1,
              backgroundColor:bgcolor,
              textColor:textcolor,
              fontSize: fontsize);
        }),
        child: Text(""));
  }
}
