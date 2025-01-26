import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mudakir/public/app_fonts.dart';
import 'package:mudakir/services/clock_service.dart';

class SummaryCardDate extends StatelessWidget {
  
  final ClockService clock;
  const SummaryCardDate(this.clock, {super.key});

  @override
  Widget build(BuildContext context) {

    TextStyle dateStyle = AppFonts.summaryCardClockStyle(
      Theme.of(context).colorScheme.surface, FontWeight.bold, 13 
    );
    
    return Localizations.override(
      context: context,
      locale: Locale("en"),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 25,
        children: [
          AutoSizeText(clock.format(), maxLines: 1, textScaleFactor: 1, style: dateStyle),
          AutoSizeText(clock.hijriFormat(), maxLines: 1, textScaleFactor: 1, style: dateStyle),   
        ],
      ),
    );
  }
  
}