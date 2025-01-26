import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdhkarViewCardContent extends StatelessWidget {

  final String content;
  final VoidCallback onTap;
  final ScrollController scrollController;
  const AdhkarViewCardContent({
    required this.scrollController,
    required this.content,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        child: LayoutBuilder(builder: (context, constraints) => Stack(
          children: [

            GestureDetector(
              onTap: () => onTap.call(),
              child: SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: Image.asset("assets/images/arabesque.png",
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
            
            Center(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: scrollController,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: GestureDetector(
                          onTap: () => onTap.call(),
                          child: Text(
                            content,
                            textDirection: TextDirection.rtl,
                            style: GoogleFonts.notoNaskhArabic(
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )

          ],
        )),
      ),
    );
    
  }
}