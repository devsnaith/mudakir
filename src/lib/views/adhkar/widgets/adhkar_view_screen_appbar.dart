import 'package:flutter/material.dart';
import 'package:mudakir/models/adhkar/adhkar_section_model.dart';
import 'package:mudakir/public/app_fonts.dart';

class AdhkarViewAppbar extends StatelessWidget implements PreferredSizeWidget {
  
  final AdhkarSectionModel adhkarSectionModel;
  const AdhkarViewAppbar(this.adhkarSectionModel,{super.key});
  
  @override
  Widget build(BuildContext context) => AppBar(
    title: Text(
      adhkarSectionModel.name,
      style: AppFonts.appBarFontStyle(context),
    ),
  );
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}