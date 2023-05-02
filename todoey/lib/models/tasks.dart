import 'package:uuid/uuid.dart';

class Task {
  final String id;
  final String name;
  bool isDone;

  Task({required this.name, this.isDone = false}) : id = const Uuid().v4();

  void toggleDone() {
    isDone = !isDone;
  }
}
