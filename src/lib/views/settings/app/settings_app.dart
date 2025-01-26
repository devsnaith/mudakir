import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mudakir/public/widgets/app_label.dart';
import 'package:mudakir/views/settings/app/settings_version.dart';

class SettingsAppGroup extends StatelessWidget {
  
  const SettingsAppGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return TextLabel.titledGroup(
      groupName: AppLocalizations.of(context)!.settings_application_information_label,
      children: [
        SettingsVersionButton()
      ]
    );
  }

}