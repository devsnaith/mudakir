
import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mudakir/services/app_version.dart';

class PrayertimeService with ChangeNotifier {
  
  final List<Prayer> _prayerEnum = [];
  final Map<Prayer, DateTime> _listOfTimes = {};

  int _cachedDayNumber = -1;
  PrayerTimes? _prayerTimes;

  Duration? _nextCalculatedTime;
  Prayer? _nextCalculatedPrayer;

  PrayertimeService() {
    Prayer.values.map((prayer) {
      if (prayer == Prayer.none) {
        return;
      }
      _prayerEnum.add(prayer);
    }).toList();
    AppVersion.log("PrayertimeService", "Initialized -> _prayerEnum: ${_prayerEnum.toString()}");    
  }

  PrayerTimes? calculate(DateTime date, Position location) {
    if(_cachedDayNumber != date.day) {
      AppVersion.log("PrayertimeService", "(date.day != _cachedDayNumber) -> Calculating...");
      Coordinates coordinates = Coordinates(location.latitude,location.longitude);
      CalculationParameters calculation = CalculationMethod.umm_al_qura.getParameters();
      _prayerTimes = PrayerTimes.today(coordinates, calculation);
      
      Prayer.values.map((time) {
        switch (time) {
          case Prayer.fajr: _listOfTimes[Prayer.fajr]=_prayerTimes!.fajr; break;
          case Prayer.sunrise: _listOfTimes[Prayer.sunrise]=_prayerTimes!.sunrise; break;
          case Prayer.dhuhr: _listOfTimes[Prayer.dhuhr]=_prayerTimes!.dhuhr; break;
          case Prayer.asr: _listOfTimes[Prayer.asr]=_prayerTimes!.asr; break;
          case Prayer.maghrib: _listOfTimes[Prayer.maghrib]=_prayerTimes!.maghrib; break;
          case Prayer.isha: _listOfTimes[Prayer.isha]=_prayerTimes!.isha; break;
          default: break;
        }
      }).toList();
      
      AppVersion.log("PrayertimeService", "Calculation Completed -> ${_listOfTimes.toString()}");    
      _cachedDayNumber = date.day;
    }
    ChangeNotifier();
    return _prayerTimes;
  }

  String getLocalizedTimeName(Prayer time, BuildContext context, bool isFriday) {
    switch (time) {
      case Prayer.fajr: return AppLocalizations.of(context)!.global_fajr_time;
      case Prayer.sunrise: return AppLocalizations.of(context)!.global_sunrise_time;
      case Prayer.dhuhr: return AppLocalizations.of(context)!.global_dhuhr_time(isFriday.toString());
      case Prayer.asr: return AppLocalizations.of(context)!.global_asr_time;
      // case IslamicTimes.sunset: return AppLocalizations.of(context)!.global_sunset_time;
      case Prayer.maghrib: return AppLocalizations.of(context)!.global_maghrib_time;
      case Prayer.isha: return AppLocalizations.of(context)!.global_isha_time;
      // case IslamicTimes.imsak: return AppLocalizations.of(context)!.global_imsak_time;
      // case IslamicTimes.midnight: return AppLocalizations.of(context)!.global_midnight_time;
      // case IslamicTimes.firstthird: return AppLocalizations.of(context)!.global_firstthird_time;
      // case IslamicTimes.lastthird: return AppLocalizations.of(context)!.global_lastthird_time;
      default: return "----";
    }
  }

  List<Prayer> get prayers => _prayerEnum;
  Map<Prayer, DateTime> getPrayerTimesAsList() => _listOfTimes;
  PrayerTimes? getCalculatedTimes() => _prayerTimes;

  Duration? getNextPrayerDuration() => _nextCalculatedTime;
  Prayer? getThePrayerOfTheNextPrayerDuration() => _nextCalculatedPrayer;

  String getLocalizedTime(Prayer time, BuildContext context) {
    String clock = DateFormat((AppVersion.data!.getBool("Using24Clock") ?? false) ? "Hm" : "jm").format(_listOfTimes[time]!);
    clock = clock.replaceAll("PM", AppLocalizations.of(context)!.global_post_meridiem_time(""));
    clock = clock.replaceAll("AM", AppLocalizations.of(context)!.global_ante_meridiem_time(""));
    return clock;
  }

  void calculateNextPrayerCountdown(DateTime date) {

    if(_prayerTimes == null) {
      return;
    }

    for(int index = 0 ; index < _prayerEnum.length ; index++) {
      DateTime future = _prayerTimes!.timeForPrayer(_prayerEnum[index])!;

      if(date.isAfter(future)) {
        continue;
      }

      _nextCalculatedTime = future.difference(date);
      _nextCalculatedPrayer = _prayerEnum[index];
      break;
    }

    ChangeNotifier();
  
  }

}
