import 'package:battery_monitoring_app/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SocBar extends StatelessWidget {
  const SocBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double params = context.watch<TransformParams>().modelBatteryParams.soc;
    return BatteryParamsWidget(soc: params);
  }
}

class BatteryParamsWidget extends StatelessWidget {
  double soc;

  BatteryParamsWidget({Key? key, required this.soc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 1),
        height: 210,
        child: SfRadialGauge(
          axes: [
            RadialAxis(
              minimum: 0,
              radiusFactor: .9,
              showLabels: false,
              showTicks: false,
              axisLineStyle: const AxisLineStyle(
                thickness: 0.1,
                cornerStyle: CornerStyle.bothCurve,
                color: Colors.white,
                thicknessUnit: GaugeSizeUnit.factor,
              ),
              pointers: [
                RangePointer(
                  value: soc,
                  cornerStyle: CornerStyle.bothCurve,
                  width: 0.1,
                  color: Colors.lightGreen,
                  sizeUnit: GaugeSizeUnit.factor,
                )
              ],
              annotations: [
                GaugeAnnotation(
                    widget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "SOC",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: ElevatedButton(
                            onPressed: null,
                            child: Text("${soc.toInt().toString()} %",
                                style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)))),
                  ],
                ))
              ],
            )
          ],
        ));
  }
}
