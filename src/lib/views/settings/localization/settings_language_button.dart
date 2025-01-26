import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:mudakir/public/widgets/app_dialog.dart';
import 'package:mudakir/services/app_version.dart';

class SettingsLanguageButton extends StatefulWidget {

  final VoidCallback onChange;
  const SettingsLanguageButton(this.onChange, {super.key});

  @override
  State<SettingsLanguageButton> createState() => _SettingsLanguageButtonState();
}

class _SettingsLanguageButtonState extends State<SettingsLanguageButton> {

  String? preferredLocale = "en";
  String  preferredLocaleName = "NaN";

  final Map<String, String> locales = const {
    "NaN" : "",
    "en"  : "English",
    "ar"  : "اللغة العربية",
  };

  void _selectLanguage(String locale) async {
    if(locale == "NaN") {
      await AppVersion.data!.remove("preferredLocale");
      AppVersion.log("SettingsLanguageButton",
       "Locale is using System Language now");
    }else {
      AppVersion.log("SettingsLanguageButton",
       "Locale Changed from ${preferredLocale ?? "System Language"} to $locale");
      await AppVersion.data!.setString('preferredLocale', locale);
      preferredLocale = locale;
    }

    widget.onChange.call();
    context.pop();
  }

  Widget _rowBuilder(BuildContext context, int index) {

    String locale = locales.keys.elementAt(index);
    String name = locales.values.elementAt(index);

    if(locale == "NaN") {
      name = AppLocalizations.of(context)!.settings_system_language_option_name;
    }

    return InkWell(
      child: ListTile(
        leading: name == preferredLocaleName ? Icon(Icons.check) : null,
        onTap: () => _selectLanguage(locale),
        title: Text(name),
      ),
    );
  }

  void listLanguages(BuildContext context) async {

    SizedBox listOfLanguages = SizedBox(
      width: double.maxFinite, height: 150,
      child: ListView.builder(
        itemCount: locales.length,
        itemBuilder: _rowBuilder,
      ),
    );
    
    await AppDialog(
      context: context, 
      actions: [],
      icon: Icon(Icons.language),
      description: listOfLanguages, 
    ).show();
  }

  @override
  Widget build(BuildContext context) {

    preferredLocale = AppVersion.data!.getString('preferredLocale');
    preferredLocaleName = preferredLocale ?? AppLocalizations.of(context)!.settings_system_language_option_name;
    preferredLocaleName = preferredLocale != null ? preferredLocaleName = locales[preferredLocale]! : preferredLocaleName;
    
    return InkWell(
      child: ListTile(
        leading: Icon(Icons.language),
        onTap: () => listLanguages(context),
        title: Text(AppLocalizations.of(context)!.settings_language_btn_title),
        subtitle: Text(preferredLocaleName),
      ),
    );
    
  }  
}