import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/model/note.dart';
import 'package:flutter/services.dart';
import 'package:todolist/db/notes_database.dart';
import 'package:todolist/pages/home_page.dart';
import 'package:todolist/controller/control.dart';

class DialogCreateTest extends StatelessWidget {
  DialogCreateTest({
    super.key,
    // required this.list,
    // required this.state,
    required this.context,
    required this.onPressed,
  });
  // VoidCallback? callback;

  BuildContext context;
  Function(String content, bool check) onPressed;
  TextEditingController content = TextEditingController();
  MyDialog myDialog() => MyDialog();
  // bool check = MyD;
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyDialog>(
      create: (context) => myDialog(),
      child: AlertDialog(
        title: Text('Create Task'),
        content: Container(
          height: 100,
          child: Center(
            child: ListTile(
              title: TextField(
                controller: content,
              ),
              trailing: Consumer<MyDialog>(builder: (context, myDialog, child) {
                return Checkbox(
                  value: myDialog.getCheck(),
                  onChanged: (value) {
                    myDialog.changeValue(MyDialog().checkBox);
                  },
                );
              }),
            ),
          ),
        ),
        actions: [
          Consumer<MyDialog>(builder: (context, myDialog, child) {
            return TextButton(
              onPressed: () {
                // MyDialog().printf;
                print(myDialog.checkBox);
                onPressed(content.text.trim(), myDialog.getCheck());
                content.clear();
                Navigator.pop(context);
              },
              child: Text(
                'Submit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue[400],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class MyDialog with ChangeNotifier {
  bool checkBox = false;

  changeValue(bool value) {
    checkBox = !checkBox;
    value = checkBox;
    notifyListeners();
  }

  bool getCheck() => checkBox;
}
