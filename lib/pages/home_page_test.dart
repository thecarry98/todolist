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
import 'package:todolist/pages/dialog_create.dart';
import 'package:todolist/pages/dialog_create_test.dart';

class BuildList extends StatelessWidget {
  final List<Note> l;
  final bool? check;
  VoidCallback? callback;
  BuildList({required this.l, this.check, this.callback});
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangeValue>(
        create: (context) => ChangeValue(list: l),
        child: ListView.builder(
            itemCount: l.length,
            itemBuilder: (context, index) {
              return Consumer<ChangeValue>(builder: ((context, myValue, child) {
                return CheckboxListTile(
                  value: check != null ? check : l[index].check,
                  //selected: listBool[index],
                  title: Text(l[index].title.toString()),
                  onChanged: (value) {
                    // setState(() {
                    myValue.changeValue(index);
                    l[index].check = value;
                    NotesDatabase.instance.update(l[index]);
                    // });
                    // callback;
                    // refreshNotes(isCheck: true);
                  },
                );
              }));
            }));
  }
}

class HomePageTest extends StatefulWidget {
  const HomePageTest({super.key});

  _homeState createState() => _homeState();
}

class _homeState extends State<HomePageTest> {
  _homeState home() => _homeState();
  bool isLoading = false;
  int index = 0;
  // List<bool> listBool = [];

  // TextEditingController content = TextEditingController();
  // bool check = false;
  void addList(bool c) {
    setState(() {
      if (c) {
        listComp = list.where((e) => e.check == true).toList();
        listIncomp.removeWhere((e) => e.check == true);
      } else {
        listIncomp = list.where((e) => e.check == false).toList();
        listComp.removeWhere((e) => e.check == false);
      }
    });
  }

  void initState() {
    index = 1;
    super.initState();

    refreshNotes();
  }

  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    // setState(() {
    //   if (isCheck == true) {
    //     isLoading = false;
    //   } else {
    //     isLoading = true;
    //   }
    // });
    setState(() => isLoading = true);

    list = await NotesDatabase.instance.readAllNotes();

    list.forEach((v) {
      addList(v.check ?? false);
    });

    setState(() => isLoading = false);
  }

  Future onSubmit(String content, bool check) async {
    setState(() {
      //listIncomp.add(Note(title: content.text.trim(), check: false));
    });
    await NotesDatabase.instance
        .create(Note(title: content.trim(), check: check));
    await refreshNotes();
  }

  Widget build(BuildContext context) {
    // State state;
    DialogCreateTest dialog() => DialogCreateTest(
        context: context,
        onPressed: (value, check) async {
          await onSubmit(value, check);
        });
    List<Widget> listWidget = [
      changeTask(listComp),
      allTask(context, dialog()),
      changeTask(listIncomp),
    ];

    List<String> title = ['Complete Task', 'All Task', 'Incomplete Task'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title[index],
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
      body: listWidget[index],
      // height: 300,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Text(''),
            label: 'Complete',
          ),
          BottomNavigationBarItem(
            icon: Text(''),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Text(''),
            label: 'Incomplete',
          ),
        ],
        selectedFontSize: 20,
        unselectedFontSize: 20,
        backgroundColor: Colors.indigo[50],
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
      ),
    );
  }

  // void changeValueTask(bool? value) {
  //   if (value == true) {
  //   } else {}
  // }

  Widget changeTask(List<Note> a) {
    return Container(child: BuildList(l: a, callback: refreshNotes)
        // ListView.builder(
        //     itemCount: a.length,
        //     itemBuilder: (context, index) {
        //       return CheckboxListTile(
        //           value: a[index].check,
        //           title: Text(a[index].title.toString()),
        //           onChanged: (value) {
        //             setState(() {
        //               a[index].check = value;
        //               NotesDatabase.instance.update(a[index]);
        //             });
        //             refreshNotes();
        //             // changeValueTask(value);
        //           });
        //     }),
        );
  }

  // DialogCreate dialog() => DialogCreate(state: state, context: context);
  Widget allTask(BuildContext context, DialogCreateTest dialog) {
    return Column(
      children: [
        TextButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => dialog,
            // callback: callback,
            // AlertDialog(
            //   title: Text('Create Tast'),
            //   content: Text(''),
            // ),
          ),
          child: Text(
            'Create Task',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        Expanded(
          //height: 900,
          child: isLoading
              ? CircularProgressIndicator()
              : list.isEmpty
                  ? Text(
                      'No Notes',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : BuildList(l: list, callback: refreshNotes),
        ),
      ],
    );
  }
}

class ChangeValue with ChangeNotifier {
  final List<Note> list;
  ChangeValue({required this.list});
  bool? value;

  changeValue(int index) {
    list[index].check = !list[index].check!;
    notifyListeners();
  }
}
