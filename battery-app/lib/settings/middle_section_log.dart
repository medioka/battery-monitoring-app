import 'package:battery_monitoring_app/widgets/mid_indicator_values.dart';
import 'package:flutter/material.dart';

import '../widgets/mid_indicator_status.dart';

class MiddleLog extends StatelessWidget {
  const MiddleLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Column(
        children: [
          MidIndicatorParameters(
            values: "History Status",
          ),
          MiddleLogContent()
          
        ],
      ),
    );
  }
}

class MiddleLogContent extends StatelessWidget {
  const MiddleLogContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
      ],
    );
  }
}
