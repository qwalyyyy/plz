import 'package:casino/ui/body.dart';
import 'package:casino/ui/slots.dart';
import 'package:flutter/material.dart';
import '../ui/head.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  int bet = 100;
  int balance = 1000;
  List<int> slots = [];
  late AnimationController _balanceController;
  late Animation<double> _balanceAnimation;
  
  @override
  void initState() {
    super.initState();
    _balanceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _balanceAnimation = Tween<double>(begin: balance.toDouble(), end: balance.toDouble()).animate(_balanceController);
  }

  void _updateBalance(int newBalance) {
    _balanceController.forward(from: 0);
    setState(() {
      _balanceAnimation = Tween<double>(begin: balance.toDouble(), end: newBalance.toDouble())
          .animate(CurvedAnimation(parent: _balanceController, curve: Curves.easeOut));
      balance = newBalance;
    });
  }

  void _addBet() {
    setState(() {
      if (bet + 10 <= balance) bet += 10;
    });
  }

  void _reduceBet() {
    setState(() {
      if (bet - 10 > 0) bet -= 10;
    });
  }

  void spinLogic() {
    if (balance < bet) {
      slots = Slots.slotsError;
      return;
    }

    _updateBalance(balance - bet);
    slots = Slots.spin();
    winBetLogic();
    _updateBalance(balance + _counter);
  }

  void winBetLogic() {
    int _counter = 0;

    Map<String, int> slotsWinCounters = {
      for (String slotName in Slots.slotsIcon) slotName: 0,
    };

    for (int slot in slots) {
      String slotName = Slots.slotsIcon[slot];
      slotsWinCounters[slotName] = slotsWinCounters[slotName]! + 1;
    }

    int maxMatch = slotsWinCounters.values.reduce((a, b) => a > b ? a : b);

    switch (maxMatch) {
      case 3:
        _counter = bet * 2;
        break;
      case 4:
        _counter = bet * 3;
        break;
      case 5:
        _counter = bet * 5;
        break;
      default:
        _counter = 0;
    }

    setState(() {
      balance += _counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Head(balance: balance),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text("Balance:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          AnimatedBuilder(
            animation: _balanceAnimation,
            builder: (context, child) {
              return Text(
                "\$${_balanceAnimation.value.toInt()}",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
              );
            },
          ),
          const SizedBox(height: 10),
          Text("Bet: \$${bet}", style: TextStyle(fontSize: 20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _reduceBet,
                icon: Icon(Icons.remove),
                label: Text("Lower Bet"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: _addBet,
                icon: Icon(Icons.add),
                label: Text("Raise Bet"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => setState(spinLogic),
            child: Text("SPIN", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: slots.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      Slots.slotsIcon[slots[index]],
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _balanceController.dispose();
    super.dispose();
  }
}
