import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrintScheduleMatch extends StatelessWidget {
  const PrintScheduleMatch({
    super.key,
    required this.time,
    required this.tour,
    required this.match,
    this.isValid,
  });

  final int tour;
  final double time;
  final String match;
  final bool? isValid;

  @override
  Widget build(BuildContext context) {
    final color = isValid == null ? Colors.black : isValid! ? Colors.black : Colors.red;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(time.truncate().toString(), style: TextStyle(fontSize: 20, color: color)),
        Text(
          NumberFormat('.00').format((time - time.truncate())),
          style: TextStyle(fontSize: 12, color: color),
        ),
        const SizedBox(width: 16),
        Text('Тур $tour', style: TextStyle(fontSize: 20, color: color)),
        const SizedBox(width: 16),
        Text(match, style: TextStyle(fontSize: 20, color: color)),
      ],
    );
  }
}

class PrintSchedule extends StatelessWidget {
  const PrintSchedule({
    super.key,
    required this.time,
  });

  final double time;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(time.truncate().toString(), style: TextStyle(fontSize: 20)),
        Text(
          NumberFormat('.00').format((time - time.truncate())),
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
