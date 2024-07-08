import 'package:flutter/material.dart';

import '../widgets/mid_indicator_status.dart';

class UpperLog extends StatelessWidget {
  const UpperLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Column(
        children: [
          MidIndicatorParameters(
            values: "Parameter Status",
          ),
          UpperLogContent(),
        ],
      ),
    );
  }
}

class UpperLogContent extends StatelessWidget {
  const UpperLogContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        UpperLogContentWidget(
            params: 'Average Voltage', icon: Icon(Icons.battery_full)),
        UpperLogContentWidget(
            params: 'Battery Capacity', icon: Icon(Icons.battery_full))
      ],
    );
  }
}

class UpperLogContentWidget extends StatelessWidget {
  final String params;
  final Icon icon;

  const UpperLogContentWidget(
      {Key? key, required this.params, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic value = '14.4';
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.grey),
      child: Column(
        children: [
          Text(
            params,
            style: const TextStyle(fontSize: 15),
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),
          Text(
            '$value V',
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
