import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mudakir/services/clock_service.dart';
import 'package:mudakir/services/prayertime_service.dart';
import 'package:mudakir/views/summary/widgets/timecard/summary_card_clock.dart';
import 'package:mudakir/views/summary/widgets/timecard/summary_card_date.dart';
import 'package:mudakir/views/summary/widgets/timecard/summary_card_duration.dart';
import 'package:provider/provider.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key});

  @override
  Widget build(BuildContext context) {

    double horizontalMargin = 25;
    if(MediaQuery.of(context).orientation == Orientation.landscape) {
      horizontalMargin = 0;
    }

    return Card(          
      
      color: Theme.of(context).colorScheme.primary,
      clipBehavior: Clip.antiAlias,

      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin, 
        vertical: 15
      ),

      child: Stack(
        children: [

          Align(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(
              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.hardLight),
              alignment: Alignment.bottomCenter,
              "assets/svg/wave.svg", 
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            
            child: Consumer2<ClockService, PrayertimeService>(
              builder: (context, clock, prayertime, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
        
                    Flexible(child: SummaryCardClock(clock)),
                    Expanded(child: SummaryCardDuration(clock, prayertime)),
                    Flexible(child: SummaryCardDate(clock)),
                  
                  ]
                );
              }
            ),
          ),

        ]
      ),  
          
    );

  }
}