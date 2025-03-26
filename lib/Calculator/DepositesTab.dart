import 'package:flutter/material.dart';

class DepositesTab extends StatelessWidget {
  const DepositesTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceAround,
            children: [
              Text('Deposit Type'),
              Text('Drop down'),
            ],
          ),


        ],
      ),
    );
  }
}
