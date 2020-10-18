import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List <dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  Map<String,dynamic> encodeMap (Map<DateTime, dynamic> map){
    Map <String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime,dynamic> decodeMap (Map<String, dynamic> map){
    Map <DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();

    final _selectedDay = DateTime.now();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents =  [];
    initPrefs();
  }

  initPrefs () async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List <dynamic>>.from(decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  //    backgroundColor: Color(0xFF111328),
      appBar: AppBar(
        title: Text("Calendar"),
        backgroundColor: Color(0xFF191c3a),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            _buildTableCalendar(),
            const SizedBox(
              height: 8,
            ),
           ..._selectedEvents.map((e) => ListTile(
             title: Text(e),
           ))
           // _buildButtons(),
          // _buildEventList()

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddDialog,
      ),
    );
  }

  _showAddDialog(){
    showDialog(
        context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: _eventController,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("Save"),
            onPressed: () {
              if(_eventController.text.isEmpty) return;
              setState(() {
                if(_events[_controller.selectedDay] != null) {
                  _events[_controller.selectedDay].add(_eventController.text);
                }else{
                  _events[_controller.selectedDay] = [
                    _eventController.text
                  ];
                }
                prefs.setString("events", json.encode(encodeMap(_events)));
                _eventController.clear();
                Navigator.pop(context);
              });
            },
          )
        ],
      )
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      events: _events,
      calendarStyle: CalendarStyle(
          todayColor: Color(0xFF282611)
      ),
      calendarController: _controller,
      onDaySelected: (date, events){
        setState(() {
          _selectedEvents = events;
        });
      },
//      headerStyle: HeaderStyle(
//        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15)
//      ),
    );
  }

  Widget _buildButtons() {
    final dateTime = _events.keys.elementAt(_events.length - 2);

    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('Month'),
              onPressed: () {
                setState(() {
                  _controller.setCalendarFormat(CalendarFormat.month);
                });
              },
            ),
            RaisedButton(
              child: Text('2 weeks'),
              onPressed: () {
                setState(() {
                  _controller.setCalendarFormat(CalendarFormat.twoWeeks);
                });
              },
            ),
            RaisedButton(
              child: Text('Week'),
              onPressed: () {
                setState(() {
                  _controller.setCalendarFormat(CalendarFormat.week);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        RaisedButton(
          child: Text('Set day ${dateTime.day}-${dateTime.month}-${dateTime.year}'),
          onPressed: () {
            _controller.setSelectedDay(
              DateTime(dateTime.year, dateTime.month, dateTime.day),
              runCallback: true,
            );
          },
        ),
      ],
    );
  }

  Widget _buildEventList() {
    print("Selected Events "+ _selectedEvents.toString() );
    if(_selectedEvents != null){
      return Container(
        height: 500,
        child: ListView(
          children: _selectedEvents
              .map((event) => Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.8),
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ListTile(
              title: Text(event.toString()),
              onTap: () => print('$event tapped!'),
            ),
          ))
              .toList(),
        ),
      );
    }
  }
}
