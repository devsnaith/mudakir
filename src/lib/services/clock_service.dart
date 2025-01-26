import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:mudakir/services/app_version.dart';

class ClockService with ChangeNotifier {

  DateTime _datetime = DateTime.now();
  HijriCalendar _hijriDatetime = HijriCalendar.now();

  DateTime getDatetime() => _datetime; 
  HijriCalendar getHijriDatetime() => _hijriDatetime; 

  ClockService() {
    clockLoop();
  }

  Future<void> clockLoop() async {

    AppVersion.log("ClockService", "Clock Loop has started!");

    while (true) {
      await Future.delayed(Duration(seconds: 1));
      _datetime = DateTime.now();
      _hijriDatetime = HijriCalendar.now();
      notifyListeners();
    }
  }

  bool isNight() => _datetime.hour > 12;
  int getHour(bool as12Mode) {
    
    if(!as12Mode){
      return _datetime.hour;
    }
    
    String hour12Mode = DateFormat('j').format(_datetime);
    
    /* Get only the hour without PM or AM */
    hour12Mode = hour12Mode.split(" ")[0];
    
    /* FallBack to 24 Mode when the parse fail */
    return int.tryParse(hour12Mode) ?? _datetime.hour;

  }

  int getMinute() => _datetime.minute;
  int getSeconds() => _datetime.second;
  int getMillisecondsSinceEpoch() => _datetime.millisecondsSinceEpoch;

  String format() => DateFormat("d - MMMM - y").format(_datetime);
  String hijriFormat() => _hijriDatetime.toFormat("dd - MMMM - yyyy");

}