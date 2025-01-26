import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mudakir/public/app_fonts.dart';

class AdhkarViewCardFooter extends StatefulWidget {
  
  final int count;
  final VoidCallback onTap;
  final String reference;
  const AdhkarViewCardFooter({
    required this.count, 
    required this.onTap,
    required this.reference,
    super.key,
  });

  @override
  State<AdhkarViewCardFooter> createState() => _AdhkarViewCardFooterState();
}

class _AdhkarViewCardFooterState extends State<AdhkarViewCardFooter> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if (!scrollController.hasClients) {
        return;
      }
      double maxExtent = scrollController.position.maxScrollExtent;
      double distanceDifference = maxExtent - scrollController.offset;
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(seconds: (distanceDifference / 20).toInt()),
        curve: Curves.linear
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      clipBehavior: Clip.antiAlias,

      margin: EdgeInsets.only(top: 4),

      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),

      height: 36,
      
      child: Row(
        
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
    
        children: [
          Expanded(
            child: Padding(
              
              padding: const EdgeInsets.symmetric(
                horizontal: 4
              ),
              
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: scrollController,
                  child: Text(
                    widget.reference,
                    maxLines: 1,
                    style: GoogleFonts.notoKufiArabic(
                      fontSize: 10,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ),
    
          GestureDetector(
            onTap: widget.onTap,
            child: Container(
              width: 80,
                
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(4)
              ),
                      
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8
                    ),
                    child: Text(
                      widget.count.toString(),
                      style: AppFonts.summaryCardClockStyle(
                        Theme.of(context).colorScheme.onSurface,
                        FontWeight.bold, 16
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
                        
        ],
      ),
    );
  }
}