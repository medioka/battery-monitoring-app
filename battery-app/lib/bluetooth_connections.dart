import 'package:flutter/widgets.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothConnection extends ChangeNotifier {
  BluetoothDevice? _device;
  BluetoothService? _service;
  BluetoothDevice? _autoPairDevice;
  BluetoothDeviceState? _connectionStatus;
  BluetoothCharacteristic? _characteristic;
  bool _statusBluetooth = false;
  bool _isPairEnable = false;
  double _batCapacity = 5736;

  BluetoothDevice? get device => _device;

  BluetoothService? get service => _service;

  BluetoothDevice? get autoPairDevice => _autoPairDevice;

  BluetoothDeviceState? get connectionStatus => _connectionStatus;

  BluetoothCharacteristic? get characteristic => _characteristic;

  bool get statusBluetooth => _statusBluetooth;

  bool get isPairEnable => _isPairEnable;

  double get batCapacity => _batCapacity;

  void changeBluetoothStatus(bool s) {
    _statusBluetooth = s;
    notifyListeners();
  }

  void selectAutoPairDevice(BluetoothDevice? device) {
    _autoPairDevice = device;
    notifyListeners();
  }

  void selectDevice(BluetoothDevice? device) {
    _device = device;
    notifyListeners();
  }

  void setCharactersitic(BluetoothCharacteristic targetCharacteristic) {
    _characteristic = targetCharacteristic;
    notifyListeners();
  }

  void setService(BluetoothService? service) {
    _service = service;
    notifyListeners();
  }

  void changeBatCapacity(double value) {
    _batCapacity = value;
    notifyListeners();
  }

  void changePairStatus(bool value) {
    _isPairEnable = value;
    notifyListeners();
  }

  connect() async {
    await _device!.connect();
    print('device connected');
    _connectionStatus = (await device!.state.first) as BluetoothDeviceState?;
    notifyListeners();
  }

  disconnect() async {
    await _device!.disconnect();
    _connectionStatus = null;
    _service = null;
    _characteristic = null;
    _device = null;
    _statusBluetooth = false;
    print('Device disconnected');
    notifyListeners();
  }
}
