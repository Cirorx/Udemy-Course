import 'package:flutter/material.dart';
import 'package:todoey/widgets/tasks_tile.dart';

import '../models/tasks.dart';

class TasksList extends StatefulWidget {
  const TasksList({
    super.key,
  });

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  List<Task> tasks = [
    Task(name: "Todo1"),
    Task(name: "Todo2"),
    Task(name: "Todo3"),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return TaskTile(
            isChecked: tasks[index].isDone,
            taskTitle: tasks[index].name,
            checkboxCallback: (checkboxState) {
              setState(() => tasks[index].toggleDone());
            },
          );
        },
        itemCount: tasks.length);
  }
}
