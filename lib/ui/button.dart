import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function() onTap;

  const Button({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(color: Colors.red),
          ),
        ),
      ),
      onPressed: onTap,
      child: Text(
        "Spin".toUpperCase(),
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
