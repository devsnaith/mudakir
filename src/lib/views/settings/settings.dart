import 'package:flutter/material.dart';
import 'package:mudakir/services/app_version.dart';
import 'package:mudakir/views/settings/app/settings_app.dart';
import 'package:mudakir/views/settings/location/settings_location.dart';
import 'package:mudakir/views/settings/theme/settings_appearance.dart';

import 'package:mudakir/views/settings/localization/settings_localization.dart';
import 'package:mudakir/views/settings/widgets/settings_appbar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    
    Locale? locale = AppVersion.data!.containsKey('preferredLocale') 
      ? Locale(AppVersion.data!.getString('preferredLocale')!) : null;
    
    return Localizations.override(
      context: context,
      locale: locale,
      child: Scaffold(
        appBar: SettingsAppbar(),
        body: LayoutBuilder(builder: (context, constraints) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.infinity, 
            height: constraints.maxHeight,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingsLocalizationGroup(() => setState(() {})),
                  SettingsAppearanceGroup(),
                  SettingsLocationGroup(),
                  SettingsAppGroup(),
                ],
              ),
            ),
          ),
        )),
      ),  
    );
  }

}