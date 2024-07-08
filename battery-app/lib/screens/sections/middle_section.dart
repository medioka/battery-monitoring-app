import 'package:battery_monitoring_app/widgets/cells_values.dart';
import 'package:battery_monitoring_app/widgets/mid_indicator_status.dart';
import 'package:battery_monitoring_app/widgets/mid_indicator_values.dart';
import 'package:flutter/material.dart';

class MidSection extends StatelessWidget {
  const MidSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 310,
      right: 0,
      left: 0,
      child: Container(
          padding: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              color: Colors.white),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              MidIndicatorParameters(
                values: "Parameter Status",
              ),
              MidIndicatorValues(),
              MidIndicatorParameters(values: "Battery Cells Voltage"),
              CellsVoltageWhole()
            ],
          )),
    );
  }
}
