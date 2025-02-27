import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mudakir/services/app_version.dart';

class SettingsVersionButton extends StatelessWidget {
  
  const SettingsVersionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.info),
      title: Text(AppLocalizations.of(context)!.settings_application_information_version),
      subtitle: Text(AppVersion.version()),
    );
  }
}