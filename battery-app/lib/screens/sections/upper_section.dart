import 'package:battery_monitoring_app/widgets/bluetooth_switch.dart';
import 'package:battery_monitoring_app/widgets/indicator_status.dart';
import 'package:battery_monitoring_app/widgets/top_soc_section.dart';
import 'package:flutter/material.dart';

class UpperSection extends StatelessWidget {
  const UpperSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      width: double.maxFinite,
      height: double.maxFinite,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          BluetoothSwitch(),
          SocBar(),
          UpperIndicator(),
        ],
      ),
    );
  }
}
