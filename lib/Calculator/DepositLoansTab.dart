import 'dart:developer';

import 'package:finsta_mac/Calculator/bloc/Loan/LoanBloc.dart';
import 'package:finsta_mac/Calculator/bloc/Loan/LoanEvent.dart';
import 'package:finsta_mac/Calculator/bloc/Loan/LoanState.dart';
import 'package:finsta_mac/Calculator/model/Loans/DepositLoanPayInModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanNameModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanTypeModel.dart';
import 'package:finsta_mac/components/CustomDropdown.dart';
import 'package:finsta_mac/utils/AppStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/AppWidgets.dart';
import '../components/CustomTextField.dart';
import '../components/KeyValueModel.dart';
import '../network/Repository.dart';

class DepositLoansTab extends StatefulWidget {
  const DepositLoansTab({
    super.key,
  });

  @override
  State<DepositLoansTab> createState() => _DepositLoansTabState();
}

class _DepositLoansTabState extends State<DepositLoansTab> {
  int? selectedRadioValue = 0;
  bool isFDVisible=false;
  bool isRDVisible=false;
  var _selectedLoanType = KeyValueModel(id: "0", name: "Select");
  var _selectedNameType = KeyValueModel(id: "0", name: "Select");
  var _selectedInterestType = KeyValueModel(id: "0", name: "Select");
  var _selectedInstallMode = KeyValueModel(id: "0", name: "Select");
  var _selectedPayIn = KeyValueModel(id: "0", name: "Select");
  List<KeyValueModel> kvLoanTypeList=[];
  List<KeyValueModel> kvLoanNameList=[];

  List<KeyValueModel> kvInterestTypeList=[
  KeyValueModel(id: "1", name: "Flat"),
  KeyValueModel(id: "2", name: "Diminishing"),
  ];

  List<KeyValueModel> kvInstallModeList=[
    KeyValueModel(id: "1", name: "Equated Instalment"),
    KeyValueModel(id: "2", name: "Equated Principle Instalment"),
    KeyValueModel(id: "3", name: "Only Interest (Principle is paid at end of tenure)"),
  ];

  List<KeyValueModel> kvPayInList=[];

  bool isLoading = false;
  var amountTextController=TextEditingController();
  double minInterestRate =0.0;
  double maxInterestRate=20.0;
  // Define the current values for the range
  double _currentRangeValues = 15;

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider<LoanBloc>(create: (context) => LoanBloc(Repository())..add(LoanInitEvent()))
      ],
      child:BlocConsumer<LoanBloc,LoanState>(
          builder: (context, state) {
            if(state is LoanLoadingState){
              return Center(child: CircularProgressIndicator(color: AppStyles.btnColor));
            }
            if(state is GeLoanTypeSuccessState){
              return buildBody(context);
            }
            if(state is GeLoanPayInSuccessState){
              return buildBody(context);
            }
             else{
               return buildBody(context);
            }
          },
          listener: (context, state) {
            if(state is GeLoanTypeSuccessState){
              kvLoanTypeList = LoanTypeModel.keyValueList(state.responseModel);
            }
            else if(state is GeLoanNameSuccessState){
              kvLoanNameList = LoanNameModel.keyValueList(state.responseModel);
            }
            else if(state is GeLoanPayInSuccessState){
              kvPayInList = DepositLoanPayInModel.keyValueList(state.responseModel);
            }
          },)
    );
  }

  Widget buildBody(BuildContext context) {
    double gapHeight=20.0;
    return Padding(
                padding: const EdgeInsets.all(15.0),
                child:  Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: gapHeight),
                            Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text('Loan Type',style: AppStyles.boldTextBlack)),
                                Expanded(
                                  flex: 4,
                                  child: CustomDropdown(context: context, selectedValue: _selectedLoanType,
                                      items:kvLoanTypeList, onChanged: (value) {
                                        setState(() {
                                          _selectedLoanType = value;
                                          _selectedNameType = KeyValueModel(id: "0", name: "Select");
                                        });
                                        Navigator.pop(context);
                                        context.read<LoanBloc>().add(GetLoanNameEvent(_selectedLoanType.id));
                                      }, hint: ""),
                                )
                              ],
                            ),
                            SizedBox(height: gapHeight),
                            Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text('Loan Name',style: AppStyles.boldTextBlack)),
                                Expanded(
                                  flex: 4,
                                  child: CustomDropdown(context: context, selectedValue: _selectedNameType,
                                      items:kvLoanNameList, onChanged: (value) {
                                        setState(() {
                                          _selectedNameType = value;
                                          _selectedPayIn = KeyValueModel(id: "0", name: "Select");
                                        });
                                        Navigator.pop(context);
                                        log("loan id===== ${_selectedNameType.id}");
                                        context.read<LoanBloc>().add(GetLoanPayInEvent(_selectedNameType.id,_selectedPayIn.id));
                                      }, hint: ""),
                                )
                              ],
                            ),
                            SizedBox(height: gapHeight),
                            Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text('Loan Pay-in',style: AppStyles.boldTextBlack)),
                                Expanded(
                                  flex: 4,
                                  child: CustomDropdown(context: context, selectedValue: _selectedPayIn,
                                      items:kvPayInList, onChanged: (value) {
                                        setState(() {
                                          _selectedPayIn = value;
                                        });
                                        Navigator.pop(context);
                                      }, hint: ""),
                                )
                              ],
                            ),
                            SizedBox(height: gapHeight),
                            Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text('Interest Type',style: AppStyles.boldTextBlack)),
                                Expanded(
                                  flex: 4,
                                  child: CustomDropdown(context: context, selectedValue: _selectedInterestType,
                                      items:kvInterestTypeList, onChanged: (value) {
                                        setState(() {
                                          _selectedInterestType = value;
                                        });
                                        Navigator.pop(context);
                                      }, hint: ""),
                                )
                              ],
                            ),
                            SizedBox(height: gapHeight),
                            Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text('Loan Amount',style: AppStyles.boldTextBlack)),
                                Expanded(
                                  flex: 4,
                                  child: CustomTextField(
                                      boxHeight: 45,
                                      context: context, controller: amountTextController,
                                      onChanged: (value) {
                                        // if(amountTextController.text != ""){
                                        //   context.read<RDBloc>().add(GetRDInterestDetailsEvent(_selectedRDNameValue.id,_selectedRDNameValue.name, tenureTxtController.text,_selectedTenureValue.name,rdAmountController.text));
                                        // }
                                      }, hint: "Enter Loan Amount", textInputType: TextInputType.number),
                                )
                              ],
                            ),
                            SizedBox(height: gapHeight),
                            Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text('Tenure',style: AppStyles.boldTextBlack)),
                                Expanded(
                                  flex: 4,
                                  child: CustomDropdown(context: context, selectedValue: _selectedInterestType,
                                      items:kvInterestTypeList, onChanged: (value) {
                                        setState(() {
                                          _selectedInterestType = value;
                                        });
                                        Navigator.pop(context);
                                      }, hint: ""),
                                )
                              ],
                            ),
                            SizedBox(height: gapHeight),
                            Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text('Loan Installment Mode',style: AppStyles.boldTextBlack)),
                              const SizedBox(width: 5),
                                Expanded(
                                  flex: 4,
                                  child: CustomDropdown(context: context, selectedValue: _selectedInstallMode,
                                      items:kvInstallModeList, onChanged: (value) {
                                        setState(() {
                                          _selectedInstallMode = value;
                                        });
                                        Navigator.pop(context);
                                      }, hint: ""),
                                )
                              ],
                            ),
                            SizedBox(height: gapHeight),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text('Interest Rate\n(Per annum)',style: AppStyles.boldTextBlack)),
                                const SizedBox(width: 10,),
                                Expanded(
                                  flex: 5,
                                  child: Slider(
                                    value: _currentRangeValues,
                                    divisions: 100,
                                    activeColor: AppStyles.btnColor,
                                    inactiveColor: AppStyles.bgColor3,
                                    min: minInterestRate,
                                    max: maxInterestRate,
                                    label: '${_currentRangeValues.toStringAsFixed(1)}%',
                                    onChanged: (value) {
                                      setState(() {
                                        _currentRangeValues = value;
                                      });
                                    },),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    payButton(() {
                      // context.read<LoanBloc>().add(GetRDMaturityEvent(_selectedPayInValue.name,tenureTxtController.text, rdAmountController.text,
                      //     _selectedPayOutValue.name,_selectedInterestTypeValue.name,
                      //     interestRateController.text,interestDetailsModel.pCaltype.toString(),interestDetailsModel.pCompoundInterestType.toString()
                      // ));
                    },"CALCULATE",disable: false),
                  ],
                )
            );
  }
}

