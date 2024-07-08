import 'package:battery_monitoring_app/widgets/mid_indicator_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomLog extends StatelessWidget {
  const BottomLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Column(
        children: [
          MidIndicatorParameters(values: "Options"),
          BottomLogContent()
        ],
      ),
    );
  }
}

class BottomLogContent extends StatelessWidget {
  const BottomLogContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BottomLogContentWidget(names: 'Calibrate Capacity', function: dummyFunction),
        BottomLogContentWidget(names: 'Fix SOC by Volt', function: dummyFunction),
      ],
    );
  }
  void dummyFunction() {
    print('hello world');
  }
}

class BottomLogContentWidget extends StatelessWidget {
  final String names;
  final Function function;
  const BottomLogContentWidget({Key? key, required this.names, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () => function(),
        child: Text(names, style: const TextStyle(fontSize: 13), maxLines: 2,),
      ),
    );
  }
}



