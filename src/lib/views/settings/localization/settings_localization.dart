import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mudakir/public/widgets/app_label.dart';
import 'package:mudakir/views/settings/localization/settings_click_format_button.dart';
import 'package:mudakir/views/settings/localization/settings_language_button.dart';

class SettingsLocalizationGroup extends StatelessWidget {
  
  final VoidCallback onChange;
  const SettingsLocalizationGroup(this.onChange, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextLabel.titledGroup(
      groupName: AppLocalizations.of(context)!.settings_localization_group_label,
      children: [
        SettingsLanguageButton(onChange),
        SettingsClickFormatButton(onChange),
      ]
    );
  }

}