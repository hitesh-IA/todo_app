import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:todo_app/features/home/presentation/provider/todos_provider.dart';

class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const selectedColor = Colors.green;
    const unSelectedColor = Color(0xFF8C8C8C);
    final currentFilter = ref.watch(selectedFilterTodoProvider);

    return StylishBottomBar(
      items: [
        BottomBarItem(
          icon: const Icon(Icons.house_outlined),
          selectedIcon: const Icon(Icons.house_rounded),
          selectedColor: selectedColor,
          unSelectedColor: unSelectedColor,
          title: const Text('All'),
        ),
        BottomBarItem(
          icon: const Icon(Icons.star_border_rounded),
          selectedIcon: const Icon(Icons.star_rounded),
          selectedColor: selectedColor,
          unSelectedColor: unSelectedColor,
          title: const Text('Completed'),
        ),
        BottomBarItem(
          icon: const Icon(Icons.style_outlined),
          selectedIcon: const Icon(Icons.style),
          selectedColor: selectedColor,
          unSelectedColor: unSelectedColor,
          title: const Text('Pending'),
        ),
        BottomBarItem(
          icon: const Icon(Icons.access_time_outlined),
          selectedIcon: const Icon(Icons.access_time_filled_outlined),
          selectedColor: selectedColor,
          unSelectedColor: unSelectedColor,
          title: const Text('Reminders'),
        ),
      ],
      hasNotch: true,
      onTap: (index) {
        ref
            .read(selectedFilterTodoProvider.notifier)
            .update((state) => TodoFilter.values[index]);
      },
      fabLocation: StylishBarFabLocation.center,
      currentIndex: currentFilter.index,
      option: AnimatedBarOptions(
        barAnimation: BarAnimation.fade,
        iconStyle: IconStyle.Default,
      ),
    );
  }
}
