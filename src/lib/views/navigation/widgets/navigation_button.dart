import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton(
    this.iconData,
    this.btnKey,
    this.label,
    {super.key}
  );

  final IconData iconData;
  final String btnKey;
  final String label;

  @override
  Widget build(BuildContext context) => NavigationDestination(
    icon: Icon(iconData, color: Theme.of(context).colorScheme.primary), label: label
  );
  
}