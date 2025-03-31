
import 'package:flutter/material.dart';
import 'package:positioned_transition/widgets.dart';

import 'data.dart';

class DraggableSchedule extends StatefulWidget {
  const DraggableSchedule({super.key});

  @override
  State<DraggableSchedule> createState() => _DraggableScheduleState();
}

class _DraggableScheduleState extends State<DraggableSchedule> {
  @override
  void initState() {
    super.initState();
    Schedule? prev;
    for (var schedule in schedules) {
      schedule.prev = prev;
      if (prev != null) {
        prev.next = schedule;
      }
      prev = schedule;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: List.generate(
            matches.length,
                (index) => Draggable<Match>(
              data: matches[index],
              childWhenDragging: Text(matches[index].match, style: TextStyle(fontSize: 20, color: Colors.grey)),
              feedback: Text(
                matches[index].match,
                style: TextStyle(fontSize: 20, color: matches[index].selected ? Colors.transparent : Colors.black),
              ),
              child: Text(
                matches[index].match,
                style: TextStyle(fontSize: 20, color: matches[index].selected ? Colors.grey : Colors.black),
              ),
            ),
          ),
        ),
        const SizedBox(height: 128),
        Column(
          children: List.generate(
            schedules.length,
                (index) => InkWell(
              onTap: () {
                setState(() {
                  schedules[index].match?.selected = !schedules[index].match!.selected;
                  schedules[index].match?.schedule = null;
                  schedules[index].match = null;
                });
              },
              child: DragTarget<Match>(
                builder: (BuildContext context, List<dynamic> accepted, List<dynamic> rejected) {
                  return schedules[index].match == null
                      ? PrintSchedule(time: schedules[index].startTime)
                      : PrintScheduleMatch(
                    tour: schedules[index].match!.tour,
                    time: schedules[index].startTime,
                    match: matches[index].match,
                    // проверка на выполнение условий
                    isValid: schedules[index].isValid,
                  );
                },
                onWillAcceptWithDetails: (detail) {
                  /*
                  return schedules[index].match == null &&
                      schedules[index].isTimeValid(detail.data) &&
                      schedules[index].isNeighbourValid(detail.data);
                   */
                  // можно назначить на любое время без проверки выполнения условий
                  return schedules[index].match == null;
                },
                onLeave: (data) {},
                onMove: (details) {},
                onAcceptWithDetails: (details) {
                  setState(() {
                    schedules[index].match = details.data;
                    details.data.schedule = schedules[index];
                    details.data.selected = !details.data.selected;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
