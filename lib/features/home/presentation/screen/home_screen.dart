import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/home/presentation/provider/tasks_counter_provider.dart';
import 'package:todo_app/features/home/presentation/provider/todos_provider.dart';
import 'package:todo_app/features/home/presentation/widget/custom_bottom_nav_bar.dart';
import 'package:todo_app/features/home/presentation/widget/custom_new_todo_dialog.dart';
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
    final newTaskCounter = ref.watch(newTaskCounterProvider);
    final currentFilter = ref.watch(selectedFilterTodoProvider);

    final tasksTitleGroup = switch (currentFilter) {
      TodoFilter.all => 'All tasks',
      TodoFilter.pending => 'Pending tasks',
      TodoFilter.completed => 'Completed tasks',
      TodoFilter.newtask => 'New tasks',
    };

    final noPlanTodayMessage = switch (currentFilter) {
      TodoFilter.all => 'oh! you don\'t have any plan today?😞',
      TodoFilter.completed => 'oh! there is no completed plan',
      TodoFilter.pending => 'oh! there is no pending plan',
      TodoFilter.newtask => 'oh! there is no new task plan',
    };

    //todos.sort((a, b) => a.taskTitle.compareTo(b.taskTitle));

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            /// top section of home screen which contains image, and task status and search-bar widget.
            WelcomeCard(
              pendingCounter: pendingCounter,
              completedCounter: completedCounter,
              newTaskCounter: newTaskCounter,
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
              child: todos.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return TodoWidget(
                          id: todo.id,
                          title: todo.taskTitle,
                          description: todo.descriptions,
                          completed: todo.completed,
                          onTapcheckBox: () {
                            ref
                                .watch(todosProvider.notifier)
                                .toggleTodo(todo.id);
                          },
                          onTapDelete: () {
                            ref
                                .watch(todosProvider.notifier)
                                .deleteTodo(todo.id);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        noPlanTodayMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          color: const Color(0xFF8C8C8C),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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
        return CustomNewTodoDialog(
          onCreateListener: () {
            final newTodoTitle = ref.read(newTodoTitleProvider);
            final newTodoDesciption = ref.read(newTodoDescriptionProvider);
            if (newTodoTitle.isNotEmpty && newTodoDesciption.isNotEmpty) {
              ref.read(todosProvider.notifier).addTodo(
                    title: newTodoTitle,
                    description: newTodoDesciption,
                  );
              ref.read(newTodoTitleProvider.notifier).update((state) => '');
              ref
                  .read(newTodoDescriptionProvider.notifier)
                  .update((state) => '');
              ref
                  .read(selectedFilterTodoProvider.notifier)
                  .update((state) => TodoFilter.all);
              Navigator.of(context).pop();
            }
          },
        );
      },
    );
  }
}
