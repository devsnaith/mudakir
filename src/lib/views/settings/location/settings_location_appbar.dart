import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mudakir/public/app_fonts.dart';

class LocationAppbar extends StatelessWidget implements PreferredSizeWidget {
  const LocationAppbar({super.key});

  
  @override
  Widget build(BuildContext context) => AppBar(
    title: Text(
      AppLocalizations.of(context)!.settings_location_group_label,
      style: AppFonts.appBarFontStyle(context),
    ),
    // titleSpacing: 0,
  );
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}