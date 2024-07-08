import 'package:battery_monitoring_app/battery_model.dart';
import 'package:battery_monitoring_app/bluetooth_connections.dart';
import 'package:battery_monitoring_app/widgets/indicator_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data_utils.dart';

class MidIndicatorValues extends StatelessWidget {
  const MidIndicatorValues({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ModelBatteryParams params =
        context.watch<TransformParams>().modelBatteryParams;
    double batCap = context.read<BluetoothConnection>().batCapacity;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ParametersValues(
            params1: 'Current',
            params2: 'Capacity',
            valueParams1: '${params.current} A',
            valueParams2: '${batCap} mAH'),
        ParametersValues(
            params1: 'Min volt',
            params2: 'Max volt',
            valueParams1: '${params.maxVolt} V',
            valueParams2: '${params.minVolt} V')
      ],
    );
  }
}

class ParametersValues extends StatelessWidget {
  final String params1;
  final String params2;
  final String valueParams1;
  final String valueParams2;

  const ParametersValues({Key? key,
    required this.params1,
    required this.params2,
    required this.valueParams1,
    required this.valueParams2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          WholeIndicator(
              parameterIndicator: params1,
              parameterValue: valueParams1,
              icon: const Icon(
                Icons.battery_full,
                size: 30,
              )),
          const SizedBox(
            width: 115,
          ),
          WholeIndicator(
              parameterIndicator: params2,
              parameterValue: valueParams2,
              icon: const Icon(
                Icons.battery_full,
                size: 30,
              )),
        ],
      ),
    );
  }
}