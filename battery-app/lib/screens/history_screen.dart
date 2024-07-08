import 'package:flutter/material.dart';
import '../settings/bottom_section_log.dart';
import '../settings/middle_section_log.dart';
import '../settings/upper_section_log.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Colors.lightBlue,
        elevation: 0,
      ),
      backgroundColor: Colors.lightBlue,
      body: Container(
          padding: const EdgeInsets.only(top: 10),
          margin: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              color: Colors.white),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              UpperLog(),
              SizedBox(
                height: 20,
              ),
              MiddleLog(),
              SizedBox(
                height: 20,
              ),
              BottomLog()
            ],
          )),
    );
  }
}
