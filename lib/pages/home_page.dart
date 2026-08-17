import 'package:flutter/material.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/main.dart';
import 'package:to_do_app/util/dialog_box.dart';
import 'package:to_do_app/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  final ToDoDataBase db = ToDoDataBase();

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  String _selectedFilter = 'All'; // 'All', 'Active', 'Completed'

  @override
  void initState() {
    super.initState();
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  void _toggleTheme() {
    final isDark = themeNotifier.value == ThemeMode.dark;
    themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
    db.saveThemeMode(!isDark);
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void createNewTask() {
    String currentPriority = "Medium";
    _controller.clear();
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          initialPriority: currentPriority,
          onPriorityChanged: (p) => currentPriority = p,
          onSave: () {
            if (_controller.text.trim().isNotEmpty) {
              setState(() {
                db.toDoList.add([
                  _controller.text.trim(),
                  false,
                  currentPriority,
                ]);
                _controller.clear();
              });
              Navigator.of(context).pop();
              db.updateDataBase();
            }
          },
          onCancel: () {
            _controller.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void editTask(int index) {
    _controller.text = db.toDoList[index][0];
    String currentPriority =
        db.toDoList[index].length > 2 ? db.toDoList[index][2] : "Medium";

    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          initialPriority: currentPriority,
          onPriorityChanged: (p) => currentPriority = p,
          onSave: () {
            if (_controller.text.trim().isNotEmpty) {
              setState(() {
                db.toDoList[index][0] = _controller.text.trim();
                db.toDoList[index][2] = currentPriority;
                _controller.clear();
              });
              Navigator.of(context).pop();
              db.updateDataBase();
            }
          },
          onCancel: () {
            _controller.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void deleteTask(int index) {
    final deletedTask = db.toDoList[index];
    final deletedIndex = index;

    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task "${deletedTask[0]}" deleted'),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.grey[900],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.yellow,
          onPressed: () {
            setState(() {
              db.toDoList.insert(deletedIndex, deletedTask);
            });
            db.updateDataBase();
          },
        ),
      ),
    );
  }

  List<MapEntry<int, dynamic>> get _filteredTasks {
    final List<MapEntry<int, dynamic>> result = [];
    for (int i = 0; i < db.toDoList.length; i++) {
      final task = db.toDoList[i];
      final String name = task[0].toString().toLowerCase();
      final bool isCompleted = task[1] == true;

      final matchesSearch = name.contains(_searchQuery.toLowerCase());
      final matchesFilter = _selectedFilter == 'All' ||
          (_selectedFilter == 'Active' && !isCompleted) ||
          (_selectedFilter == 'Completed' && isCompleted);

      if (matchesSearch && matchesFilter) {
        result.add(MapEntry(i, task));
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filtered = _filteredTasks;

    final allCount = db.toDoList.length;
    final activeCount =
        db.toDoList.where((t) => t[1] == false).length;
    final completedCount =
        db.toDoList.where((t) => t[1] == true).length;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'To Do',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            ),
            onPressed: _toggleTheme,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: isDark ? const Color(0xFF282828) : Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Filter Chips (All, Active, Completed)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Row(
              children: [
                _buildFilterChip('All', allCount, isDark),
                const SizedBox(width: 8),
                _buildFilterChip('Active', activeCount, isDark),
                const SizedBox(width: 8),
                _buildFilterChip('Completed', completedCount, isDark),
              ],
            ),
          ),

          // Task List or Empty State
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _searchQuery.isNotEmpty
                              ? Icons.search_off_rounded
                              : Icons.checklist_rounded,
                          size: 72,
                          color: isDark ? Colors.grey[600] : Colors.grey[500],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _searchQuery.isNotEmpty
                              ? 'No matching tasks found'
                              : (_selectedFilter == 'All'
                                  ? 'No tasks yet!'
                                  : 'No $_selectedFilter tasks'),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.grey[300] : Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _searchQuery.isNotEmpty
                              ? 'Try searching with a different keyword'
                              : 'Tap the + button to create a task',
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? Colors.grey[500] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: filtered.length,
                    itemBuilder: (context, idx) {
                      final originalIndex = filtered[idx].key;
                      final task = filtered[idx].value;
                      final priority = task.length > 2 ? task[2] : "Medium";

                      return TodoTile(
                        taskName: task[0],
                        taskCompleted: task[1],
                        priority: priority,
                        onChanged: (value) =>
                            checkBoxChanged(value, originalIndex),
                        deleteFunction: (context) =>
                            deleteTask(originalIndex),
                        editFunction: (context) => editTask(originalIndex),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, int count, bool isDark) {
    final isSelected = _selectedFilter == label;

    return ChoiceChip(
      label: Text(
        '$label ($count)',
        style: TextStyle(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected
              ? Colors.black
              : (isDark ? Colors.grey[300] : Colors.grey[800]),
        ),
      ),
      selected: isSelected,
      selectedColor: Colors.yellow,
      backgroundColor: isDark ? const Color(0xFF282828) : Colors.white70,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedFilter = label;
          });
        }
      },
    );
  }
}
