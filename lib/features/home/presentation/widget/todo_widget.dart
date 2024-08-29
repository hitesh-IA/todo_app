import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/home/presentation/widget/custom_delete_todo_dialog.dart';
import 'package:todo_app/features/home/presentation/widget/custom_icon_button.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({
    super.key,
    required this.id,
    required this.description,
    required this.completed,
    required this.onTapcheckBox,
    required this.onTapDelete,
  });

  final String id;
  final String description;
  final bool completed;
  final void Function() onTapcheckBox;
  final void Function() onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
        left: 20,
        right: 20,
      ),
      padding: const EdgeInsets.all(10.0),
      height: 70,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, 0),
          )
        ],
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Row(
        children: [
          CustomIconButton(
            icon: Icon(
              (completed)
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank_rounded,
              color: Colors.blue,
              size: 23,
            ),
            color: Colors.blue.withOpacity(0.3),
            onTap: onTapcheckBox,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                description,
                style: GoogleFonts.roboto(
                    color: const Color(0xFF6C6868),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    decoration: completed ? TextDecoration.lineThrough : null,
                    decorationThickness: completed ? 2.0 : null,
                    decorationColor: completed ? Colors.blue : null),
              ),
            ),
          ),
          CustomIconButton(
            icon: const Icon(
              Icons.disabled_by_default_rounded,
              color: Colors.red,
              size: 23,
            ),
            color: Colors.red.withOpacity(0.3),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CustomDeleteTodoDialog(
                    content: 'Are you sure you want to delete?',
                    onTapDelete: onTapDelete,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
