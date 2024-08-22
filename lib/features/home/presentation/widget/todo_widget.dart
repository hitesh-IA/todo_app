import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        ],
      ),
    );
  }
}
