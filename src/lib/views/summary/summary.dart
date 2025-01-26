import 'package:flutter/material.dart';
import 'package:mudakir/public/widgets/handlers/location_handler.dart';
import 'package:mudakir/services/location_service.dart';
import 'package:mudakir/views/summary/widgets/summary_prayer_times_list.dart';
import 'package:mudakir/views/summary/widgets/timecard/summary_card.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:provider/provider.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationService>(
      builder: (context, location, child) {
        return Scaffold(
          body: SafeArea(
            child: LayoutBuilder(builder: (context, constraints) {
              bool landscape = MediaQuery.of(context).orientation == Orientation.landscape;
              return SizedBox(
                height: constraints.maxHeight,
                child: LayoutGrid(
                  columnSizes: landscape ? [1.fr, 1.fr] : [1.fr], 
                  rowSizes: landscape ? [1.fr] : [1.fr, 2.2.fr],
                  children: [
                    SummaryCard(),
                    location.locationData != null
                    ? PrayerTimesList(location.locationData!)
                    : LocationHandler(
                      useSavedLocationDataWhenLocationNotAvailable: true, 
                      onLocationUpdate: (locationData) {
                        return PrayerTimesList(locationData);
                      }
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      }
    );
  }
}