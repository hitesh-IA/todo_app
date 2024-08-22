import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/home/presentation/provider/tasks_counter_provider.dart';
import 'package:todo_app/features/home/presentation/provider/todos_provider.dart';
import 'package:todo_app/features/home/presentation/widget/custom_bottom_nav_bar.dart';
import 'package:todo_app/features/home/presentation/widget/todo_widget.dart';
import 'package:todo_app/features/home/presentation/widget/welcome_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(todosProvider.notifier).loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(filteredTodosProvider);

    final completedCounter = ref.watch(completedCounterProvider);
    final pendingCounter = ref.watch(pendingCounterProvider);
    final remindersCounter = ref.watch(remindersCounterProvider);
    final currentFilter = ref.watch(selectedFilterTodoProvider);

    final tasksTitleGroup = switch (currentFilter) {
      TodoFilter.all => 'All tasks',
      TodoFilter.pending => 'pending tasks',
      TodoFilter.completed => 'completed tasks',
      TodoFilter.reminders => 'reminders tasks',
    };

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            /// top section of home screen which contains image, and task status and search-bar widget.
            WelcomeCard(
              pendingCounter: pendingCounter,
              completedCounter: completedCounter,
              remindersCounter: remindersCounter,
            ),

            /// task stutas title filter section.
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
              child: Text(
                tasksTitleGroup,
                style: GoogleFonts.roboto(
                  color: const Color(0xFF8C8C8C),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            /// show todos list items.
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return TodoWidget(
                      id: todo.id,
                      description: todo.descriptions,
                      completed: todo.completed,
                      onTapcheckBox: () {
                        ref.watch(todosProvider.notifier).toggleTodo(todo.id);
                      },
                      onTapDelete: () {
                        ref.watch(todosProvider.notifier).deleteTodo(todo.id);
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // dialog appreance
          _showNewTodoDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _showNewTodoDialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return Center(
          child: Text(
            'opening dialog for new ToDo task',
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
