import 'package:adhan/adhan.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mudakir/public/app_fonts.dart';
import 'package:mudakir/public/widgets/app_indicator.dart';
import 'package:mudakir/services/clock_service.dart';
import 'package:mudakir/services/prayertime_service.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class PrayerTimesList extends StatefulWidget {

  final Position location;
  const PrayerTimesList(this.location, {super.key});

  @override
  State<PrayerTimesList> createState() => _PrayerTimesListState();
}

class _PrayerTimesListState extends State<PrayerTimesList> {

  @override
  Widget build(BuildContext context) {

    return Consumer2<ClockService, PrayertimeService>(
      builder: (context, clock, prayertime, child) {    

        PrayerTimes? times = prayertime.calculate(clock.getDatetime(), widget.location);

        if (times == null) {  
          return LayoutBuilder(builder: (context, constraints) {
            return SimpleIndicator(indicator: Indicator.values[12]);
          });
        }

        return Padding(
          
          padding: const EdgeInsets.symmetric(
            horizontal: 16
          ),

          child: GridView.builder(
            
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 90,
              mainAxisSpacing: 16
            ),

            itemCount: prayertime.prayers.length,
            itemBuilder: (context, index) {

              Prayer type = prayertime.prayers[index];
              
              bool isFriday = DateTime.now().weekday == DateTime.friday;
              String localizedName = prayertime.getLocalizedTimeName(type, context, isFriday);
              String localizedTime = prayertime.getLocalizedTime(type, context);

              Color cardColor = Colors.transparent;
              Color textColor = Theme.of(context).colorScheme.primary;
              if(times.nextPrayer() == type) {
                cardColor = Theme.of(context).colorScheme.primary;
                textColor = Theme.of(context).colorScheme.surface;
              }

              return Container(

                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),

                margin: EdgeInsets.all(10),

                child: Center(
                  child: ListTile(
                    title: AutoSizeText(localizedName, textScaleFactor: 1, style: AppFonts.summaryCardClockStyle(textColor, FontWeight.bold, 18)),
                    subtitle: AutoSizeText(localizedTime, textScaleFactor: 1, style: AppFonts.summaryCardClockStyle(textColor, FontWeight.bold, 16)),
                  ),
                ),
              );
          
            },
          ),
        );

      }
    );

  }

}
