import 'dart:developer';

import 'package:finsta_mac/Calculator/bloc/Loan/LoanCalculatorBloc.dart';
import 'package:finsta_mac/Calculator/bloc/Loan/LoansCalculatorEvent.dart';
import 'package:finsta_mac/Calculator/bloc/Loan/LoanCalculatorState.dart';
import 'package:finsta_mac/Calculator/model/Loans/DepositLoanPayInModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/FinalLoanViewModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanInstalmentModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanInterestRatesModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanNameModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanTypeModel.dart';
import 'package:finsta_mac/components/CustomDropdown.dart';
import 'package:finsta_mac/utils/AppStyles.dart';
import 'package:finsta_mac/utils/AppText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/AppWidgets.dart';
import '../components/CustomTextField.dart';
import '../components/KeyValueModel.dart';
import '../network/Repository.dart';
import '../utils/CustomTextFieldAmount.dart';

class LoansCalculatorTab extends StatefulWidget {
  const LoansCalculatorTab({
    super.key,
  });

  @override
  State<LoansCalculatorTab> createState() => _LoansCalculatorTabState();
}

class _LoansCalculatorTabState extends State<LoansCalculatorTab> {
  int? selectedRadioValue = 0;
  bool isFDVisible=false;
  bool isRDVisible=false;
  var _selectedLoanType = KeyValueModel(id: "0", name: "Select");
  var _selectedNameType = KeyValueModel(id: "0", name: "Select");
  var _selectedInterestType = KeyValueModel(id: "0", name: "Select");
  var _selectedPayIn = KeyValueModel(id: "0", name: "Select");
  var _selectedInstalmentMode = KeyValueModel(id: "0", name: "Select");
  List<KeyValueModel> kvLoanTypeList=[];
  List<KeyValueModel> kvLoanNameList=[];
  List<KeyValueModel> kvInstalmentModeList=[];
  List<KeyValueModel> kvInterestTypeList=[];
  List<KeyValueModel> kvPayInList=[];

  bool isLoading = false;
  var amountController=TextEditingController();
  var tenureTxtController=TextEditingController();
  double minInterestRate =0.0;
  double maxInterestRate=50.0;
  // Define the current values for the range
  double _currentRangeValues = 0;
  String schemeId="";
  List<LoanInterestRatesModel> interestRateList =[];
  List<LstInstalmentsgenerationDTO> loanViewModelList=[];

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider<LoanCalculatorBloc>(create: (context) => LoanCalculatorBloc(Repository())..add(LoanInitEvent()))
      ],
      child:BlocConsumer<LoanCalculatorBloc,LoanCalculatorState>(
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
            else if(state is GetLoanInterestTypeSuccessState){
              kvInterestTypeList = LoanInterestRatesModel.kVInteretTypeList(state.responseModel);
            }
            else if(state is GetLoanInterestRateSuccessState){
              interestRateList = state.responseModel;
              // if(interestRateList.isNotEmpty){
              //   minInterestRate= double.parse(interestRateList[0].pMinInterest.toString());
              //   maxInterestRate= double.parse(interestRateList[0].pRateofinterest.toString());
              //   _currentRangeValues = minInterestRate;
              // }

            }
            else if(state is GetInstalmentModeSuccessState){
              kvInstalmentModeList = LoanInstalmentModel.kVInstalmentModeList(state.responseModel);
            }
            else if(state is GetFinalLoanViewSuccessState){
              loanViewModelList=state.responseModel.lstInstalmentsgenerationDTO!;
              if(loanViewModelList.isNotEmpty || loanViewModelList != []){
                _showCalculateView(context);
              }
            }
          },)
    );
  }
 bool validate(){
    if(_selectedLoanType.name == "Select"){
      showSnackBar(context, 'Enter Loan Type');
      return false;
    }
    else if(_selectedNameType.name == "Select"){
      showSnackBar(context, 'Enter Loan Name');
      return false;
    }
    else if(_selectedPayIn.name == "Select"){
      showSnackBar(context, 'Enter Loan Pay-In');
      return false;
    }
    else if(tenureTxtController.text == ""){
      showSnackBar(context, 'Enter Tenure');
      return false;
    }
    else if(_selectedInterestType.name == "Select"){
      showSnackBar(context, 'Enter Interest Type');
      return false;
    }
    else if(_selectedInstalmentMode.name == "Select"){
      showSnackBar(context, 'Enter Loan Installment Mode');
      return false;
    }
    else if(_currentRangeValues <= 0.0){
      showSnackBar(context, 'Choose Interest Rate');
      return false;
    }
    else{
      return true;
    }
}

  clearDataFunction(){
    _selectedNameType = KeyValueModel(id: "0", name: "Select");
    _selectedPayIn = KeyValueModel(id: "0", name: "Select");
    amountController.text ="";
    tenureTxtController.text="";
    _selectedInterestType = KeyValueModel(id: "0", name: "Select");
    _selectedInstalmentMode = KeyValueModel(id: "0", name: "Select");
    minInterestRate =0.0;
    maxInterestRate=0.0;
    _currentRangeValues=0;
  }

  void _showCalculateView(BuildContext context) {
    double sumPrincipal = 0.0;
    double sumInterest = 0.0;
    double sumAmount = 0.0;
    for (var item in loanViewModelList) {
      sumPrincipal += item.pInstalmentprinciple ?? 0.0;
      sumInterest += item.pInstalmentinterest ?? 0.0;
      sumAmount+= item.pInstalmentamount ?? 0.0;
    }
    log("=====sumPrincipal $sumPrincipal $sumAmount $sumInterest");
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  // scrollDirection: Axis.horizontal,
                  child:  DataTable(
                    border: TableBorder.all(width: 0.5, color: Colors.grey),
                    dataTextStyle: AppStyles.smallLabelTextBold,
                    headingTextStyle: AppStyles.customTextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                    horizontalMargin: 15,
                    showBottomBorder: true,
                    headingRowColor:
                    MaterialStateProperty.resolveWith<Color>(
                          (states) => AppStyles.btnColor,
                    ),
                    columns: const [
                      DataColumn(
                        label: Expanded(child: Center(child: Text("SL No. "))),
                      ),
                      DataColumn(label: Expanded(child: Center(child: Text("Principal")))),
                      DataColumn(label:Expanded(child: Center(child: Text("Interest")))),
                      DataColumn(label: Expanded(
                          child: Center(child: Text("Amount")))),
                    ],
                    rows: loanViewRows(loanViewModelList),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              Column(
                children: [
                  Container(
                    color: Colors.grey[200],
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 8),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Center(
                              child: Text(
                                "Total",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                              child: Text(
                                sumPrincipal.toStringAsFixed(0),
                                style: AppStyles.smallLabelTextBlack,
                              )),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                              child: Text(
                                sumInterest.toStringAsFixed(0),
                                style: AppStyles.smallLabelTextBlack,
                              )),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                              child: Text(
                                sumAmount.toStringAsFixed(0),
                                style: AppStyles.smallLabelTextBlack,
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  loanViewRows(List<LstInstalmentsgenerationDTO> listData){
    return listData.asMap().map((i, data) => MapEntry(i,
        DataRow(cells:[
          DataCell(SizedBox(
            width: double.infinity,
            child: Center(
                child: Text(
                    data.pInstalmentno.toString(),
                    style: AppStyles.smallLabelTextBlack)),
          )),
          DataCell(SizedBox(
            width: double.infinity,
            child: Center(
                child: Text( data.pInstalmentprinciple.toString(),
                    style: AppStyles.smallLabelTextBlack)),
          )),
          DataCell(
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(data.pInstalmentinterest.toString(),
                      style: AppStyles.smallLabelTextBlack),
                ),
              )),
          DataCell(
              SizedBox(
                width: double.infinity,
                child: Text(data.pInstalmentamount.toString(),
                    style: AppStyles.smallLabelTextBlack),
              )),
        ]
        )
    )).values.toList();
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
                                        });
                                        clearDataFunction();
                                        Navigator.pop(context);
                                        context.read<LoanCalculatorBloc>().add(GetLoanNameEvent(_selectedLoanType.id));
                                        context.read<LoanCalculatorBloc>().add(GetLoanInstalmentModeEvent(_selectedLoanType.id));
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
                                        schemeId = "0"; //because initially we r not getting schemeid
                                        context.read<LoanCalculatorBloc>().add(GetLoanPayInEvent(_selectedNameType.id,schemeId));
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
                                        schemeId=  _selectedPayIn.id;
                                        });
                                        Navigator.pop(context);
                                        context.read<LoanCalculatorBloc>().add(GetLoanInterestTypeEvent(_selectedNameType.id, schemeId,_selectedPayIn.name));
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
                                  child: CustomTextFieldAmount(
                                      boxHeight: 45,
                                      context: context, controller: amountController,
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
                                  child: CustomTextField(
                                      boxHeight: 45,
                                      context: context, controller: tenureTxtController,
                                      onChanged: (value) {
                                      }, hint: "Enter Tenure", textInputType: TextInputType.number),
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
                                        DateTime dateTime=DateTime.now();
                                        setState(() {
                                          _selectedInterestType = value;
                                        });
                                        Navigator.pop(context);
                                        context.read<LoanCalculatorBloc>().add(GetLoanInterestRateEvent(_selectedNameType.id, schemeId,_selectedPayIn.name,_selectedInterestType.name,amountController.text,dateTime.toString(), tenureTxtController.text));
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
                                  child: CustomDropdown(context: context, selectedValue: _selectedInstalmentMode,
                                      items:kvInstalmentModeList, onChanged: (value) {
                                        setState(() {
                                          _selectedInstalmentMode = value;
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
                                  child: Column(
                                    children: [
                                      Slider(
                                        value: _currentRangeValues,
                                        divisions: 100,
                                        activeColor: AppStyles.btnColor,
                                        inactiveColor: AppStyles.bgColor3,
                                        min: minInterestRate,
                                        max: maxInterestRate,
                                        label: '${_currentRangeValues.toStringAsFixed(2)}%',
                                        onChanged: (value) {
                                          setState(() {
                                            _currentRangeValues = value;
                                          });
                                        },),
                                      Text("(${_currentRangeValues.toStringAsFixed(2)} %)" ,style: AppStyles.smallLabelTextBold),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    payButton(() {
                      if(validate()){
                        context.read<LoanCalculatorBloc>().add(GetLoanFinalLoanViewEvent(
                            loanamount: amountController.text,
                            interesttype: _selectedInterestType.name,
                            loanpayin: _selectedPayIn.name,
                            interestrate: _currentRangeValues.toString(),
                            tenureofloan: tenureTxtController.text,
                            loaninstalmentmode: _selectedInstalmentMode.name,
                            loanId: _selectedNameType.id
                        ));
                      }
                    },"Calculate"),
                  ],
                )
            );
  }
}

