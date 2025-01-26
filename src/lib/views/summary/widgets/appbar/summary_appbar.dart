import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:mudakir/public/app_fonts.dart';
import 'package:mudakir/views/summary/widgets/appbar/summary_menu_button.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) => AppBar(
    title: Text(
      AppLocalizations.of(context)!.global_title_bar,
      style: AppFonts.appBarFontStyle(context),
    ),
    actions: [HomeMenuButton()],
    leading: Icon(FlutterIslamicIcons.solidMosque),
    // titleSpacing: 0,
  );
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}