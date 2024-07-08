import 'package:battery_monitoring_app/data_utils.dart';
import 'package:battery_monitoring_app/bluetooth_connections.dart';
import 'package:battery_monitoring_app/screens/Home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';

class CheckBluetoothStatusScreen extends StatefulWidget {
  const CheckBluetoothStatusScreen({Key? key}) : super(key: key);

  @override
  State<CheckBluetoothStatusScreen> createState() =>
      _CheckBluetoothStatusScreenState();
}

class _CheckBluetoothStatusScreenState
    extends State<CheckBluetoothStatusScreen> {
  BluetoothAdapterState _bluetoothState = BluetoothAdapterState.unknown;

  @override
  void initState() {
    FlutterBluePlus.adapterState.listen((state) => setState(() {
          _bluetoothState = state;
          if (state == BluetoothAdapterState.off) {
            context.read<BluetoothConnection>().changeBluetoothStatus(false);
            if (context.read<BluetoothConnection>().device == null) {}
          } else if (state == BluetoothAdapterState.on) {
            context.read<BluetoothConnection>().changeBluetoothStatus(true);
          }
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothAdapterState>(
      stream: FlutterBluePlus.adapterState,
      initialData: _bluetoothState,
      builder: (context, snapshot) {
        final state = snapshot.data;
        print(
            'Here is the status : ${context.read<BluetoothConnection>().statusBluetooth}');
        if (state == BluetoothAdapterState.on) {
          return ChangeNotifierProvider<TransformParams>(
            create: (_) => TransformParams(),
            child: const HomeScreen(),
          );
        }
        // return const BluetoothOffScreen();
        return ChangeNotifierProvider<TransformParams>(
          create: (_) => TransformParams(),
          child: const HomeScreen(),
        );
      },
    );
  }
}
