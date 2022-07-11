import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/model/note.dart';
import 'package:flutter/services.dart';
import 'package:todolist/db/notes_database.dart';
import 'package:todolist/pages/home_page.dart';
import 'package:todolist/controller/control.dart';

class DialogCreate extends StatelessWidget {
  DialogCreate(
      {super.key,
      // required this.list,
      // required this.state,
      required this.context,
      required this.onPressed});

  BuildContext context;
  Function(String content, bool check) onPressed;
  TextEditingController content = TextEditingController();
  bool check = false;
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Task'),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Container(
          height: 100,
          child: Center(
            child: ListTile(
              title: TextField(
                controller: content,
              ),
              trailing: Checkbox(
                value: check,
                onChanged: (value) {
                  setState(() {
                    check = value!;
                  });
                },
              ),
            ),
          ),
        );
      }),
      actions: [
        TextButton(
          onPressed: () {
            onPressed(content.text.trim(), check);
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
        ),
      ],
    );
  }
}
