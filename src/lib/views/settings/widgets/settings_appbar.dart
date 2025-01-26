import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mudakir/public/app_fonts.dart';

class SettingsAppbar extends StatelessWidget implements PreferredSizeWidget {
  const SettingsAppbar({super.key});

  
  @override
  Widget build(BuildContext context) => AppBar(
    title: Text(
      AppLocalizations.of(context)!.settings_title_bar,
      style: AppFonts.appBarFontStyle(context),
    ),
    // titleSpacing: 0,
  );
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}