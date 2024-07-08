import 'dart:async';

import 'package:battery_monitoring_app/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../bluetooth_connections.dart';

class BluetoothSwitch extends StatefulWidget {
  const BluetoothSwitch({Key? key}) : super(key: key);

  @override
  State<BluetoothSwitch> createState() => _BluetoothSwitchState();
}

class _BluetoothSwitchState extends State<BluetoothSwitch> {
  @override
  Widget build(BuildContext context) {
    bool status = context.watch<BluetoothConnection>().statusBluetooth;
    return Container(
      height: 20,
      child: Align(
        alignment: Alignment.topRight,
        child: Switch(
          activeColor: Colors.green,
          value: status,
          onChanged: (bool value) async {
            await [
              Permission.location,
              Permission.storage,
              Permission.bluetooth,
              Permission.bluetoothConnect,
              Permission.bluetoothScan
            ].request();
            if (!status) {
              await FlutterBluePlus.turnOn();
              await Future.delayed(Duration(seconds: 3));
              if (await FlutterBluePlus.isOn) {
                context.read<BluetoothConnection>().changeBluetoothStatus(true);
              }
            } else {
              FlutterBluePlus.turnOff();
              await context.read<BluetoothConnection>().disconnect();
              context.read<BluetoothConnection>().changeBluetoothStatus(false);
              context.read<TransformParams>().resetData();
            }
            setState(() {
              status = value;
            });
          },
        ),
      ),
    );
  }
}
