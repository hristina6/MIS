// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/exam_schedule_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Exam Schedule',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExamScheduleScreen(),
    );
  }
}
