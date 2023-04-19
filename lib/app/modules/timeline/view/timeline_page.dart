import 'package:flutter/material.dart';
import 'package:verify/app/modules/timeline/view/widgets/date_carrousel_widget.dart';
import 'package:verify/app/shared/widgets/custom_navigation_bar.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key});

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timeline'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          DateCarrouselWidget(
            onDateSelected: (date) {
              print(date);
            },
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
