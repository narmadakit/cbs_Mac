import 'dart:developer';

import 'package:finsta_mac/Calculator/FDTab.dart';
import 'package:finsta_mac/Calculator/bloc/FdBloc/FDBloc.dart';
import 'package:finsta_mac/Calculator/bloc/FdBloc/FDEvent.dart';
import 'package:finsta_mac/Calculator/bloc/FdBloc/FDState.dart';
import 'package:finsta_mac/components/KeyValueModel.dart';
import 'package:finsta_mac/network/Repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/CustomDropdown.dart';

class DepositesTab extends StatefulWidget {
  const DepositesTab({
    super.key,
  });

  @override
  State<DepositesTab> createState() => _DepositesTabState();
}

class _DepositesTabState extends State<DepositesTab> {
  String _selectedValue = "Select";
  int? selectedRadioValue = 0;
  List<KeyValueModel> depositType=[
    KeyValueModel(id: "1", name: "FIXED DEPOSIT"),
    KeyValueModel(id: "2", name: "RECURRING DEPOSIT"),
  ];
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Deposit Type'),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: const Text('Fixed Deposit'),
                  contentPadding: const EdgeInsets.all(0.0),
                  dense: true,
                  horizontalTitleGap: 0,
                  titleTextStyle: const TextStyle(fontSize: 12,color: Colors.black),
                  leading: Radio<int>(
                    value: 1,
                    groupValue: selectedRadioValue,
                    onChanged: (int? value) {
                      setState(() {
                        selectedRadioValue = value;
                        _selectedValue = "FIXED DEPOSIT";
                        const FDTab();
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text('Recurring Deposit'),
                  contentPadding: const EdgeInsets.all(0.0),
                  dense: true,
                  horizontalTitleGap: 0,
                  titleTextStyle: const TextStyle(fontSize: 12,color: Colors.black),
                  leading: Radio<int>(
                    value: 2,
                    groupValue: selectedRadioValue,
                    onChanged: (int? value) {
                      setState(() {
                        selectedRadioValue = value;
                        _selectedValue = "RECURRING DEPOSIT";
                      });
                    },
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
