import 'package:flutter/material.dart';
import 'package:positioned_transition/widgets.dart';

import 'ai_schedule.dart';
import 'animated_schedule.dart';
import 'data.dart';
import 'draggable_schedule.dart';

void main() => runApp(
      const ScheduleApp(),
    );

class ScheduleApp extends StatelessWidget {
  const ScheduleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Расписание турнира'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Animated'),
              Tab(text: 'Draggable'),
              Tab(text: 'Algorithm'),
            ],
          ),
        ),
        body: TabBarView(children: [
          AnimatedSchedule(),
          DraggableSchedule(),
          AiSchedule(),
        ]),
      ),
    );
  }
}

//AIzaSyCJHKMVnBlDx7R52LmIVFFCsDKW4LY7SqY