import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mudakir/models/adhkar/adhkar_section_model.dart';

class AdhkarButton extends StatelessWidget {
  
  final AdhkarSectionModel sectionModel;
  const AdhkarButton(this.sectionModel, {super.key});

  @override
  Widget build(BuildContext context) {
    
    IconData backgroundIcon = FlutterIslamicIcons.solidTasbih;
    switch (sectionModel.id) {
      case 1: backgroundIcon = FlutterIslamicIcons.solidCrescentMoon; break;
      case 2: backgroundIcon = FlutterIslamicIcons.sajadah; break;
      case 3: backgroundIcon = FlutterIslamicIcons.wudhu; break;
      case 4: backgroundIcon = FlutterIslamicIcons.solidMosque; break;
      case 5: backgroundIcon = FlutterIslamicIcons.solidLantern; break;
      default: backgroundIcon = FlutterIslamicIcons.solidIftar; break;
    }

    return LayoutBuilder(
      builder: (context, size) {
        
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.all(Radius.circular(4))
          ),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  
                  Icon(backgroundIcon, 
                    size: size.maxHeight / 1.5, 
                    color: Theme.of(context).colorScheme.surface.withAlpha(20)
                  ),
              
                  Center(
                    child: AutoSizeText(
                      sectionModel.name,
                      textScaleFactor: 1,
                      locale: Locale("ar"),
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.amiri(
                        color: Theme.of(context).colorScheme.surface,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )
                    ),
                  )
                ]
              ),
            ),
          ),
        );
      }
    );
  }
  
}