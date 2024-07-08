import 'package:battery_monitoring_app/data_utils.dart';
import 'package:battery_monitoring_app/battery_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bluetooth_connections.dart';

class UpperIndicator extends StatelessWidget {
  const UpperIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ModelBatteryParams params =
        context.watch<TransformParams>().modelBatteryParams;
    double capacity = context.read<BluetoothConnection>().batCapacity;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          child: WholeIndicator(
              parameterIndicator: "Voltage",
              parameterValue: "${params.totalVolt} V",
              icon: const Icon(
                Icons.battery_full,
                size: 30,
              )),
        ),
        WholeIndicator(
            parameterIndicator: "Status",
            parameterValue: params.current == 0
                ? 'Idle'
                : params.current > 0
                    ? 'Charging'
                    : 'Discharging',
            icon: const Icon(
              Icons.battery_full,
              size: 30,
            )),
      ],
    );
  }
}

class IndicatorStatus extends StatelessWidget {
  final String parameterIndicator;
  final String parameterValue;

  IndicatorStatus(
      {Key? key,
      required this.parameterIndicator,
      required this.parameterValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          parameterIndicator,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(parameterValue),
      ],
    );
  }
}

class WholeIndicator extends StatelessWidget {
  final String parameterIndicator;
  final String parameterValue;
  final Icon icon;

  const WholeIndicator(
      {Key? key,
      required this.parameterIndicator,
      required this.parameterValue,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icon,
          IndicatorStatus(
              parameterIndicator: parameterIndicator,
              parameterValue: parameterValue)
        ],
      ),
    );
  }
}
