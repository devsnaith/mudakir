import 'package:flutter/material.dart';
import 'package:mudakir/services/navigation_service.dart';
import 'package:mudakir/views/summary/widgets/appbar/summary_appbar.dart';
import 'package:provider/provider.dart';

class NavigationRouter extends StatelessWidget {
  const NavigationRouter({super.key});
  
  @override
  Widget build(BuildContext context) => Consumer<NavigationManger>(builder: (context, service, child) {
    
    service.localize(context);

    bool landscape = false;
    List<Widget> widgets = [];
    if(landscape = (MediaQuery.of(context).orientation == Orientation.landscape)) {
      widgets.add(service.getAsNavigationRail());
    }

    widgets.add(Expanded(child: service.getCurrentPageWidget()));

    return Scaffold(

      appBar: HomeAppBar(),
      bottomNavigationBar: !landscape ? service.getNavigationBarWidget() : null,
      
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(children: widgets),
      ),

    );

  });

}