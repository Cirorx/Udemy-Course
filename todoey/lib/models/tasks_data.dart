import 'package:flutter/foundation.dart';
import 'tasks.dart';

class TaskData extends ValueNotifier<List<Task>> {
  TaskData._sharedInstance() : super([]);
  static final TaskData _shared = TaskData._sharedInstance();
  factory TaskData() => _shared;

  int get lenght => value.length;
  List<Task> get getTasks => value;

  void addTask({required Task task}) {
    final tasks = value;
    tasks.add(task);
    notifyListeners();
  }

  void remove({required Task task}) {
    final tasks = value;
    if (tasks.contains(task)) {
      tasks.remove(task);
      notifyListeners();
    }
  }

  Task? task({required int atIndex}) =>
      value.length > atIndex ? value[atIndex] : null;
}
