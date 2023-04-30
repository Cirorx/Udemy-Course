import 'package:flutter/material.dart';
import 'package:todoey/widgets/tasks_tile.dart';

import '../models/tasks.dart';

class TasksList extends StatefulWidget {
  const TasksList(
    this.tasks, {
    super.key,
  });

  final List<Task> tasks;

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return TaskTile(
            isChecked: widget.tasks[index].isDone,
            taskTitle: widget.tasks[index].name,
            checkboxCallback: (checkboxState) {
              setState(() => widget.tasks[index].toggleDone());
            },
          );
        },
        itemCount: widget.tasks.length);
  }
}
