import 'dart:convert';

import 'package:battery_monitoring_app/battery_model.dart';
import 'package:flutter/widgets.dart';

final ModelBatteryParams _firstData = ModelBatteryParams(
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
);

ModelBatteryParams _initialData = ModelBatteryParams(
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
);

List<String> parsedData = List<String>.empty(growable: true);
List<int> originalData = List<int>.empty(growable: true);

class TransformParams extends ChangeNotifier {
  ModelBatteryParams _modelBatteryParams = _initialData;

  ModelBatteryParams get modelBatteryParams => _modelBatteryParams;

  updateData(ModelBatteryParams modelBatteryParams) {
    _modelBatteryParams = modelBatteryParams;
    notifyListeners();
  }

  resetData() {
    _modelBatteryParams = _firstData;
    notifyListeners();
  }

  ParsingData(List<int> data) {
    data.forEach((value) {
      if (value == 10) {
        String data = utf8.decode(originalData).trim();
        List<String> parsedData = data.split(",");
        if (parsedData.length == 9) {
          ModelBatteryParams data = ModelBatteryParams(
              double.parse(parsedData[0]),
              double.parse(parsedData[1]),
              double.parse(parsedData[2]),
              double.parse(parsedData[3]),
              double.parse(parsedData[4]),
              double.parse(parsedData[5]),
              double.parse(parsedData[6]),
              double.parse(parsedData[7]),
              double.parse(parsedData[8]));
          _modelBatteryParams = data;
          print(data);
          notifyListeners();
        }
        originalData.clear();
      } else {
        originalData.add(value);
      }
    });
  }
}
