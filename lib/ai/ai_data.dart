import 'package:flutter/material.dart';

class Team {
  final String name;
  final TimeOfDay start;
  final TimeOfDay stop;

  Team({
    required this.name,
    required this.start,
    required this.stop,
  });

  bool isTimeValid(TimeOfDay time) {
    return time.hour >= start.hour &&
        time.hour <= stop.hour &&
        time.minute >= start.minute &&
        time.minute <= stop.minute;
  }
}

class Match {
  final Team leftTeam;
  final Team rightTeam;
  TimeOfDay? startTime;

  Match({required this.leftTeam, required this.rightTeam, this.startTime});
}

class Tour {
  final List<Match> matches;

  Tour({required this.matches});
}

class Schedule {
  final List<Tour> tours;

  Schedule({required this.tours});
}

List<Team> teams = [
  Team(
      name: 'Team A',
      start: TimeOfDay(hour: 14, minute: 0),
      stop: TimeOfDay(hour: 18, minute: 0)),
  Team(
      name: 'Team B',
      start: TimeOfDay(hour: 13, minute: 0),
      stop: TimeOfDay(hour: 16, minute: 0)),
  Team(
      name: 'Team C',
      start: TimeOfDay(hour: 15, minute: 0),
      stop: TimeOfDay(hour: 20, minute: 0)),
  Team(
      name: 'Team D',
      start: TimeOfDay(hour: 14, minute: 0),
      stop: TimeOfDay(hour: 19, minute: 0)),
  Team(
      name: 'Team E',
      start: TimeOfDay(hour: 13, minute: 30),
      stop: TimeOfDay(hour: 17, minute: 30)),
  Team(
      name: 'Team F',
      start: TimeOfDay(hour: 16, minute: 0),
      stop: TimeOfDay(hour: 21, minute: 0)),
];
List<Tour> rounds = [
  Tour(matches: [
    Match(
        leftTeam: Team(
            name: 'Team A',
            start: TimeOfDay(hour: 14, minute: 0),
            stop: TimeOfDay(hour: 18, minute: 0)),
        rightTeam: Team(
            name: 'Team B',
            start: TimeOfDay(hour: 13, minute: 0),
            stop: TimeOfDay(hour: 16, minute: 0))),
    Match(
        leftTeam: Team(
            name: 'Team C',
            start: TimeOfDay(hour: 15, minute: 0),
            stop: TimeOfDay(hour: 20, minute: 0)),
        rightTeam: Team(
            name: 'Team D',
            start: TimeOfDay(hour: 14, minute: 0),
            stop: TimeOfDay(hour: 19, minute: 0))),
    Match(
        leftTeam: Team(
            name: 'Team E',
            start: TimeOfDay(hour: 13, minute: 30),
            stop: TimeOfDay(hour: 17, minute: 30)),
        rightTeam: Team(
            name: 'Team F',
            start: TimeOfDay(hour: 16, minute: 0),
            stop: TimeOfDay(hour: 21, minute: 0))),
  ]),
  Tour(matches: [
    Match(
        leftTeam: Team(
            name: 'Team A',
            start: TimeOfDay(hour: 14, minute: 0),
            stop: TimeOfDay(hour: 18, minute: 0)),
        rightTeam: Team(
            name: 'Team C',
            start: TimeOfDay(hour: 15, minute: 0),
            stop: TimeOfDay(hour: 20, minute: 0))),
    Match(
        leftTeam: Team(
            name: 'Team B',
            start: TimeOfDay(hour: 13, minute: 0),
            stop: TimeOfDay(hour: 16, minute: 0)),
        rightTeam: Team(
            name: 'Team E',
            start: TimeOfDay(hour: 13, minute: 30),
            stop: TimeOfDay(hour: 17, minute: 30))),
    Match(
        leftTeam: Team(
            name: 'Team D',
            start: TimeOfDay(hour: 14, minute: 0),
            stop: TimeOfDay(hour: 19, minute: 0)),
        rightTeam: Team(
            name: 'Team F',
            start: TimeOfDay(hour: 16, minute: 0),
            stop: TimeOfDay(hour: 21, minute: 0))),
  ]),
];
