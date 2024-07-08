import 'package:battery_monitoring_app/data_utils.dart';
import 'package:battery_monitoring_app/battery_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
class CellsVoltageWhole extends StatelessWidget {
  const CellsVoltageWhole({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ModelBatteryParams params = context.watch<TransformParams>().modelBatteryParams;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CellsVoltageIndicator(cellsNumber: 'Bat 1', icon: Icon(CupertinoIcons.battery_0, size: 70,) , cellsVoltage: '${params.cellVolt1} V'),
        CellsVoltageIndicator(cellsNumber: 'Bat 2', icon: Icon(CupertinoIcons.battery_0, size: 70,) , cellsVoltage: '${params.cellVolt2} V'),
        CellsVoltageIndicator(cellsNumber: 'Bat 3', icon: Icon(CupertinoIcons.battery_0, size: 70,) , cellsVoltage: '${params.cellVolt3} V'),
        CellsVoltageIndicator(cellsNumber: 'Bat 4', icon: Icon(CupertinoIcons.battery_0, size: 70,) , cellsVoltage: '${params.cellVolt4} V'),
      ],
    );
  }
  }

class CellsVoltageIndicator extends StatelessWidget {
  final String cellsNumber;
  final Icon icon;
  final String cellsVoltage;

  const CellsVoltageIndicator(
      {Key? key, required this.cellsNumber, required this.icon, required this.cellsVoltage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(child: Text(cellsNumber,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),),
        const Icon(CupertinoIcons.battery_0, size: 70,),
        Center(child: Text(cellsVoltage,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),),
      ],
    );
  }
}

