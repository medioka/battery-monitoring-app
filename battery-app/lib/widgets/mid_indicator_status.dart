import 'package:flutter/material.dart';

class MidIndicatorParameters extends StatelessWidget {
  final String values;

  const MidIndicatorParameters({Key? key, required this.values})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          values,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Divider(
          color: Colors.black,
          thickness: .5,
        ),
      ],
    );
  }
}
