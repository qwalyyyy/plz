import 'package:casino/ui/bet.dart';
import 'package:casino/ui/button.dart';
import 'package:casino/ui/slots.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  final int counter;
  final Function() onTap;
  final Function() plus;
  final Function() minus;
  final int bet;
  final List<int> slots;

  const Body({
    super.key,
    this.counter = 10,
    required this.onTap,
    required this.plus,
    required this.minus,
    required this.bet,
    required this.slots,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animatedCounter;
  int _currentCounter = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animatedCounter = IntTween(begin: 0, end: widget.counter).animate(_controller)
      ..addListener(() {
        setState(() {
          _currentCounter = _animatedCounter.value;
        });
      });
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant Body oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.counter != oldWidget.counter) {
      _controller.reset();
      _animatedCounter = IntTween(begin: _currentCounter, end: widget.counter).animate(_controller);
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _animatedScore(),
          const SizedBox(height: 20),
          Slots(slotsIndex: widget.slots),
          const SizedBox(height: 40),
          Button(onTap: widget.onTap),
          const SizedBox(height: 60),
          Bet(
            bet: widget.bet,
            minus: widget.minus,
            plus: widget.plus,
          ),
        ],
      ),
    );
  }

  Widget _animatedScore() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _currentCounter.toString(),
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        const SizedBox(width: 10),
        const Image(
          width: 36,
          height: 36,
          image: AssetImage('assets/Coin.png'),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
