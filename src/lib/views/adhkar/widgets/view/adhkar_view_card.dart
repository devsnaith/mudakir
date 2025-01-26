import 'package:flutter/material.dart';
import 'package:mudakir/models/adhkar/adhkar_model.dart';
import 'package:mudakir/views/adhkar/widgets/view/adhkar_view_card_content.dart';
import 'package:mudakir/views/adhkar/widgets/view/adhkar_view_card_footer.dart';

class AdhkarViewCard extends StatefulWidget {
  
  final AdhkarModel dhukir;
  final VoidCallback dismiss;
  final ScrollController scrollController;
  final Animation<double> animation;
  const AdhkarViewCard({
    required this.animation,
    required this.dismiss,
    required this.scrollController,
    required this.dhukir,
    super.key,
  });

  @override
  State<AdhkarViewCard> createState() => _AdhkarViewCardState();
}

class _AdhkarViewCardState extends State<AdhkarViewCard> {

  int counter = 0;
  
  @override
  void initState() {
    super.initState();
    counter = widget.dhukir.count;
  }

  void _decrement() {
    if((--counter) == 0) {
      widget.dismiss.call();
    }else {
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: widget.animation,
      child: Container(
      
        height: 250,
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(8),
      
        clipBehavior: Clip.antiAlias,
      
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            AdhkarViewCardContent(
              onTap: _decrement,
              content: widget.dhukir.content,
              scrollController: widget.scrollController,
            ),

            AdhkarViewCardFooter(
              reference: widget.dhukir.reference,
              onTap: _decrement,
              count: counter,
            ),

          ],
        )
      ),
    );
  }
}