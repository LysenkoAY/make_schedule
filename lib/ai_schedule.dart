import 'package:flutter/material.dart';

import 'ai/ai_data.dart';

class AiSchedule extends StatefulWidget {
  const AiSchedule({super.key});

  @override
  _AiScheduleState createState() => _AiScheduleState();
}

class _AiScheduleState extends State<AiSchedule> {
  late Schedule _schedule;

  static const int matchDuration = 70;
  static const int start = 13;
  static const int stop = 21;

  bool isStadiumOpen(TimeOfDay time) {
    return time.hour >= start && time.hour < stop;
  }

  bool isMatchTimeValid(TimeOfDay startTime) {
    final endTime = _addMinutes(startTime, matchDuration);
    return isStadiumOpen(startTime) && isStadiumOpen(endTime);
  }

  TimeOfDay _addMinutes(TimeOfDay time, int minutes) {
    int totalMinutes = time.hour * 60 + time.minute + minutes;
    int newHour = totalMinutes ~/ 60;
    int newMinute = totalMinutes % 60;
    return TimeOfDay(hour: newHour, minute: newMinute);
  }

  bool isTeamAvailable(Team team, List<Match> matches, TimeOfDay startTime) {
    for (var match in matches) {
      if (match.leftTeam == team || match.rightTeam == team) {
        final matchEndTime = _addMinutes(match.startTime!, matchDuration);
        if (startTime.hour < matchEndTime.hour ||
            (startTime.hour == matchEndTime.hour && startTime.minute < matchEndTime.minute)) {
          return false;
        }
      }
    }
    return true;
  }

  bool isTeamValidTime(Team team, TimeOfDay startTime) {
    return team.isTimeValid(startTime);
  }

  Schedule makeSchedule(List<Team> teams, List<Tour> Tours) {
    List<Tour> scheduledRounds = [];
    TimeOfDay currentTime = TimeOfDay(hour: start, minute: 0);

    for (var tour in Tours) {
      List<Match> scheduledMatches = [];
      for (var match in tour.matches) {
        bool matchScheduled = false;
        while (!matchScheduled) {
          if (isMatchTimeValid(currentTime) &&
              isTeamAvailable(match.leftTeam, scheduledMatches, currentTime) &&
              isTeamAvailable(match.rightTeam, scheduledMatches, currentTime)) {
            match.startTime = currentTime;
            scheduledMatches.add(match);
            currentTime = _addMinutes(currentTime, matchDuration);
            matchScheduled = true;
          } else {
            currentTime = _addMinutes(currentTime, 5);
            if (currentTime.hour >= stop) {
              return Schedule(tours: []);
            }
          }
        }
      }
      scheduledRounds.add(Tour(matches: scheduledMatches));
    }
    return Schedule(tours: scheduledRounds);
  }

  @override
  void initState() {
    super.initState();
    _schedule = makeSchedule(teams, rounds);
  }

  @override
  Widget build(BuildContext context) {
    return _schedule.tours.isNotEmpty
        ? ListView.builder(
            itemCount: _schedule.tours.length,
            itemBuilder: (context, roundIndex) {
              final tour = _schedule.tours[roundIndex];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Тур ${roundIndex + 1}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  ...tour.matches.map((match) {
                    return Text(
                        '${match.startTime!.format(context)} ${match.leftTeam.name} vs ${match.rightTeam.name}');
                  }),
                ],
              );
            },
          )
        : const SizedBox.shrink();
  }
}
