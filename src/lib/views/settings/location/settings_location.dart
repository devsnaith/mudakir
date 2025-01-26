import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mudakir/public/widgets/app_label.dart';
import 'package:mudakir/services/location_service.dart';
import 'package:provider/provider.dart';

class SettingsLocationGroup extends StatefulWidget {
  
  const SettingsLocationGroup({super.key});

  @override
  State<SettingsLocationGroup> createState() => _SettingsLocationGroupState();
}

class _SettingsLocationGroupState extends State<SettingsLocationGroup> {


  @override
  Widget build(BuildContext context) {
    
    String lastSavedLocationDate = AppLocalizations.of(context)!.settings_location_no_saved_location;
    if(LocationService.gotSavedLocationData()){
      int microsecondsSinceEpoch = LocationService.getSavedLocationData()["capturetime"];
      DateTime date = DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);
      DateFormat format = DateFormat.yMd(AppLocalizations.of(context)!.localeName).add_jm();
      lastSavedLocationDate = AppLocalizations.of(context)!.settings_location_got_saved_location_indicator(format.format(date));
    }
    
    return Consumer<LocationService>(
      builder: (context, locationService, child) {
        return TextLabel.titledGroup(
          groupName: AppLocalizations.of(context)!.settings_location_group_label,
          children: [
            
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.mapLocationDot),
                    title: Text(AppLocalizations.of(context)!.settings_location_select_location),
                    subtitle: Text(lastSavedLocationDate),
                  ),
                ),
                IconButton(onPressed: () async {
                  context.push("/settings/location").then((value) {
                    Future.delayed(Duration(milliseconds: 500), () {
                      setState(() {});
                    });
                  });
                }, icon: Icon(Icons.gps_fixed))
              ],
            ),
        
            GestureDetector(
              onTap: () async {
                await locationService.removeSavedLocationData();
                setState(() {});
              },
              child: ListTile(
                enabled: LocationService.gotSavedLocationData(),
                leading: Icon(Icons.cleaning_services),
                title: Text(AppLocalizations.of(context)!.settings_location_clear_saved_location),
              ),
            ),
        
          ]
        );
      }
    );
  }
}