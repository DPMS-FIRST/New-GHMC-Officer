import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghmc_officer/Res/constants/routes/app_pages.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';
import 'package:ghmc_officer/firebase_options.dart';


/* void main() {

  runApp(const MyApp());
} */
void main() async {
  /* await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]); */
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
 
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      
      
      debugShowCheckedModeBanner: false,

      
      initialRoute: AppRoutes.initial,
      routes: AppPages.routes,
      title: 'GHMC Officer',
      builder: EasyLoading.init(),
      theme: ThemeData(
         bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.white,
        ),
    ));
  }
   
}

