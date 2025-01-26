import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:mudakir/public/widgets/handlers/location_handler.dart';
import 'package:mudakir/services/app_version.dart';
import 'package:mudakir/services/location_service.dart';
import 'package:mudakir/views/settings/location/settings_location_appbar.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsLocationSelector extends StatefulWidget {
  const SettingsLocationSelector({super.key});

  @override
  State<SettingsLocationSelector> createState() => _SettingsLocationSelectorState();
}

class _SettingsLocationSelectorState extends State<SettingsLocationSelector> {

  MapCamera? camera;
  LatLng? point, center, force;
  bool followPoint = false;

  final _autoPickKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    
    if (followPoint && point != null) {
      followPoint = false;
      force = point;
    }else {
      force = null;
    }

    return Consumer<LocationService>(
      builder: (context, locationService, child) {
        return Scaffold(
          key: GlobalKey(),
          appBar: LocationAppbar(),
          body: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Column(
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8
                    ),
                    child: LocationHandler(key: _autoPickKey, onLocationUpdate: (locationData) {
                      if(point == null) {
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                         setState(() {}); 
                        });
                        point = LatLng(locationData.latitude, locationData.longitude);
                        followPoint = true;
                      }
                      return Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text("Latitude"),
                              subtitle: Text(point!.latitude.toString()),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text("Longitude"),
                              subtitle: Text(point!.longitude.toString()),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
              
                  Expanded(
                    child: FlutterMap(
                      key: GlobalKey(),
                      mapController: MapController(),
                      options: MapOptions(
                        
                        initialZoom: camera != null ? camera!.zoom : 5,
                        initialRotation: camera != null ? camera!.rotation : 0,
                        initialCenter: force ?? center ?? LatLng(24.303923, 44.625972), // Center the map over London
                        
                        onTap: (tapPosition, point) {
                          setState(() => this.point = point);
                        },
                        
                        onMapEvent: (p0) {
                          camera = p0.camera;
                          center = camera!.center;
                        },
              
                      ),
              
                      children: [
                        
                        TileLayer(
                          key: GlobalKey(),
                          userAgentPackageName: AppVersion.category(),
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'
                        ),
              
                        RichAttributionWidget(
                          key: GlobalKey(),
                          attributions: [
                            TextSourceAttribution(
                              onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')), // (external)
                              'OpenStreetMap contributors',
                            ),
                          ],
                        ),
              
                        point != null ? MarkerLayer(
                          markers: [
                            Marker(
                              point: point!,
                              width: 45,
                              height: 45,
                              child: Icon(
                                FontAwesomeIcons.locationDot, 
                                color: Colors.black, 
                                size: 45
                              ),
                            ),
                          ],
                        ) : SizedBox.shrink(),
              
                      ],
              
                    ),
                  ),
              
                ],
              ),
        
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 54,
                      height: 54,
                      child: InkWell(
                        onTap: () => setState(() {point = null; camera = null;}),
                        child: Card(
                          child: Center(
                            child: Icon(Icons.gps_fixed),
                          ),
                        ),
                      )
                    ),
                    SizedBox(
                      width: 54,
                      height: 54,
                      child: InkWell(
                        onTap: () => setState(() {followPoint = true;}),
                        child: Card(
                          child: Center(
                            child: Icon(Icons.center_focus_strong),
                          ),
                        ),
                      )
                    ),
                    SizedBox(
                      width: 54,
                      height: 54,
                      child: InkWell(
                        onTap: () {
                          if(point == null) {
                            locationService.removeSavedLocationData();  
                            return;
                          }
                          locationService.saveLocationData(
                            latitude: point!.latitude, 
                            longitude: point!.longitude,
                          );
                          context.pop();
                        },
                        child: Card(
                          child: Center(
                            child: Icon(Icons.done_all),
                          ),
                        ),
                      )
                    ),
                  ],
                ),
              )
        
            ],
          ),
        );
      }
    );
  }
}