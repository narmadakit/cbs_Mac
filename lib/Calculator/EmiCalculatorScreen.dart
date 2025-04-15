import 'package:flutter/material.dart';

import '../components/AppWidgets.dart';
import '../components/CustomMainBackground.dart';
import '../utils/AppStyles.dart';
import 'DepositesTab.dart';
import 'LoansCalculatorTab.dart';

class EmiCalculatorScreen extends StatefulWidget {
  const EmiCalculatorScreen({super.key});

  @override
  State<EmiCalculatorScreen> createState() => _EmiCalculatorScreenState();
}

class _EmiCalculatorScreenState extends State<EmiCalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CustomMainBackground(
          title: 'Emi Calculator',
          isBackButton: true,
          tabBar: TabBar(
            splashBorderRadius: BorderRadius.circular(
              25.0,
            ),
            dividerColor: Colors.transparent,
            indicator:colorButtonDecoration(AppStyles.cardColor),
            automaticIndicatorColorAdjustment: true,
            unselectedLabelStyle: AppStyles.customTextStyle(color: AppStyles.btnColor),
            labelStyle: AppStyles.customTextStyle(color: Colors.white),
            indicatorPadding: const EdgeInsets.all(0),
            tabs: [
              Container(
                height: 40,
                  width: double.infinity,
                  decoration: borderButtonDecoration(AppStyles.cardColor),
                  child: const Tab(text: "LOANS",)),
              Container(
                  height: 40,
                  width: double.infinity,
                  decoration: borderButtonDecoration(AppStyles.cardColor),
                  child: const Tab( text: "DEPOSITS")),
            ],
          ),
          body:buildBody(context)
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return const TabBarView(
      children: [
        LoansCalculatorTab(),
        DepositesTab(),
      ],
    );
  }

}
