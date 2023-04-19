import 'package:flutter/material.dart';

class SelectedPageWidget extends StatelessWidget {
  final int selectedPage;
  const SelectedPageWidget({super.key, required this.selectedPage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final selectedColor = colorScheme.primary;
    final unselectedColor = colorScheme.secondaryContainer;
    return Container(
      color: colorScheme.onInverseSurface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: selectedPage == 0 ? 7 : 5,
              backgroundColor:
                  selectedPage == 0 ? selectedColor : unselectedColor,
            ),
            const SizedBox(width: 4),
            CircleAvatar(
              radius: selectedPage == 1 ? 7 : 5,
              backgroundColor:
                  selectedPage == 1 ? selectedColor : unselectedColor,
            ),
          ],
        ),
      ),
    );
  }
}
