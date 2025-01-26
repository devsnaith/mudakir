import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:mudakir/services/app_version.dart';
import 'package:mudakir/services/clock_service.dart';
import 'package:mudakir/services/location_service.dart';
import 'package:mudakir/services/navigation_service.dart';
import 'package:mudakir/services/prayertime_service.dart';
import 'package:mudakir/views/adhkar/adhkar_sections_screen.dart';
import 'package:mudakir/views/adhkar/adhkar_view_screen.dart';
import 'package:mudakir/views/settings/location/settings_location_selector.dart';
import 'package:mudakir/views/summary/summary.dart';
import 'package:mudakir/views/navigation/navigation_router.dart';
import 'package:mudakir/views/navigation/widgets/navigation_button.dart';
import 'package:mudakir/views/qibla/qibla.dart';
import 'package:mudakir/views/settings/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Mudakir extends StatefulWidget {

  final Locale? locale;
  final Color? colorSchemeSeed;
  final AdaptiveThemeMode theme;
  const Mudakir(this.theme, this.locale, this.colorSchemeSeed, {super.key});

  @override State<Mudakir> createState() {
    return _MudakirState();
  }

}

class _MudakirState extends State<Mudakir> {
  
  Locale? forceLocale;
  late GoRouter appRouter = GoRouter(
    routes: [GoRoute(
      
      path: "/", 
      builder: (context, state) => NavigationRouter(),
      
      routes: [
        
        GoRoute(
          path: "adhkarviewer",
          builder: (context, state) => AdhkarViewScreen(state.extra),
        ),
        
        GoRoute(
          
          path: "settings",
          builder: (context, state) => SettingsScreen(),
          onExit: (context, state) async => onSettingsExit(state),
          routes: [
            GoRoute(
              path: "location",
              builder: (context, state) => Builder(
                builder: (context) {
                  return SettingsLocationSelector();
                }
              ),
            )
          ]
          
        ),
          
        ]
      ),
    ]
  );

  bool onSettingsExit(GoRouterState state) {
    
    if (!AppVersion.data!.containsKey("preferredLocale")) {
      if(forceLocale != null) {
        forceLocale = null;
        setState(() {});
      }
      return true;
    }

    String? locale = AppVersion.data!.getString("preferredLocale");                    
    if (forceLocale != null && forceLocale.toString() == locale) {
      return true;
    }

    forceLocale = Locale(locale!);

    setState(() {});
    return true;

  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      
      light: ThemeData(useMaterial3: true, brightness: Brightness.light, colorSchemeSeed: widget.colorSchemeSeed),
      dark: ThemeData(useMaterial3: true, brightness: Brightness.dark, colorSchemeSeed: widget.colorSchemeSeed),
      initial: widget.theme,
      
      builder: (lightTheme, darkTheme) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => PrayertimeService()),
            ChangeNotifierProvider(create: (context) => LocationService()),
            ChangeNotifierProvider(create: (context) => ClockService()),
            ChangeNotifierProvider(create: (context) => NavigationManger(
              
              buttons: [
                NavigationButton(FlutterIslamicIcons.calendar, "Times", "Times"),
                NavigationButton(FlutterIslamicIcons.solidQibla, "Qibla", "Qibla"),
                NavigationButton(FlutterIslamicIcons.solidPrayer, "Adhkar", "Adhkar"),
                // NavigationButton(FontAwesomeIcons.toolbox, "Tools", "Tools"),
              ],

              children: [
                SummaryScreen(),
                QiblaScreen(),
                AdhkarScreen(),
                // Placeholder(),
              ]

            )),
          ],
          child: MaterialApp.router(

            theme: lightTheme,
            darkTheme: darkTheme,
              
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            debugShowCheckedModeBanner: false,
              
            supportedLocales: [
              Locale("en"),
              Locale("ar"),
            ],
                      
            locale: forceLocale ?? widget.locale,
            routerConfig: appRouter,
          
          ),
        );
      }
    );
  }
}