import 'package:flutter/material.dart';

class AppDialog {
  final BuildContext context;
  
  final String? title;
  final Widget description;
  final Icon? icon;

  final List<Widget>? actions;

  Widget _builder(BuildContext context) => AlertDialog(
    icon: icon,
    title: title != null ? Text(title!) : null,
    content: description,
    actions: actions,
  );

  const AppDialog({
    required this.context,
    required this.description,
    this.actions,
    this.title,
    this.icon,
  });

  Future<void> show() async {
    await showDialog(
      context: context, 
      builder: _builder
    );
  }

  static Widget dialogBtn(
    BuildContext context, 
    String btnName,
    VoidCallback onPressed,
    ) {
      return TextButton(
        style: TextButton.styleFrom(
          textStyle: Theme.of(context).textTheme.labelLarge,
        ),
        child: Text(btnName),
        onPressed: () {
          onPressed.call();
          Navigator.of(context).pop();
        },
      );
  }

  static Future<bool> dialogGrantDenyOptions(
    BuildContext context,
    Icon icon,
    String title,
    String description,
    String grantOption,
    String denyOption,
    {
      VoidCallback? onGrant,
      VoidCallback? onDeny,
    }
    ) async {
      String result = denyOption;
      await AppDialog(
        context: context,
        icon: icon,
        title: title,
        description: Text(description),
        actions: [
          dialogBtn(context, grantOption, () {
            result = grantOption;
            if(onGrant != null) {
              onGrant.call();
            }
          }),
          dialogBtn(context, denyOption, () {
            result = denyOption;
            if(onDeny != null) {
              onDeny.call();
            }
          }),
        ]
      ).show();
    return result == grantOption;
  }
}