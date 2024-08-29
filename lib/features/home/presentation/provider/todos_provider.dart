import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/home/domain/models/todo.dart';
import 'package:todo_app/features/home/domain/repository/todos_repository.dart';
import 'package:todo_app/features/home/presentation/provider/todos_repo_provider.dart';

enum TodoFilter { all, completed, pending, newtask }

/// this provider for managing for current selected [TodoFilter].
final selectedFilterTodoProvider = StateProvider<TodoFilter>(
  (ref) {
    return TodoFilter.all;
  },
);

/// The provider for managing the list of [Todo] items.
final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>(
  (ref) {
    final todosRepository = ref.watch(todosRepoProvider);
    return TodosNotifier(todosRepository: todosRepository);
  },
);

class TodosNotifier extends StateNotifier<List<Todo>> {
  final TodosRepository todosRepository;
  TodosNotifier({required this.todosRepository}) : super([]);

  Future<void> addTodo(
      {required String title, required String description}) async {
    await todosRepository.addTodo(title: title, description: description);
    state = await todosRepository.getTodos();
  }

  Future<void> toggleTodo(String id) async {
    await todosRepository.toggleTodo(id);
    state = await todosRepository.getTodos();
  }

  Future<void> deleteTodo(String id) async {
    await todosRepository.deleteTodo(id);
    state = await todosRepository.getTodos();
  }

  Future<void> loadTodos() async {
    state = await todosRepository.getTodos();
  }
}

/// Provides a filtered list of [Todo] items based on the selected [TodoFilter].
final filteredTodosProvider = Provider<List<Todo>>(
  (ref) {
    final todoFilter = ref.watch(selectedFilterTodoProvider);
    final todos = ref.watch(todosProvider);

    return switch (todoFilter) {
      TodoFilter.all => todos,
      TodoFilter.pending => todos.where((todo) => !todo.completed).toList(),
      TodoFilter.completed => todos.where((todo) => todo.completed).toList(),
      TodoFilter.newtask => <Todo>[]
    };
  },
);

final newTodoDescriptionProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final newTodoTitleProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);
