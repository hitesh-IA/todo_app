import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/features/home/presentation/widget/custom_searchbar.dart';
import 'package:todo_app/features/home/presentation/widget/task_counter_card.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({
    super.key,
    required this.pendingCounter,
    required this.completedCounter,
    required this.remindersCounter,
  });

  final int pendingCounter;
  final int completedCounter;
  final int remindersCounter;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(1, 0),
          colors: [
            Color(0xFFF4C465),
            Color(0xFFC63956),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Image.asset(
            'assets/images/image.png',
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi Ivan 👋',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Your day look like this:',
                    style: GoogleFonts.roboto(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TaskCounterCard(
                    tasksCounter: pendingCounter,
                    taskType: 'pending',
                    iconData: Icons.calendar_month_rounded,
                  ),
                  TaskCounterCard(
                    tasksCounter: completedCounter,
                    taskType: 'completed',
                    iconData: Icons.check_circle,
                  ),
                  TaskCounterCard(
                    tasksCounter: remindersCounter,
                    taskType: 'reminders',
                    iconData: Icons.check_circle,
                  )
                ],
              ),
            ),
          ),

          /// search bar widget section
          /// later add to functionality with hive local database
          Positioned(
            right: 0,
            top: 0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AnimSearchBar(
                autoFocus: false,
                width: MediaQuery.of(context).size.width * 0.9,
                textController: TextEditingController(),
                onSuffixTap: () {},
                style: GoogleFonts.roboto(
                  color: const Color(0xFF9C9A9A),
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF9C9A9A),
                ),
                suffixIcon: const Icon(
                  Icons.clear_rounded,
                  color: Color(0xFF9C9A9A),
                ),
                onSubmitted: (value) {
                  //later add this feature
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
