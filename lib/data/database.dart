import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];
  final _myBox = Hive.box('mybox');

  void createInitialData() {
    toDoList = [
      ["Make Tutorial", false, "High"],
      ["Do Code", false, "Medium"],
    ];
  }

  void loadData() {
    final rawData = _myBox.get('TODOLIST');
    if (rawData != null) {
      toDoList = List.from(rawData.map((item) {
        if (item is List) {
          final name = item.isNotEmpty ? item[0] : "";
          final completed = item.length > 1 ? item[1] : false;
          final priority = item.length > 2 ? item[2] : "Medium";
          return [name, completed, priority];
        }
        return item;
      }));
    }
  }

  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }

  bool getThemeMode() {
    return _myBox.get('DARK_MODE', defaultValue: false);
  }

  void saveThemeMode(bool isDark) {
    _myBox.put('DARK_MODE', isDark);
  }
}
