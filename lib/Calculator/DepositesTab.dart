import 'package:finsta_mac/Calculator/FDTab.dart';
import 'package:finsta_mac/components/KeyValueModel.dart';
import 'package:finsta_mac/utils/AppStyles.dart';
import 'package:flutter/material.dart';

import 'RDTab.dart';

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
  bool isFDVisible=false;
  bool isRDVisible=false;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text('Select Deposit Type',style: AppStyles.customTextStyle(fontSize: 17, color: Colors.black),)),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('Fixed Deposit',style: AppStyles.customTextStyle(color: Colors.black,fontSize: 12),),
                    contentPadding: const EdgeInsets.all(10.0),
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
                          isFDVisible = true;
                          isRDVisible = false;
                          // context.read<FDBloc>().add(FDInitEvent(_selectedValue.toString()));
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('Recurring Deposit',style: AppStyles.customTextStyle(color: Colors.black,fontSize: 12)),
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
                          isRDVisible = true;
                          isFDVisible = false;
                          // context.read<FDBloc>().add(FDInitEvent(_selectedValue.toString()));
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
                visible: isFDVisible,
                child: const FDTabWidget()),
            Visibility(
                visible: isRDVisible,
                child: const RDTabWidget()),
          ],
        ),
      )
    );
  }
}

