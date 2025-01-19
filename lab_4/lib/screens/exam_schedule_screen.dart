// lib/screens/exam_schedule_screen.dart

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/exam_schedule.dart';

class ExamScheduleScreen extends StatefulWidget {
  @override
  _ExamScheduleScreenState createState() => _ExamScheduleScreenState();
}

class _ExamScheduleScreenState extends State<ExamScheduleScreen> {
  late Map<DateTime, List<ExamSchedule>> _events;
  late List<ExamSchedule> _selectedEvents;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _events = {};
    _selectedEvents = _getEventsForDay(_selectedDay);
  }


  final List<ExamSchedule> examSchedules = [
    ExamSchedule(
      course: "Mathematics",
      date: DateTime(2025, 1, 25),
      time: "10:00 AM",
      location: "Building A, Room 101",
    ),
    ExamSchedule(
      course: "Physics",
      date: DateTime(2025, 1, 26),
      time: "12:00 PM",
      location: "Building B, Room 201",
    ),
    ExamSchedule(
      course: "Computer Science",
      date: DateTime(2025, 1, 27),
      time: "02:00 PM",
      location: "Building C, Room 303",
    ),
  ];


  List<ExamSchedule> _getEventsForDay(DateTime day) {
    return examSchedules
        .where((examSchedule) =>
    examSchedule.date.year == day.year &&
        examSchedule.date.month == day.month &&
        examSchedule.date.day == day.day)
        .toList();
  }

  Widget _buildEventList() {
    return ListView.builder(
      itemCount: _selectedEvents.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedEvents[index].course,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "${_selectedEvents[index].date.toLocal().toString().split(' ')[0]} at ${_selectedEvents[index].time}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Location: ${_selectedEvents[index].location}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exam Schedule"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2025, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: _selectedDay,
            calendarFormat: CalendarFormat.month,
            eventLoader: (day) {
              return _getEventsForDay(day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _selectedEvents = _getEventsForDay(selectedDay);
              });
            },
          ),
          Expanded(
            child: _buildEventList(),
          ),
        ],
      ),
    );
  }
}
