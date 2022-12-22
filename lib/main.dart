import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmc_officer/Res/constants/routes/app_pages.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';
import 'package:toast/toast.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     ToastContext().init(context);
     
    return MaterialApp(
    
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initial,
      routes: AppPages.routes,
      title: 'GHMC Officer',
      builder: EasyLoading.init(),
    );
  }
}

