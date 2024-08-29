import 'package:hive/hive.dart';

part "todo.g.dart";

@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  final String id;
  @HiveField(1)
  String taskTitle;
  @HiveField(2)
  String descriptions;
  @HiveField(3)
  bool completed;

  Todo({
    required this.id,
    required this.taskTitle,
    required this.descriptions,
    required this.completed,
  });
}
