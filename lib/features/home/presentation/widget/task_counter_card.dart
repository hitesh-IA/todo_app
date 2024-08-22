import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskCounterCard extends StatelessWidget {
  const TaskCounterCard({
    super.key,
    required this.tasksCounter,
    required this.taskType,
    required this.iconData,
  });

  final int tasksCounter;
  final String taskType;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        height: 28,
        width: 152,
        decoration: BoxDecoration(
          color: const Color(0xFF00F0FF),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 5, 12, 7),
          child: Row(
            children: [
              Icon(
                iconData,
                color: Colors.white,
                size: 16.0,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '$tasksCounter tasks $taskType',
                style: GoogleFonts.roboto(
                  color: const Color(0xFF8C8C8C).withOpacity(0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
