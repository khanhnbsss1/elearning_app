import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class CountDownClock extends StatefulWidget {
  const CountDownClock({super.key, required this.endTime});

  final Duration endTime;

  @override
  State<CountDownClock> createState() => _CountDownClockState();
}

class _CountDownClockState extends State<CountDownClock> {
  Duration _remainingTime = Duration.zero;
  bool check = false;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.endTime;
    _update();
  }

  void _update() async {
    while (_remainingTime.inSeconds > 0) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _remainingTime = _remainingTime - const Duration(seconds: 1);
      });
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text('time-left '),
          Text(
              '${_remainingTime.inMinutes}:${_remainingTime.inSeconds.remainder(60)}')
        ],
      ),
    );
  }
}
