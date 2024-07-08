import 'package:battery_monitoring_app/widgets/scan_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class FindDevicesScreen extends StatelessWidget {
  const FindDevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Devices'),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            FlutterBluePlus.startScan(timeout: Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: StreamBuilder<List<ScanResult>>(
            stream: FlutterBluePlus.scanResults,
            initialData: [],
            builder: (c, snapshot) => Column(
              children: snapshot.data!
                  .map(
                    (r) => ScanResultTile(
                      result: r,
                      onTap: () => Navigator.of(context).pop(r.device),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBluePlus.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data!) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => FlutterBluePlus.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () => FlutterBluePlus
                    .startScan(timeout: Duration(seconds: 4)));
          }
        },
      ),
    );
  }
}
