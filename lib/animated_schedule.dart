import 'dart:math';

import 'package:flutter/material.dart';
import 'package:positioned_transition/widgets.dart';

import 'data.dart';

class AnimatedSchedule extends StatefulWidget {
  const AnimatedSchedule({super.key});

  @override
  State<AnimatedSchedule> createState() => _AnimatedScheduleState();
}

class _AnimatedScheduleState extends State<AnimatedSchedule> {
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

  void matchMove(Match match) {
    if (!match.selected) {
      Schedule? _schedule;
      for (var schedule in schedules) {
        if (schedule.match == null) {
          if (schedule.isTimeValid(match) && schedule.isNeighbourValid(match)) {
            _schedule = schedule;
            break;
          }
        }
      }
      if (_schedule != null) {
        setState(() {
          _schedule?.match = match;
          match.schedule = _schedule!;
          match.selected = !match.selected;
        });
      }
    } else {
      setState(() {
        match.schedule?.match = null;
        match.schedule = null;
        match.selected = !match.selected;
      });
    }
  }

  Future<void> make() async {
    for (var match in matches) {
      if (match.selected) {
        matchMove(match);
        await Future.delayed(Duration(seconds: 1));
      }
    }
    for (var match in matches) {
      matchMove(match);
      await Future.delayed(Duration(seconds: 1));
    }
  }

  Future<void> makeRandom() async {
    for (var match in matches) {
      if (match.selected) {
        matchMove(match);
        await Future.delayed(Duration(seconds: 1));
      }
    }
    Random random = Random();
    int index;
    for (var i = 0; i < matches.length * 2; ++i) {
      index = random.nextInt(matches.length);
      if (index < matches.length && !matches[index].selected) {
        matchMove(matches[index]);
        await Future.delayed(Duration(seconds: 1));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilledButton(onPressed: make, child: Text('Создать')),
            FilledButton(onPressed: makeRandom, child: Text('Создать')),
          ],
        ),
        Stack(
          children: List.generate(
            matches.length,
            (index) => AnimatedPositioned(
              top: !matches[index].selected ? matches[index].position : matches[index].schedule?.position,
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: GestureDetector(
                onTap: () {
                  matchMove(matches[index]);
                },
                child: matches[index].selected
                    ? Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: PrintScheduleMatch(
                          tour: matches[index].tour,
                          time: matches[index].schedule!.startTime,
                          match: matches[index].match,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(matches[index].match, style: TextStyle(fontSize: 20)),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

