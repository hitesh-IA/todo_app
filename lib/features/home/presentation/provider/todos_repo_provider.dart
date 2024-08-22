import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/home/data/local/todos_repository_impl.dart';
import 'package:todo_app/features/home/domain/repository/todos_repository.dart';

/// provides an [TodosRepositoryImpl] insatnce for managing local database operations.
final todosRepoProvider = Provider<TodosRepository>((ref) {
  return TodosRepositoryImpl();
});
