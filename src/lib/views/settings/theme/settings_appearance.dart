import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mudakir/public/widgets/app_label.dart';
import 'package:mudakir/views/settings/theme/settings_app_color_button.dart';
import 'package:mudakir/views/settings/theme/settings_brightness_button.dart';

class SettingsAppearanceGroup extends StatelessWidget {
  
  const SettingsAppearanceGroup({super.key});

  @override
  Widget build(BuildContext context) {  
    return TextLabel.titledGroup(
      groupName: AppLocalizations.of(context)!.settings_appearance_group_label,
      children: [
        SettingsAppColorButton(),
        SettingsBrightnessButton(),
      ]
    );
  }

}