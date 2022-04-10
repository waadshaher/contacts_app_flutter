import 'package:flutter/material.dart';
import 'package:vimigo_technical_assessment/screens/sortable_list.dart';

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
}
