import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Home(),
    );
  }
}

class Data {
  final String? title;
  bool? check;
  Data({this.title, this.check});
}

class Home extends StatefulWidget {
  const Home({super.key});

  _homeState createState() => _homeState();
}

class _homeState extends State<Home> {
  List<Data> list = [];
  List<Data> listComp = [];
  List<Data> listIncomp = [];

  // List<bool> listBool = [];
  Widget _displayCreateDialog() {
    bool check = false;
    TextEditingController content = TextEditingController();

    void addList(bool c) {
      if (c) {
        listComp.add(Data(title: content.text.trim(), check: c));
      } else {
        listIncomp.add(Data(title: content.text.trim(), check: c));
      }
    }

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
            setState(() {
              addList(check);
              list.add(Data(title: content.text.trim(), check: check));
              //listIncomp.add(Data(title: content.text.trim(), check: false));
            });
            Navigator.pop(context, false);
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

  int index = 0;
  void initState() {
    index = 1;
  }

  Widget build(BuildContext context) {
    List<Widget> listWidget = [
      CompleteTask(listComp),
      allTask(),
      CompleteTask(listIncomp),
    ];

    List<String> title = ['Complete Task', 'All Task', 'Incomplete Task'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title[index],
          style: TextStyle(
            fontSize: 30,
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

  Widget CompleteTask(List<Data> a) {
    return Container(
      child: ListView.builder(
          itemCount: a.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
                value: a[index].check,
                title: Text(a[index].title.toString()),
                onChanged: (value) {});
          }),
    );
  }

  Widget allTask() {
    return Column(
      children: [
        TextButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => _displayCreateDialog(),
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
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  value: list[index].check,
                  //selected: listBool[index],
                  title: Text(list[index].title.toString()),
                  onChanged: (value) {
                    setState(() {
                      list[index].check = value;
                    });
                  },
                );
              }),
        ),
      ],
    );
  }
}
