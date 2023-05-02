import 'package:flutter/material.dart';
import 'package:todoey/models/tasks_data.dart';

import '../models/tasks.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late String newTaskTitle;
    return Container(
      color: const Color(0xff747474),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add task',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 30,
              ),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (text) => newTaskTitle = text,
            ),
            TextButton(
              onPressed: () {
                TaskData().addTask(task: Task(name: newTaskTitle));
                Navigator.of(context).pop();
              },
              style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.blueGrey),
              ),
              child: const Text("Add",
                  style: TextStyle(
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
