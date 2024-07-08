import 'package:battery_monitoring_app/bluetooth_connections.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionPress extends StatelessWidget {
  final String title;
  final int choice;
  final Function function;
  final bool value;

  const OptionPress(
      {Key? key,
      required this.title,
      required this.choice,
      required this.function,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600]),
          ),
          if (choice == 1)
            Switch(
                value: value,
                onChanged: (bool newValue) {
                  function(newValue);
                }),
          if (choice == 2)
            ElevatedButton(
                onPressed: () => function(), child: const Text("Calibrate"))
        ],
      ),
    );
  }
}

class OptionChange extends StatelessWidget {
  final String title;
  final Function function;
  final int choice;

  const OptionChange({Key? key,
    required this.title,
    required this.function,
    required this.choice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 11),
      child: TextButton(
        onPressed: () => function(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600]),
            ),
            choice == 1
                ? const Icon(
              Icons.arrow_forward,
              color: Colors.grey,
            )
                : Text(
              '${context
                  .read<BluetoothConnection>()
                  .batCapacity} mAH',
              style: const TextStyle(fontSize: 15, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
