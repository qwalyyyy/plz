import 'dart:math';

import 'package:flutter/material.dart';

class Slots extends StatelessWidget {
  const Slots({
    super.key,
    this.slotsIndex,
  });

  static List<String> slotsIcon = [
    'StrawberrySpin',
    'Apple',
    'Banana',
    'Peach',
    'Watermelon'
  ];

  static List<int> slotsError = [1];

  static List<int> spin() => [
        Random().nextInt(5),
        Random().nextInt(5),
        Random().nextInt(5),
        Random().nextInt(5),
        Random().nextInt(5),
      ];

  final List<int>? slotsIndex;

  @override
  Widget build(BuildContext context) {
    List<int> slots = slotsIndex ?? [0, 0, 0, 0, 0];
    if (slots.isEmpty) slots = [0, 0, 0, 0, 0];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int N in slots)
            Expanded(
              child: Image(
                image: AssetImage('assets/${slotsIcon[N]}.png'),
              ),
            ),
        ],
      ),
    );
  }
}
