
import 'package:flutter/material.dart';



class Grievances extends StatelessWidget {
  const Grievances(
      {super.key,
      required this.img,
      required this.text,
      this.textcolor,
      this.fontsize,
      this.height,
      this.width});
  final String img;
  final String text;
  final Color? textcolor;
  final double? fontsize;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
          onPressed: () {
           // Navigator.pushNamed(context, AllRoutes.full_grievance_details);
          },
          child: Column(
            children: [
              Image.asset(
                "assets/" + img,
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