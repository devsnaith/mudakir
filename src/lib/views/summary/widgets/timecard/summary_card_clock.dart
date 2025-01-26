import 'package:flutter/material.dart';
import 'package:mudakir/public/app_fonts.dart';
import 'package:mudakir/services/app_version.dart';
import 'package:mudakir/services/clock_service.dart';

class SummaryCardClock extends StatefulWidget {
  
  final ClockService clock;
  const SummaryCardClock(this.clock, {super.key});

  @override
  State<SummaryCardClock> createState() => _SummaryCardClockState();
}

class _SummaryCardClockState extends State<SummaryCardClock> {
  
  @override
  Widget build(BuildContext context) {

    TextStyle clockStyle = AppFonts.summaryCardClockStyle(
      Theme.of(context).colorScheme.surface, FontWeight.bold, 32, 
    );


    return LayoutBuilder(
      builder: (context, size) {
        return Localizations.override(
          locale: Locale("en"),
          context: context,
          
          child: SizedBox(
            width: size.maxWidth,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(          
                
                children: [
                  
                  AppFonts.counter(style: clockStyle, num: widget.clock.getHour(!(AppVersion.data!.getBool("Using24Clock") ?? false)), suffix: " : "),
                  AppFonts.counter(style: clockStyle, num: widget.clock.getMinute(), suffix: " : "),
                  AppFonts.counter(style: clockStyle, num: widget.clock.getSeconds()),
                
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(widget.clock.isNight() ? Icons.nightlight : Icons.sunny, color: Theme.of(context).colorScheme.surface, size: 32),
                  ),
                
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}