import 'package:flutter/material.dart';

class Grievances extends StatelessWidget {
  const Grievances(
      {super.key,
      required this.img,
      required this.text,
      this.textcolor,
      this.fontsize,
      this.height,
      this.width, this.onclick,});
  final String img;
  final String text;
  final Color? textcolor;
  final double? fontsize;
  final double? height;
  final double? width;
  final GestureTapCallback? onclick;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
          onPressed: onclick,
          child: Column(
            children: [
              Image.asset(
                img,
                height: height,
                width: width,
              ),
              Center(
                  child: Text(
                text,
                style: TextStyle(color: textcolor),
              )),
            ],
          )),
    );
  }
}
