import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mudakir/public/widgets/app_dialog.dart';
import 'package:mudakir/public/widgets/app_indicator.dart';
import 'package:mudakir/services/location_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LocationHandler extends StatefulWidget {

  final bool useSavedLocationDataWhenLocationNotAvailable;
  final Widget Function(Position locationData) onLocationUpdate;
  
  const LocationHandler({
    this.useSavedLocationDataWhenLocationNotAvailable = false,
    required this.onLocationUpdate,
    super.key,
  });

  @override
  State<LocationHandler> createState() => _LocationHandler();
}

class _LocationHandler extends State<LocationHandler> {

  bool permissionRequested = false;
  Position? savedLocation;

  @override
  Widget build(BuildContext context) {
    
    if(LocationService.gotSavedLocationData()) {
      Map<String, dynamic> data = LocationService.getSavedLocationData();
      savedLocation = Position(
        longitude: data["longitude"], 
        latitude: data["latitude"], 
        timestamp: DateTime.fromMillisecondsSinceEpoch(data["capturetime"]),
        accuracy: 0,  altitude: 0, altitudeAccuracy: 0, heading: 0, 
        headingAccuracy: 0, speed: 0,  speedAccuracy: 0
      );
    }

    return SizedBox(
      
      child: Consumer<LocationService>( 
        builder: (context, location, child) {

          if (widget.useSavedLocationDataWhenLocationNotAvailable && savedLocation != null) {
            return widget.onLocationUpdate(savedLocation!);
          }

          if(!location.initialized()) {
            return SimpleIndicator();
          }

          if(!location.serviceEnabled) {
            return ListTileButton(
              icon: Icons.gps_off, 
              title: AppLocalizations.of(context)!.msg_location_service_disabled_title, 
              description: AppLocalizations.of(context)!.msg_location_service_disabled_description, 
              btnText: AppLocalizations.of(context)!.msg_request_location_enable_button_name, 
              onPressed: () async {
                await location.requestService();
                location.updateAndNotify();
              },
            );
          }
          
          if (!location.hasPermission) {
            
            if(permissionRequested) {
              return ListTileButton(
                icon: FontAwesomeIcons.locationPinLock, 
                title: AppLocalizations.of(context)!.msg_location_permission_denied_title, 
                description: AppLocalizations.of(context)!.msg_location_permission_denied_description, 
                btnText: AppLocalizations.of(context)!.msg_request_location_permission_again_button_name, 
                onPressed: () async {
                  permissionRequested = false;
                  location.updateAndNotify();
                },
              );
            }

            Future.delayed(Duration(seconds: 1), () async {

              if(permissionRequested){
                return;
              }

              permissionRequested = true;
              bool permissionRequest = false;
              await AppDialog.dialogGrantDenyOptions(
                context, 
                Icon(Icons.gps_fixed), 
                AppLocalizations.of(context)!.dialogs_location_permission_request_title, 
                AppLocalizations.of(context)!.dialogs_location_permission_request_description, 
                AppLocalizations.of(context)!.dialogs_location_permission_request_grant_button_name, 
                AppLocalizations.of(context)!.dialogs_location_permission_request_deny_button_name,
                onGrant: () => permissionRequest = true,
              );
              if(permissionRequest) {
                await location.requestPermission();
              }
              await location.updateAndNotify();
              permissionRequested = true;

            });
            
            return SimpleIndicator();

          }

          if (location.hasData()) {
            return widget.onLocationUpdate(location.locationData!);
          }

          return SimpleIndicator();
        },
      ),
    );
  }
}

class ListTileButton extends StatelessWidget {

  final String title;
  final String description;

  final IconData icon;
  final String btnText;

  final VoidCallback onPressed;

  const ListTileButton({
    super.key, 
    required this.icon,
    required this.title,
    required this.description,
    required this.btnText,
    required this.onPressed,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          subtitle: Text(description),
        ),
        
        FilledButton.tonal(
          onPressed: () => onPressed.call(),
          child: Text(btnText),
        ),

      ]
    );
  }

}