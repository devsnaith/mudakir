import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mudakir/public/widgets/app_dialog.dart';
import 'package:mudakir/services/app_version.dart';

class SettingsAppColorButton extends StatelessWidget {

  const SettingsAppColorButton({super.key});

  Widget _colorPicker(BuildContext context) {
    return MaterialPicker(
      pickerColor: AdaptiveTheme.of(context).theme.colorScheme.primary,
      onColorChanged: (value) {
        AdaptiveTheme.of(context).setTheme(
          light: ThemeData(useMaterial3: true, brightness: Brightness.light, colorSchemeSeed: value),
          dark: ThemeData(useMaterial3: true, brightness: Brightness.dark, colorSchemeSeed: value),
        );
        AppVersion.data!.setString("ThemeColorSchemeSeed", value.toHexString());
      }
    );
  }

  Widget _actionButtons(BuildContext context) {
    return Wrap(
      children: [

        IconButton(
          onPressed: () => changeColor(context), 
          icon: Icon(Icons.draw, color: AdaptiveTheme.of(context).theme.colorScheme.surface)
        ),
          
        IconButton(
          onPressed: () {
            AppVersion.data!.remove("ThemeColorSchemeSeed");
            AdaptiveTheme.of(context).reset();
            AdaptiveTheme.of(context).setTheme(
              light: ThemeData(useMaterial3: true, brightness: Brightness.light),
              dark: ThemeData(useMaterial3: true, brightness: Brightness.dark),
            );
          }, 
          icon: Icon(Icons.restore, color: AdaptiveTheme.of(context).theme.colorScheme.surface)
        )

      ],
    );
  }

  void changeColor(BuildContext context) {
    AppDialog(

      context: context,
      description: SizedBox(

        height: 300,
        
        child: SingleChildScrollView(
          child: _colorPicker(context),
        ),

      )

    ).show();
  }

  Widget generateColorView(BuildContext context, double boxsSize) {
    Widget box(Color boxColor, double x, double y) {
      return Transform.translate(
        offset: Offset(x, y),
        child: Padding(padding: const EdgeInsets.all(4),
          child: Container(width: boxsSize, height: boxsSize,
          decoration: BoxDecoration(color: boxColor, borderRadius: BorderRadius.circular(10))
        )),
      );
    }

    ThemeData theme = AdaptiveTheme.of(context).theme;
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(children: [
          Stack(children: [
            box(theme.colorScheme.primary, 0, 0),
            box(theme.colorScheme.onPrimary, 4, 2),
          ]),
          Stack(children: [
            box(theme.colorScheme.secondary, 0, 0),
            box(theme.colorScheme.onSecondary, 4, 2),
          ]),
          Stack(children: [
            box(theme.colorScheme.primaryContainer, 0, 0),
            box(theme.colorScheme.onPrimaryContainer, 4, 2),
          ]),
          Stack(children: [
            box(theme.colorScheme.secondaryContainer, 0, 0),
            box(theme.colorScheme.onSecondaryContainer, 4, 2),
          ]),
          Stack(children: [
            box(theme.colorScheme.primaryFixed, 0, 0),
            box(theme.colorScheme.onPrimaryFixed, 4, 2),
          ]),
          Stack(children: [
            box(theme.colorScheme.secondaryFixed, 0, 0),
            box(theme.colorScheme.onSecondaryFixed, 4, 2),
          ]),
          Stack(children: [
            box(theme.colorScheme.surface, 0, 0),
            box(theme.colorScheme.onSurface, 4, 2),
          ]),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      
      context: context,
      // locale: Locale("en"),
        
      child: LayoutBuilder(
        builder: (context, size) => SizedBox(
        width: size.maxWidth,

        child: Padding(
          
          padding: const EdgeInsets.symmetric(
            horizontal: 10, vertical: 15,
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Icon(Icons.color_lens, size: 30),
              ),
                  
              Expanded(
                child: Card(
                  
                  color: AdaptiveTheme.of(context).brightness == Brightness.dark 
                    ? Colors.white : Colors.black,
                  
                  child: Padding(
                  
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10
                    ),            
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: generateColorView(context, 24)),
                        _actionButtons(context),
                      ]
          
                    ),
                  ),
                ),
              ),              
            
            ],
          ),
        ),
      )),
    );
  }
  
}