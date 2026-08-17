import 'package:hive_flutter/adapters.dart';

class ToDoDataBase {
  List toDoList = [];
  final _myBox = Hive.box('mybox');

  void createInitialData() {
    toDoList = [
      ["Make Tutorial", false],
      ["Do Code", false],
    ];
  }

  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
