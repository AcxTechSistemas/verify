import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateCarrouselWidget extends StatefulWidget {
  final void Function(DateTime date) onDateSelected;

  const DateCarrouselWidget({super.key, required this.onDateSelected});

  @override
  State<DateCarrouselWidget> createState() => _DateCarrouselWidgetState();
}

class _DateCarrouselWidgetState extends State<DateCarrouselWidget> {
  int currentSelect = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final listDates = getDates();
    return Container(
      height: 85,
      color: colorScheme.onInverseSurface,
      child: ListView.builder(
        shrinkWrap: true,
        reverse: true,
        itemCount: listDates.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final isCurrentSelect = index == currentSelect;
          final year = listDates[index].year.toString();
          final day = listDates[index].day.toString();
          final month = DateFormat('MMM').format(listDates[index]);
          return Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isCurrentSelect ? colorScheme.primary : null,
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                widget.onDateSelected(listDates[index]);
                setState(() {
                  currentSelect = index;
                });
              },
              child: Column(
                children: [
                  Text(
                    '$year\n$day-$month',
                    style: textTheme.titleSmall!.copyWith(
                      color: isCurrentSelect
                          ? colorScheme.onInverseSurface
                          : colorScheme.primary,
                      height: 1.5,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<DateTime> getDates() {
    List<DateTime> listDates = [];
    final currentDate = DateTime.now();
    listDates.add(currentDate);
    for (var i = 0; i < 719; i++) {
      final decrescentDate = currentDate.subtract(
        Duration(days: i + 1),
      );
      listDates.add(decrescentDate);
    }
    return listDates;
  }
}