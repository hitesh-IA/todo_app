import 'package:todo_app/features/home/domain/models/todo.dart';

abstract class TodosRepository {
  Future<List<Todo>> getTodos();
  Future<void> addTodo({required String description});
  Future<void> deleteTodo(String id);
  Future<void> toggleTodo(String id);
}
