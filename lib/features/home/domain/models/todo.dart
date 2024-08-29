import 'package:hive/hive.dart';

part "todo.g.dart";

@HiveType(typeId: 1)
class Todo {
  @HiveField(0)
  final String id;
  @HiveField(1)
  String descriptions;
  @HiveField(2)
  bool completed;

  Todo({
    required this.id,
    required this.descriptions,
    required this.completed,
  });
}
