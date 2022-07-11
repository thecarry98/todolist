import 'package:todolist/model/note.dart';

class Control {
  //List<Note> list = [];
  Control();

  void addList(bool c, var state) {
    state.setState(() {
      if (c) {
        listComp = list.where((e) => e.check == true).toList();
        listIncomp.removeWhere((e) => e.check == true);
      } else {
        listIncomp = list.where((e) => e.check == false).toList();
        listComp.removeWhere((e) => e.check == false);
      }
    });
  }
}
