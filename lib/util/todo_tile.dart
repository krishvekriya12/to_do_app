import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final String priority;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  final Function(BuildContext)? editFunction;

  const TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    this.priority = "Medium",
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunction,
  });

  Color _getPriorityColor(String p) {
    switch (p) {
      case 'High':
        return Colors.red.shade400;
      case 'Low':
        return Colors.green.shade500;
      case 'Medium':
      default:
        return Colors.orange.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 18),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: editFunction,
              icon: Icons.edit,
              backgroundColor: Colors.blue.shade400,
              borderRadius: BorderRadius.circular(12),
            ),
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade400,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[850] : Colors.yellow,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: isDark ? Colors.yellow : Colors.black,
                checkColor: isDark ? Colors.black : Colors.white,
              ),
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark
                        ? (taskCompleted ? Colors.grey[500] : Colors.white)
                        : (taskCompleted ? Colors.grey[700] : Colors.black87),
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getPriorityColor(priority).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _getPriorityColor(priority),
                    width: 1,
                  ),
                ),
                child: Text(
                  priority,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: _getPriorityColor(priority),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
