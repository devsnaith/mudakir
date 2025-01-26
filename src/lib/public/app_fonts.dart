import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppFonts {
  static TextStyle appBarFontStyle(BuildContext context) {

    TextStyle style;
    if(AppLocalizations.of(context)!.localeName == "ar") {
      style = GoogleFonts.aBeeZee(
        fontWeight: FontWeight.bold,
        fontSize: 20
      );
    }else {
      style = GoogleFonts.lato(
        fontWeight: FontWeight.bold,
        fontSize: 20
      );
    }
    
    return style;
  }

  static Widget counter({String? prefix, int num = 00, String? suffix, TextStyle? style}) {
    return AnimatedFlipCounter(
      mainAxisAlignment: MainAxisAlignment.start,
      hideLeadingZeroes: false,
      fractionDigits: 0,
      wholeDigits: 2,
      suffix: suffix,
      prefix: prefix,
      textStyle: style,
      value: num,
    );
  }

  static TextStyle summaryCardClockStyle(Color color, FontWeight weight, double size) {
    return GoogleFonts.orbitron(color: color, fontWeight: weight, fontSize: size);
  }
}