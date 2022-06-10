import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MyLinearGauge extends StatelessWidget {
  const MyLinearGauge({Key? key, required this.currentPointer})
      : super(key: key);
  final double currentPointer;
  @override
  Widget build(BuildContext context) {
    return SfLinearGauge(
      animateAxis: true,
      animateRange: true,
      majorTickStyle: const LinearTickStyle(length: 2),
      minimum: -1,
      maximum: 1,
      showLabels: true,
      showTicks: true,
      showAxisTrack: true,
      tickPosition: LinearElementPosition.inside,
      markerPointers: [
        LinearWidgetPointer(
            value: currentPointer,
            child: ImageIcon(
              AssetImage(currentPointer < -0.1
                  ? "lib/assets/angry.png"
                  : currentPointer > 0.1
                      ? "lib/assets/happy.png"
                      : "lib/assets/neutral.png"),
              color: currentPointer < -0.1
                  ? Colors.pink
                  : currentPointer > 0.1
                      ? Colors.teal
                      : Colors.indigo,
              size: 30,
            ))
      ],
      ranges: [
        LinearGaugeRange(
          startValue: -1,
          endValue: -0.8,
          color: Colors.red[900],
        ),
        LinearGaugeRange(
          startValue: -0.8,
          endValue: -0.6,
          color: Colors.red[700],
        ),
        LinearGaugeRange(
          startValue: -0.6,
          endValue: -0.4,
          color: Colors.red[500],
        ),
        LinearGaugeRange(
          startValue: -0.4,
          endValue: -0.2,
          color: Colors.red[400],
        ),
        LinearGaugeRange(
          startValue: -0.2,
          endValue: -0.1,
          color: Colors.red[300],
        ),
        LinearGaugeRange(
          startValue: -0.1,
          endValue: 0.1,
          color: Colors.orange[500],
        ),
        LinearGaugeRange(
          startValue: 0.1,
          endValue: 0.2,
          color: Colors.green[300],
        ),
        LinearGaugeRange(
          startValue: 0.2,
          endValue: 0.4,
          color: Colors.green[400],
        ),
        LinearGaugeRange(
          startValue: 0.4,
          endValue: 0.6,
          color: Colors.green[500],
        ),
        LinearGaugeRange(
          startValue: 0.6,
          endValue: 0.8,
          color: Colors.green[700],
        ),
        LinearGaugeRange(
          startValue: 0.8,
          endValue: 1,
          color: Colors.green[900],
        ),
      ],
    );
  }
}
