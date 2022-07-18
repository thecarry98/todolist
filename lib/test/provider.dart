import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/test/model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  MyModel newModel() => MyModel(someValue: 'hihi');
  Widget build(BuildContext context) {
    // final myModel = Provider.of<MyModel>(context, listen: false);
    return ChangeNotifierProvider<MyModel>(
      create: (context) => newModel(),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('My App')),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.green[200],
                  // child: Consumer<MyModel>(builder: (context, myModel, child) {
                  //   return RaisedButton(
                  //     child: Text(myModel.someValue),
                  //     onPressed: () {
                  //       myModel.doSomething();
                  //     },
                  //   );
                  // }),
                  child: MyButton()),
              // MyButton(),
              Container(
                padding: const EdgeInsets.all(35),
                color: Colors.blue[200],
                child: Consumer<MyModel>(builder: (context, myModel, child) {
                  return Text(newModel().someValue!);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class MyModel with ChangeNotifier {
//   String someValue = 'Hello';
//   void doSomething() {
//     someValue = 'Goodbye';
//     print(someValue);
//     notifyListeners();
//   }
// }

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<MyModel>(context, listen: false);
    return RaisedButton(
      child: Text('Do something'),
      onPressed: () {
        myModel.doSomething();
      },
    );
  }
}
