import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:mudakir/public/enums/report_type.dart';
import 'package:mudakir/public/widgets/app_indicator.dart';
import 'package:mudakir/public/widgets/handlers/report_handler.dart';
import 'package:mudakir/views/qibla/widgets/qiblah_compass.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  State<QiblaScreen> createState() => _QiblaScreen();
}

class _QiblaScreen extends State<QiblaScreen> {

  @override
  Widget build(BuildContext context) {
    bool landscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return LayoutBuilder(
      builder: (context, size) {
        return SizedBox(
          
          width: size.maxWidth,
          height: size.maxHeight,

          child: FutureBuilder(
            future: FlutterQiblah.androidDeviceSensorSupport(),
            builder: (context, snapshot) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return SimpleIndicator(indicator: Indicator.lineScaleParty);
              }

              if (snapshot.hasError) {
                return ReportHandler(
                  description: snapshot.error.toString(),
                  title: AppLocalizations.of(context)!.msg_qibla_uncatched_error_description,
                  serviceName: "QiblaDirection",
                  reportType: ReportType.bug,
                );
              }

              if (!snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.warning_amber_rounded, size: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          AppLocalizations.of(context)!.msg_qibla_unsupported_error_description, 
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return LayoutGrid(
                columnSizes: landscape ? [1.fr, 1.fr] : [1.fr], 
                rowSizes: landscape ? [1.fr] : [1.fr, 2.fr],
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListTile(
                      title: AutoSizeText(maxLines: 1, textScaleFactor: 1, AppLocalizations.of(context)!.msg_qibla_notes_title_label),
                      subtitle: Wrap(
                        children: [
                          AutoSizeText(maxLines: 2, textScaleFactor: 1, AppLocalizations.of(context)!.msg_qibla_notes_unreliable_sensor_note, 
                            style: TextStyle(fontWeight: FontWeight.bold)
                          ),
                          AutoSizeText(maxLines: 2, textScaleFactor: 1, AppLocalizations.of(context)!.msg_qibla_notes_location_service_note, 
                            style: TextStyle(fontWeight: FontWeight.bold)
                          ),
                        ]), 
                      leading: Icon(FontAwesomeIcons.solidLightbulb),
                    ),
                  ),
              
                  Align(
                    alignment: Alignment.topCenter,
                    child: QiblahCompass(),
                  ),
                  
                ],
              );
            }
          ),

        );
      }
    );
  }
}