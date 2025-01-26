import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mudakir/public/widgets/app_indicator.dart';
import 'package:mudakir/public/widgets/handlers/location_handler.dart';

class QiblahCompass extends StatefulWidget {
  const QiblahCompass({super.key});

  @override
  State<QiblahCompass> createState() => _QiblahCompassState();
}

class _QiblahCompassState extends State<QiblahCompass> {

  late SvgPicture needle;
  late SvgPicture compass;
  
  @override
  void initState() {
    super.initState();
    needle = SvgPicture.asset("assets/svg/compass/needle.svg");
  }

  @override
  void dispose() {
    super.dispose();
    FlutterQiblah().dispose();
  }

  @override
  Widget build(BuildContext context) {

    compass = SvgPicture.asset(
      "assets/svg/compass/compass.svg", 
      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcATop)
    );
  

    double boxSize = MediaQuery.of(context).size.width / 1.5;
    if(MediaQuery.of(context).orientation == Orientation.landscape) {
      boxSize = MediaQuery.of(context).size.height / 1.5;
    }

    return StreamBuilder<QiblahDirection>(
      stream: FlutterQiblah.qiblahStream,
      builder: (context, snapshot) {

        if (snapshot.hasError) {
          return LocationHandler(
            onLocationUpdate: (locationData) => Padding(
              
              padding: const EdgeInsets.symmetric(horizontal: 32),
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  Icon(Icons.warning_amber_rounded, size: 32),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      AppLocalizations.of(context)!.msg_qibla_location_disabled_error_description, 
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
            
                  FilledButton.tonal(
                    onPressed: () {
                      setState(() => FlutterQiblah().dispose());
                    }, child: Text(AppLocalizations.of(context)!.msg_qibla_location_disabled_error_try_again_button)),
                  
                ],
              ),
            ),
          );
        }

        if(!snapshot.hasData){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    AppLocalizations.of(context)!.msg_location_getting_location_indicator_message, 
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SimpleIndicator(),
              ],
            ),
          );
        }
        
        QiblahDirection direction = snapshot.data!;
        return Stack(
          alignment: Alignment.center,
          children: [
            
            Transform.rotate(
              angle: ((direction.direction) * (pi / 180) * -1),
              child: SizedBox(width: boxSize, height: boxSize, child: compass)
            ),

            
            Transform.rotate(
              angle: ((direction.qiblah) * (pi / 180) * -1),
              child: SizedBox(width: boxSize, height: boxSize, child: needle)
            ),
            
          ],
        );
      }
    );
  }
}