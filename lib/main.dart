import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/model/note.dart';
import 'package:flutter/services.dart';
import 'package:todolist/db/notes_database.dart';
import 'package:todolist/pages/home_page.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized(),

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Home(),
      //routes:
    );
  }
}

// class Note {
//   final String? title;
//   bool? check;
//   Note({this.title, this.check});
// }

