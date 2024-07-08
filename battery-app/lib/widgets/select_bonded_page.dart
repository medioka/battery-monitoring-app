import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothDeviceListEntry extends ListTile {
  BluetoothDeviceListEntry({super.key,
    required BluetoothDevice device,
    GestureTapCallback? onTap,
  }) : super(
          onTap: onTap,
          leading: Icon(Icons.devices),
          title: Text(device.name),
          subtitle: Text(device.id.toString()),
        );
}

class SelectBondedPage extends StatefulWidget {
  const SelectBondedPage({Key? key}) : super(key: key);

  @override
  State<SelectBondedPage> createState() => _SelectBondedPageState();
}

class _SelectBondedPageState extends State<SelectBondedPage> {
  List devices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Device"),
      ),
      body: FutureBuilder(
        future: FlutterBluePlus.bondedDevices,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            // while data is loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // data loaded:
            devices = snapshot.data;
            return ListView(
              children: devices.map((value) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(value.name),
                      ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(value),
                          child: Text("SET"))
                    ],
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
