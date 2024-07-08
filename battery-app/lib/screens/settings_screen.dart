import 'dart:convert';
import 'package:battery_monitoring_app/bluetooth_connections.dart';
import 'package:battery_monitoring_app/widgets/settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';
import 'find_devices_page.dart';
import '../widgets/select_bonded_page.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings Screen'),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            OptionPress(
                title: "Auto-Pair",
                choice: 1,
                function: changePairEnable,
                value: context.read<BluetoothConnection>().isPairEnable),
            OptionChange(
                title: 'Select Auto-Pair',
                function: selectPairDevices,
                choice: 1),
            OptionChange(
                title: 'Find Devices', function: findDevices, choice: 1),
            OptionChange(
                title: 'Capacity', function: setBatCapacity, choice: 1),
            OptionChange(
                title: 'Calibrate to 100%',
                function: calibrateBattery,
                choice: 1),
          ],
        ));
  }

  selectPairDevices() async {
    if (await FlutterBluePlus.isOn) {
      BluetoothDevice? _autoPairDevice = await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SelectBondedPage()));
      context.read<BluetoothConnection>().selectAutoPairDevice(_autoPairDevice);
    } else {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text("Turn on the Bluetooth")));
    }
  }

  changePairEnable(bool newValue) {
    setState(() {
      context.read<BluetoothConnection>().isPairEnable;
    });
  }

  findDevices() async {
    {
      const String SERVICE_UUID = "0000ffe0-0000-1000-8000-00805f9b34fb";
      const String CHARACTERISTIC_UUID = "0000ffe1-0000-1000-8000-00805f9b34fb";
      bool condition = await FlutterBluePlus.isOn;
      if (condition) {
        BluetoothDevice? _device = await Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => FindDevicesScreen()));
        context.read<BluetoothConnection>().selectDevice(_device);
        if (_device != null) {
          showDialog(
              context: context,
              builder: (context) => const Center(
                    child: Center(child: CircularProgressIndicator()),
                  ));
          await context.read<BluetoothConnection>().connect();
          final result = await FlutterBluePlus.connectedDevices;
          if (result.isNotEmpty) {
            _device = result.first;
            var services = await _device.discoverServices();
            services.forEach(
              (service) {
                if (service.uuid.toString() == SERVICE_UUID) {
                  service.characteristics.forEach((characteristic) async {
                    if (characteristic.uuid.toString() == CHARACTERISTIC_UUID) {
                      BluetoothCharacteristic _characteristic = characteristic;
                      context
                          .read<BluetoothConnection>()
                          .setCharactersitic(_characteristic);
                      // characteristic
                      //    .setNotifyValue(!characteristic.isNotifying);
                      print("All Ready with ${_device!.name}");
                      print("here is the characteristic: $_characteristic");
                    }
                  });
                }
              },
            );
          }
          Navigator.of(context).pop();
          setState(() {});
        }
      } else {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
              const SnackBar(content: Text("Enable your bluetooth first")));
      }
    }
  }

  setBatCapacity() async {
    final BluetoothDeviceState? _connection =
        context.read<BluetoothConnection>().connectionStatus;
    if (await FlutterBluePlus.isOn &&
        _connection == BluetoothDeviceState.connected) {
      final newCap = await changeCapacity();
      if (newCap == null) {
        AlertDialog(
          title: const Text("Warning Dialog"),
          content: const Text("There must be a value in the box"),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            )
          ],
        );
        return;
      }
      ;
      print(newCap);
      // //send to bluetooth
      _sendMessage("$newCap,cap");
      context
          .read<BluetoothConnection>()
          .changeBatCapacity(double.parse(newCap));
    }
    if (await FlutterBluePlus.isOn == false) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
            const SnackBar(content: Text("Enable your bluetooth first")));
      return;
    }
    if (_connection != BluetoothDeviceState.connected) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text("No device connected")));
      return;
    }
  }

  calibrateBattery() async {
    bool condition = await FlutterBluePlus.isOn;
    BluetoothDeviceState? _connection =
        context.read<BluetoothConnection>().connectionStatus;
    if (condition && _connection == BluetoothDeviceState.connected) {
      //send to bluetooth
      await _sendMessage("100,perc");
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
            const SnackBar(content: Text("Percentage has been calibrated")));
      return;
    }
    if (!condition) {
      //send to bluetooth
      await _sendMessage("100,perc");
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text("Enable Bluetooth First")));
      return;
    }
    if (_connection != BluetoothDeviceState.connected) {
      //send to bluetooth
      await _sendMessage("100,perc");
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text("No Device Connected")));
      return;
    }
  }

  Future<String?> changeCapacity() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Input battery capacity"),
            content: TextField(
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration:
                  const InputDecoration(hintText: "Enter battery capacity"),
              controller: _textEditingController,
            ),
            actions: [
              TextButton(
                child: const Text("Submit"),
                onPressed: () {
                  Navigator.of(context).pop(_textEditingController.text);
                },
              )
            ],
          ));

  Future<void> _sendMessage(String text) async {
    text = text.trim();
    BluetoothCharacteristic? _characteristic =
        context.read<BluetoothConnection>().characteristic;
    _textEditingController.clear();
    if (text.isNotEmpty && _characteristic != null) {
      try {
        List<int> bytes = utf8.encode(text);
        debugPrint("Data sended");
        await _characteristic.write(bytes, withoutResponse: false);
      } catch (e) {
        print("there is an error: $e");
      }
    }
  }
}
