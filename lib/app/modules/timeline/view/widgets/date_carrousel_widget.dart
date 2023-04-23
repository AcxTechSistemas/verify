import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:verify/app/modules/timeline/store/timeline_store.dart';
import 'package:verify/app/shared/extensions/date_time.dart';

class DateCarrouselWidget extends StatefulWidget {
  final void Function(DateTime date) onDateSelected;
  final ScrollController? controller;

  const DateCarrouselWidget({
    super.key,
    required this.onDateSelected,
    this.controller,
  });

  @override
  State<DateCarrouselWidget> createState() => _DateCarrouselWidgetState();
}

class _DateCarrouselWidgetState extends State<DateCarrouselWidget> {
  int currentSelect = 0;
  final store = Modular.get<TimelineStore>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final dates = _getDates();
    return Container(
      height: 85,
      color: colorScheme.onInverseSurface,
      child: ListView.builder(
        controller: widget.controller,
        shrinkWrap: true,
        reverse: true,
        itemCount: dates.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final isCurrentSelect = _currentSelect(dates, index);
          final formattedDate = _formattedDate(dates, index);
          return Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isCurrentSelect ? colorScheme.primary : null,
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                widget.onDateSelected(dates[index].toBrazilianTimeZone());
                setState(() {
                  currentSelect = index;
                });
              },
              child: Column(
                children: [
                  Text(
                    formattedDate,
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

  String _formattedDate(
    List<DateTime> dates,
    int index,
  ) {
    final year = dates[index].year.toString();
    final day = dates[index].day.toString();
    final month = DateFormat('MMM').format(dates[index]);
    return '$year\n$day-$month';
  }

  bool _currentSelect(
    List<DateTime> dates,
    int index,
  ) {
    final currentSelectedDate = DateTime(
      store.selectedDate.year,
      store.selectedDate.month,
      store.selectedDate.day,
    );
    final currentWidgetDate = DateTime(
      dates[index].year,
      dates[index].month,
      dates[index].day,
    );
    return currentSelectedDate == currentWidgetDate;
  }

  List<DateTime> _getDates() {
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
