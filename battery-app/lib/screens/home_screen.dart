import 'dart:async';

import 'package:battery_monitoring_app/data_utils.dart';
import 'package:battery_monitoring_app/bluetooth_connections.dart';
import 'package:battery_monitoring_app/screens/sections/middle_section.dart';
import 'package:battery_monitoring_app/screens/sections/upper_section.dart';
import 'package:battery_monitoring_app/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription? streamSubscription;
  BluetoothCharacteristic? characteristic;
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    BluetoothDevice? device = context.watch<BluetoothConnection>().device;
    characteristic = context.watch<BluetoothConnection>().characteristic;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          device == null ? 'No connection' : device.name,
          style: const TextStyle(fontSize: 15),
        ),
        backgroundColor: Colors.lightBlue,
        elevation: 0.3,
        actions: [
          IconButton(
            onPressed: characteristic != null
                ? characteristic!.isNotifying
                    ? () => cancelListeningInput()
                    : () => listeningInput()
                : null,
            color: characteristic == null
                ? Colors.white
                : characteristic!.isNotifying
                    ? Colors.redAccent
                    : Colors.green,
            icon: const Icon(Icons.bluetooth_audio),
          ),
          // IconButton(
          //   onPressed: () => cancelListeningInput(),
          //   color: Colors.red,
          //   icon: const Icon(Icons.bluetooth_audio),
          // ),
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsScreen())),
          )
        ],
      ),
      body: const Stack(
        children: [
          UpperSection(),
          MidSection(),
        ],
      ),
    );
  }

  void listeningInput() async {
    if (characteristic!.isNotifying == false) {
      await characteristic!.setNotifyValue(true);
      streamSubscription = characteristic!.value
          .listen((context.read<TransformParams>().ParsingData));
    }
    setState(() {});
  }

  cancelListeningInput() async {
    await characteristic!.setNotifyValue(false);
    await streamSubscription!.cancel();
    context.read<TransformParams>().resetData();
    setState(() {});
  }
}
