import 'package:flutter/material.dart';

import 'package:todoey/screens/tasks_screen.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TasksScreen(),
    ),
  );
}
