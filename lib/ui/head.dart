import 'package:flutter/material.dart';

class Head extends StatelessWidget implements PreferredSizeWidget {
  const Head({super.key, required this.balance});
  final int balance;
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text('Win your million'),
      leading: const Image(image: AssetImage('assets/Strawberry.png')),
      actions: [_balance()],
    );
  }

  Widget _balance() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(balance.toString()),
          const SizedBox(width: 8),
          const Image(
            width: 36,
            height: 36,
            image: AssetImage('assets/Coin.png'),
          ),
        ],
      ),
    );
  }
}
