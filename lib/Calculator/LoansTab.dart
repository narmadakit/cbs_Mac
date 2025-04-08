import 'package:flutter/material.dart';

class LoansTab extends StatefulWidget {
  const LoansTab({
    super.key,
  });

  @override
  State<LoansTab> createState() => _LoansTabState();
}

class _LoansTabState extends State<LoansTab> {
  int? selectedRadioValue = 0;
  bool isFDVisible=false;
  bool isRDVisible=false;
  @override
  Widget build(BuildContext context) {
    return  const Padding(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Loan Type'),
            ],
          ),
        )
    );
  }
}

