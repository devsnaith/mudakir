import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mudakir/services/app_version.dart';
import 'package:mudakir/views/navigation/widgets/navigation_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavigationManger with ChangeNotifier {
  
  int _currentPageIndex = 0;
  late List<NavigationRailDestination> railButtons;
  List<NavigationButton> buttons;
  final List<Widget> children;

  NavigationManger({
    required this.buttons,
    required this.children,
  }) {
    _copyToRail();
    AppVersion.log(
      "NavigationManger", "Ready!");
  }

  void _copyToRail() {
    railButtons = buttons.map((e) {
      return NavigationRailDestination(
        icon: Icon(e.iconData), 
        label: Text(e.label),
      );
    }).toList();
  }

  void switchto(int index) {
    _currentPageIndex = max(min(index, children.length), 0);
    notifyListeners();
  }

  Widget getNavigationBarWidget() => NavigationBar(
    selectedIndex: _currentPageIndex,
    onDestinationSelected: (index) => switchto(index),
    destinations: buttons,
  );

  Widget getAsNavigationRail() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5
      ),
      child: NavigationRail(
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (index) => switchto(index),
        destinations: railButtons,
        labelType: NavigationRailLabelType.all,
      ),
    );
  }

  void localize(BuildContext context) {
    String localeName = AppLocalizations.of(context)!.localeName;
    AppVersion.log("NavigationManger", "Localizing Buttons to $localeName");
    buttons = buttons.map<NavigationButton>((navigationButton) {
      String key = navigationButton.btnKey;
      String localizedLabel = AppLocalizations.of(context)!
        .navigation_bar_buttons_name(key);
        return NavigationButton(
          navigationButton.iconData,
          navigationButton.btnKey,
          localizedLabel
        );
    }).toList();
    _copyToRail();
    AppVersion.log("NavigationManger", "Localized!");
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   notifyListeners();
    // });
  }

  Widget getCurrentPageWidget() => children[_currentPageIndex];

}