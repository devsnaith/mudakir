import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mudakir/services/app_version.dart';

class SettingsClickFormatButton extends StatefulWidget {
  
  final VoidCallback onChange;
  const SettingsClickFormatButton(this.onChange, {super.key});

  @override
  State<SettingsClickFormatButton> createState() => _SettingsClickFormatButtonState();
}

class _SettingsClickFormatButtonState extends State<SettingsClickFormatButton> {

  void changeClockFormat(bool currentValue) async {

    bool newValue = !currentValue;
    await AppVersion.data!.setBool("Using24Clock", newValue);

    AppVersion.log("SettingsClickFormatButton", 
      "Clock is now displayed in ${newValue ? "24" : 12} format"
    );
    
    widget.onChange.call();
  }

  @override
  Widget build(BuildContext context) {
    
    bool f24Clock = AppVersion.data!.getBool('Using24Clock') ?? false;

    String subtitle = AppLocalizations.of(context)!.settings_clock_format_12_mode_description;
    if(f24Clock) {
      subtitle = AppLocalizations.of(context)!.settings_clock_format_24_mode_description;
    } 

    return Row(
      children: [

        Expanded(
          child: ListTile(
            leading: Icon(FontAwesomeIcons.clock),
            title: Text(AppLocalizations.of(context)!.settings_clock_format_btn_title),
            subtitle: Text(subtitle),
          ),
        ),

        Switch(
          onChanged: (value) => changeClockFormat(f24Clock),
          value: f24Clock, 
        ),

      ],
    );
  }
}