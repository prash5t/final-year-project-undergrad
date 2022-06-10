import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ManualRadialGauge extends StatelessWidget {
  ManualRadialGauge({Key? key, required this.currentPolarity})
      : super(key: key);
  double currentPolarity = 0.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.grey[350],
        borderRadius: const BorderRadius.all(Radius.circular(200)),
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: SfRadialGauge(
        enableLoadingAnimation: true,
        axes: <RadialAxis>[
          RadialAxis(
            minimum: -1,
            maximum: 1,
            pointers: <GaugePointer>[
              NeedlePointer(
                needleColor: Colors.grey,
                value: currentPolarity,
                needleLength: 0.5,
                enableAnimation: true,
                knobStyle: const KnobStyle(
                  borderColor: Colors.grey,
                  borderWidth: 0.02,
                  knobRadius: 0.06,
                  color: Colors.white,
                ),
              ),
            ],
            ranges: <GaugeRange>[
              GaugeRange(
                startValue: -1,
                endValue: -0.8,
                color: Colors.red[900],
              ),
              GaugeRange(
                startValue: -0.8,
                endValue: -0.6,
                color: Colors.red[700],
              ),
              GaugeRange(
                startValue: -0.6,
                endValue: -0.4,
                color: Colors.red[500],
              ),
              GaugeRange(
                startValue: -0.4,
                endValue: -0.2,
                color: Colors.red[400],
              ),
              GaugeRange(
                startValue: -0.2,
                endValue: -0.1,
                color: Colors.red[300],
              ),
              GaugeRange(
                startValue: -0.1,
                endValue: 0.1,
                color: Colors.orange,
              ),
              GaugeRange(
                startValue: 0.1,
                endValue: 0.2,
                color: Colors.green[300],
              ),
              GaugeRange(
                startValue: 0.2,
                endValue: 0.4,
                color: Colors.green[400],
              ),
              GaugeRange(
                startValue: 0.4,
                endValue: 0.6,
                color: Colors.green[500],
              ),
              GaugeRange(
                startValue: 0.6,
                endValue: 0.8,
                color: Colors.green[700],
              ),
              GaugeRange(
                startValue: 0.8,
                endValue: 1,
                color: Colors.green[900],
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                //current value
                widget: Text(
                  "$currentPolarity",
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                positionFactor: 0.3,
                angle: 90,
              ),
              const GaugeAnnotation(
                //positive side
                widget: Text(
                  "Positive",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold),
                ),
                positionFactor: 0.6,
              ),
              const GaugeAnnotation(
                //negative side
                widget: Text(
                  "Negative",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                positionFactor: 0.6,
                angle: 180,
              ),
              const GaugeAnnotation(
                //neutral side
                widget: Text(
                  "Neutral",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold),
                ),
                positionFactor: 0.73,
                angle: 270,
              ),
            ],
          )
        ],
      ),
    );
  }
}
