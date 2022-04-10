import 'package:flutter/material.dart';
import 'package:vimigo_technical_assessment/screens/sortable_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'screens/introduction_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts App',
      home: SortablePage(),
    );
  }
  // Widget build(BuildContext context) {
  //   SystemChrome.setSystemUIOverlayStyle(
  //     SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
  //   );

  //   return MaterialApp(
  //     title: 'Introduction screen',
  //     debugShowCheckedModeBanner: false,
  //     theme: ThemeData(primarySwatch: Colors.blue),
  //     home: OnBoardingPage(),
  //   );
  // }
}
