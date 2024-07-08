import 'dart:io';

import 'package:battery_monitoring_app/screens/check_bluetooth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bluetooth_connections.dart';

void main() {
  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
  }
  runApp(ChangeNotifierProvider<BluetoothConnection>(
    create: (_) => BluetoothConnection(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Battery monitoring app',
      color: Colors.lightBlue,
      home: CheckBluetoothStatusScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
