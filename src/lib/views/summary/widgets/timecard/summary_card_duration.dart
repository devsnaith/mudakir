import 'package:adhan/adhan.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mudakir/public/app_fonts.dart';
import 'package:mudakir/public/utils/clock_utils.dart';
import 'package:mudakir/services/clock_service.dart';
import 'package:mudakir/services/prayertime_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SummaryCardDuration extends StatelessWidget {
  
  final ClockService clock;
  final PrayertimeService prayertime;
  const SummaryCardDuration(this.clock, this.prayertime, {super.key});
  
  @override
  Widget build(BuildContext context) {

    bool isFriday = DateTime.now().weekday == DateTime.friday; 

    TextStyle indicatorStyle = AppFonts.summaryCardClockStyle(
      Theme.of(context).colorScheme.surface, FontWeight.bold, 20 
    );

    prayertime.calculateNextPrayerCountdown(clock.getDatetime());
    Duration? nextPrayerDuration = prayertime.getNextPrayerDuration();
    Prayer? nextPrayer = prayertime.getThePrayerOfTheNextPrayerDuration();
    if(nextPrayerDuration == null || nextPrayer == null) {
      return SizedBox.shrink();
    }

    DateTime time = ClockUtils.durationToDateTime(nextPrayerDuration);
    int minutes = time.minute;
    int hours = time.hour;

    if(minutes <= 0 && hours <= 0) {
      return Text(AppLocalizations.of(context)!.summary_card_time_begin_message(prayertime.getLocalizedTimeName(nextPrayer, context, isFriday)), style: indicatorStyle);
    }
    
    String strBuilder = hours > 0 ? "${AppLocalizations.of(context)!.summary_card_plural_hour(hours)}${minutes > 0 ? " ${AppLocalizations.of(context)!.summary_card_and} " : ""}" : "";
    
    int minute = minutes;
    String minuteAsText = AppLocalizations.of(context)!.summary_card_plural_minute(minutes);
                               
    if(AppLocalizations.of(context)!.localeName == "ar" && minute > 10) {
      minuteAsText = "$minutes دقيقة";
    }

    if(minutes > 0) {
      strBuilder += minuteAsText;
    }
    
    strBuilder += " ${AppLocalizations.of(context)!.summary_card_until} ";
    strBuilder += prayertime.getLocalizedTimeName(nextPrayer, context, isFriday);
    
    return AutoSizeText(strBuilder, maxLines: 2, textScaleFactor: 1, style: indicatorStyle);
  }

}