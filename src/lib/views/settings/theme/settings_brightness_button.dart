import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class SettingsBrightnessButton extends StatelessWidget {
  const SettingsBrightnessButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SegmentedButton<AdaptiveThemeMode>(
        selected: {AdaptiveTheme.of(context).mode},
        onSelectionChanged: (Set<AdaptiveThemeMode> theme) {
          AdaptiveTheme.of(context).setThemeMode(theme.first);
        },
        
        segments: <ButtonSegment<AdaptiveThemeMode>>[
                                
        ButtonSegment(
          value: AdaptiveThemeMode.system,
          icon: Icon(Icons.brightness_auto),
          label: Text(AppLocalizations.of(context)!.settings_appearance_system_brightness),
        ),

        ButtonSegment(
          icon: Icon(Icons.light_mode),
          value: AdaptiveThemeMode.light,
          label: Text(AppLocalizations.of(context)!.settings_appearance_light_brightness),
        ),

        ButtonSegment(
          icon: Icon(Icons.dark_mode),
          value: AdaptiveThemeMode.dark,
          label: Text(AppLocalizations.of(context)!.settings_appearance_dark_brightness),
        ),
      
      ]),
    );
  }
  
}