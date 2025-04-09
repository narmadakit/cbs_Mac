import 'package:finsta_mac/components/CustomDropdown.dart';
import 'package:flutter/material.dart';

import '../components/KeyValueModel.dart';

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
  var _selectedLoanType = KeyValueModel(id: "0", name: "Select");

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.all(15.0),
        child:  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Loan Type'),
              // CustomDropdown(context: context, selectedValue: _selectedLoanType, items: items, onChanged: onChanged, hint: hint)
            ],
          ),
        )
    );
  }
}

