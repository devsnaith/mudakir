import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {

  final String label;
  const TextLabel(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 0.0, left: 8.0, right: 8.0, top: 32.0
      ),
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  static Widget titledGroup({

    required String groupName, 
    required List<Widget> children,
    
    }) {
    
    List<Widget> childrens = [TextLabel(groupName)];
    childrens.addAll(children);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: childrens,
    );

  }

}