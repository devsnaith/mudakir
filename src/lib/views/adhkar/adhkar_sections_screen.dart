import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mudakir/models/adhkar/adhkar_section_model.dart';
import 'package:mudakir/public/widgets/app_indicator.dart';
import 'package:mudakir/repositories/adhkar_repository.dart';
import 'package:mudakir/views/adhkar/widgets/adhkar_section_button.dart';

class AdhkarScreen extends StatefulWidget {
  const AdhkarScreen({super.key});

  @override
  State<AdhkarScreen> createState() => _AdhkarScreenState();
}

class _AdhkarScreenState extends State<AdhkarScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return FutureBuilder(
              future: AdhkarRepository().fetchAdhkars(), 
              builder: (context, snapshot) {


                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(child: SimpleIndicator());
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10
                  ),
                              
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: 100,
                      crossAxisCount: 2,
                    ), 
                    
                    itemCount: AdhkarRepository().sections.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      AdhkarSectionModel model = AdhkarRepository().sections[index];
                      return GestureDetector(
                        onTap: () => context.go("/adhkarviewer", extra: model), 
                        child: AdhkarButton(model)
                      );
                    },
                  ),
                );
              }
            );
          },
        ),
      ),
    );
  }
  
}