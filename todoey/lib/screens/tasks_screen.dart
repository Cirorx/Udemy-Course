import 'package:flutter/material.dart';
import '../models/tasks_data.dart';
import '../widgets/tasks_tile.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: TaskData(),
        builder: (context, value, child) {
          final tasks = value;
          return Scaffold(
            backgroundColor: Colors.blueGrey.shade800,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                //When clicking we want to insert a Tasks tile
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const AddTaskScreen(),
                );
              },
              backgroundColor: Colors.blueGrey.shade700,
              child: const Icon(Icons.add),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 60, right: 30, bottom: 30, left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.list_rounded,
                          size: 30,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Todoey",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "${TaskData().lenght} tasks",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return Dismissible(
                            key: ValueKey(task.id),
                            onDismissed: (direction) =>
                                TaskData().remove(task: task),
                            child: TaskTile(
                              isChecked: tasks[index].isDone,
                              taskTitle: tasks[index].name,
                              checkboxCallback: (checkboxState) {
                                setState(() => tasks[index].toggleDone());
                              },
                            ),
                          );
                        },
                        itemCount: tasks.length),
                  ),
                )
              ],
            ),
          );
        });
  }
}
