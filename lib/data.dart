class Team {
  final String name;
  final double startTime;
  final double endTime;

  Team({
    required this.name,
    required this.startTime,
    required this.endTime,
  });
}

List<Team> teams = [
  Team(name: 'Team A', startTime: 14, endTime: 18),
  Team(name: 'Team B', startTime: 13, endTime: 16),
  Team(name: 'Team C', startTime: 15, endTime: 20),
  Team(name: 'Team D', startTime: 14, endTime: 19),
  Team(name: 'Team E', startTime: 13.30, endTime: 17.30),
  Team(name: 'Team F', startTime: 16, endTime: 21),
];

class Match {
  late bool selected;
  late double position;
  final int tour;
  final Team leftTeam;
  final Team rightTeam;
  Schedule? schedule;

  Match({
    required this.selected,
    required this.position,
    required this.tour,
    required this.leftTeam,
    required this.rightTeam,
  });

  String get match => '${leftTeam.name} vs ${rightTeam.name}';
}

List<Match> matches = [
  Match(selected: false, position: 50, tour: 1, leftTeam: teams[0], rightTeam: teams[1]),
  Match(selected: false, position: 80, tour: 1, leftTeam: teams[2], rightTeam: teams[3]),
  Match(selected: false, position: 110, tour: 1, leftTeam: teams[4], rightTeam: teams[5]),
  Match(selected: false, position: 140, tour: 2, leftTeam: teams[0], rightTeam: teams[2]),
  Match(selected: false, position: 170, tour: 2, leftTeam: teams[1], rightTeam: teams[4]),
  Match(selected: false, position: 200, tour: 2, leftTeam: teams[3], rightTeam: teams[5]),
];

class Schedule {
  final double startTime;
  final double endTime;
  Match? match;
  final double position;
  Schedule? prev;
  Schedule? next;

  Schedule({required this.startTime, required this.endTime, required this.position});

  bool get isValid => isTimeValid(match!) && isNeighbourValid(match!);

  bool isTimeValid(Match match) {
    return startTime >= match.leftTeam.startTime &&
        endTime <= match.leftTeam.endTime &&
        startTime >= match.rightTeam.startTime &&
        endTime <= match.rightTeam.endTime;
  }

  bool isNeighbourValid(Match match) {
    bool result = true;
    if (prev != null &&
        prev?.match != null &&
        (prev?.match?.leftTeam.name == match.leftTeam.name ||
            prev?.match?.leftTeam.name == match.rightTeam.name ||
            prev?.match?.rightTeam.name == match.leftTeam.name ||
            prev?.match?.rightTeam.name == match.rightTeam.name)) {
      result = false;
    } else if (next != null &&
        next?.match != null &&
        (next?.match?.leftTeam.name == match.leftTeam.name ||
            next?.match?.leftTeam.name == match.rightTeam.name ||
            next?.match?.rightTeam.name == match.leftTeam.name ||
            next?.match?.rightTeam.name == match.rightTeam.name)) {
      result = false;
    }
    return result;
  }
}

List<Schedule> schedules = [
  Schedule(startTime: 13, endTime: 13.55, position: 500),
  Schedule(startTime: 14.10, endTime: 15.05, position: 530),
  Schedule(startTime: 15.20, endTime: 16.15, position: 560),
  Schedule(startTime: 16.30, endTime: 17.25, position: 590),
  Schedule(startTime: 17.40, endTime: 18.35, position: 620),
  Schedule(startTime: 18.50, endTime: 19.45, position: 650),
  Schedule(startTime: 20.00, endTime: 20.55, position: 680),
];
