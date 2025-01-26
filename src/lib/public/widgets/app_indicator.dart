import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SimpleIndicator extends StatelessWidget{

  final Indicator indicator;

  const SimpleIndicator({
    this.indicator = Indicator.ballPulseSync,
    super.key, 
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 32, height: 32,
        child: LoadingIndicator(
          indicatorType: indicator,
          colors: [
            Theme.of(context).colorScheme.primary
          ],
          strokeWidth: 2,
        ),
      ),
    );
  }
}