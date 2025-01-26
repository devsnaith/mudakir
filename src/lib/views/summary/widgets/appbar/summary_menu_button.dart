import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeMenuButton extends StatelessWidget {
  const HomeMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () => context.go("/settings"),
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              AppLocalizations.of(context)!.settings_menu_button_name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
      offset: Offset(0, kToolbarHeight),
    );
  }

}