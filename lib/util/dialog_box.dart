import 'package:flutter/material.dart';
import 'package:to_do_app/util/my_button.dart';

class DialogBox extends StatefulWidget {
  final TextEditingController controller;
  final String initialPriority;
  final ValueChanged<String>? onPriorityChanged;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    super.key,
    required this.controller,
    this.initialPriority = "Medium",
    this.onPriorityChanged,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  late String _priority;

  @override
  void initState() {
    super.initState();
    _priority = widget.initialPriority;
  }

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

    return AlertDialog(
      backgroundColor: isDark ? Colors.grey[850] : Colors.yellow[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: SizedBox(
        height: 195,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: widget.controller,
              autofocus: true,
              style: TextStyle(color: isDark ? Colors.white : Colors.black87),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Add a task...",
                hintStyle: TextStyle(
                  color: isDark ? Colors.grey[400] : Colors.grey[700],
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Priority:",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.grey[300] : Colors.black87,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['High', 'Medium', 'Low'].map((p) {
                final isSelected = _priority == p;
                return ChoiceChip(
                  label: Text(
                    p,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.grey[300] : Colors.black87),
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: _getPriorityColor(p),
                  backgroundColor:
                      isDark ? Colors.grey[800] : Colors.yellow[100],
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _priority = p;
                      });
                      widget.onPriorityChanged?.call(p);
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text: "Cancel", onPressed: widget.onCancel),
                const SizedBox(width: 8),
                MyButton(text: "Save", onPressed: widget.onSave),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
