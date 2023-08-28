import 'package:flutter/material.dart';
import 'package:kpu_ahmadnasir/pages/entry_data.dart';
import 'package:kpu_ahmadnasir/pages/info.dart';
import 'package:kpu_ahmadnasir/pages/show_data.dart';
import 'pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/form_entry': (context) => EntryData(),
        '/show_data': (context) => ShowData(),
        '/info': (context) => InfoPemilu(),
      },
    );
  }
}
