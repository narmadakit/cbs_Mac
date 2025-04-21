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
import '../utils/GlobalFunctions.dart';

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
  var _selectedLoanName = KeyValueModel(id: "0", name: "Select");
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
  double minAmount =0.0;
  double maxAmount=0.0;
  // Define the current values for the range
  double _currentRangeValues = 0;
  var enterAmount;
  String schemeId="";
  List<LoanInterestRatesModel> interestRateList =[];
  List<LstInstalmentsgenerationDTO> loanViewModelList=[];
  double tenureFrom=0;
  double tenureTo=0;

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
            else if(state is GetMinMaxLoanAmountSuccessState){
              minAmount = state.responseModel[0].pMinloanamount;
              maxAmount = state.responseModel[0].pMaxloanamount;
            }
            else if(state is GetLoanInterestRateSuccessState){
              interestRateList = state.responseModel;
              if(interestRateList.isNotEmpty){
                minInterestRate= double.parse(interestRateList[0].pMinInterest.toString());
                maxInterestRate= double.parse(interestRateList[0].pRateofinterest.toString());
                _currentRangeValues = minInterestRate;

                tenureFrom = interestRateList[0].pTenorfrom;
                tenureTo = interestRateList[0].pTenorto;
              }
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
    else if(_selectedLoanName.name == "Select"){
      showSnackBar(context, 'Enter Loan Name');
      return false;
    }
    else if(_selectedPayIn.name == "Select"){
      showSnackBar(context, 'Enter Loan Pay-In');
      return false;
    }
    else if(_selectedInterestType.name == "Select"){
      showSnackBar(context, 'Enter Interest Type');
      return false;
    }
    else if(amountController.text == ""){
      showSnackBar(context, 'Enter Loan Amount');
      return false;
    }
    else if((double.parse(enterAmount) < minAmount) || (double.parse(enterAmount) > maxAmount)) {
      showSnackBar(context, 'Enter Valid Amount');
      return false;
    }
    else if(tenureTxtController.text == ""){
      showSnackBar(context, 'Enter Tenure');
      return false;
    }
    else if((double.parse(tenureTxtController.text) < tenureFrom) || (double.parse(tenureTxtController.text) > tenureTo)) {
      showSnackBar(context, 'Enter Valid Tenure');
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
    _selectedLoanName = KeyValueModel(id: "0", name: "Select");
    _selectedPayIn = KeyValueModel(id: "0", name: "Select");
    amountController.text ="";
    tenureTxtController.text="";
    _selectedInterestType = KeyValueModel(id: "0", name: "Select");
    _selectedInstalmentMode = KeyValueModel(id: "0", name: "Select");
    minAmount =0;
    maxAmount =0;
    tenureFrom =0;
    tenureTo =0;
    _currentRangeValues=0;
    minInterestRate=0;
    maxInterestRate=0;
  }

  void _showCalculateView(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width ;
    double sumPrincipal = 0.0;
    double sumInterest = 0.0;
    double sumAmount = 0.0;
    for (var item in loanViewModelList) {
      sumPrincipal += item.pInstalmentprinciple ?? 0.0;
      sumInterest += item.pInstalmentinterest ?? 0.0;
      sumAmount+= item.pInstalmentamount ?? 0.0;
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child:  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      border: TableBorder.all(width: 0.5, color: Colors.grey),
                      dataTextStyle: AppStyles.smallLabelTextBold,
                      headingTextStyle: AppStyles.customTextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      horizontalMargin: 15,
                      showBottomBorder: true,
                      headingRowColor:
                      MaterialStateProperty.resolveWith<Color>(
                            (states) => AppStyles.btnColor,
                      ),
                      columns: [
                         DataColumn(label: SizedBox(
                           width: width * 0.08,
                             child: const Center(child: Text("SL No ")))),
                         const DataColumn(label: Expanded(child: Center(child: Text("Principal")))),
                         const DataColumn(label:Expanded(child: Center(child: Text("Interest")))),
                         const DataColumn(label: Expanded(child: Center(child: Text("Amount")))),
                      ],
                      rows: loanViewRows(loanViewModelList),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              Column(
                children: [
                  Container(
                    color: Colors.grey[200],
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "Total",
                                style: AppStyles.customTextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              getRuppeText(fontSize: 14,color: AppStyles.btnColor),
                              Text(
                               (sumPrincipal == 0.00)?sumPrincipal.toStringAsFixed(0):sumPrincipal.toStringAsFixed(2),
                                style: AppStyles.highLightText,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              getRuppeText(fontSize: 14,color: AppStyles.btnColor),
                              Text(
                                (sumInterest == 0.00)?sumInterest.toStringAsFixed(0):sumInterest.toStringAsFixed(2),
                                style: AppStyles.highLightText,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              getRuppeText(fontSize: 14,color: AppStyles.btnColor),
                              Text(
                                (sumAmount == 0.00)?sumAmount.toStringAsFixed(0):sumAmount.toStringAsFixed(2),
                                style: AppStyles.highLightText,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('CLOSE',style: AppStyles.smallLabelTextBold,),
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
          DataCell(Center(
            child: Text(
                data.pInstalmentno.toString(),
                style: AppStyles.smallLabelTextBlack),
          )),
          DataCell(Center(
            child: Text( data.pInstalmentprinciple.toString(),
                style: AppStyles.smallLabelTextBlack),
          )),
          DataCell(
              Center(
                child: Text(data.pInstalmentinterest.toString(),
                    style: AppStyles.smallLabelTextBlack),
              )),
          DataCell(
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getRuppeText(fontSize: 14),
                  Text(data.pInstalmentamount.toString(),
                      style: AppStyles.smallLabelTextBlack),
                ],
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
                                        _selectedLoanType = value;
                                        _currentRangeValues = minInterestRate;
                                        clearDataFunction();
                                        Navigator.pop(context);
                                        context.read<LoanCalculatorBloc>().add(GetLoanNameEvent(_selectedLoanType.id));

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
                                  child: CustomDropdown(context: context, selectedValue: _selectedLoanName,
                                      items:kvLoanNameList, onChanged: (value) {
                                        _selectedLoanName = value;
                                        _selectedPayIn = KeyValueModel(id: "0", name: "Select");
                                        Navigator.pop(context);
                                        schemeId = "0"; //because initially we r not getting schemeid
                                        context.read<LoanCalculatorBloc>().add(GetLoanPayInEvent(_selectedLoanName.id,schemeId));
                                        context.read<LoanCalculatorBloc>().add(GetLoanInstalmentModeEvent(_selectedLoanName.id));
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
                                        context.read<LoanCalculatorBloc>().add(GetLoanInterestTypeEvent(_selectedLoanName.id, schemeId,_selectedPayIn.name));
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
                                        _selectedInterestType = value;
                                        Navigator.pop(context);
                                        context.read<LoanCalculatorBloc>().add(GetMinMaxLoanEvent(_selectedLoanName.id,schemeId,_selectedPayIn.name,_selectedInterestType.name));
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
                                  child: FocusScope(
                                    onFocusChange: (value) {
                                      if (!value) {
                                        DateTime dateTime=DateTime.now();
                                        context.read<LoanCalculatorBloc>().add(GetLoanInterestRateEvent(_selectedLoanName.id, schemeId,_selectedPayIn.name,_selectedInterestType.name,enterAmount,dateTime.toString()));
                                      }
                                    },
                                    child: CustomTextFieldAmount(
                                        boxHeight: 45,
                                        context: context, controller: amountController,
                                        onChanged: (value) {
                                          enterAmount =  removeCommasFromNumber(value).toString();
                                        },
                                        hint: "Enter Loan Amount", textInputType: TextInputType.number),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text('',style: AppStyles.boldTextBlack)),
                                const SizedBox(width: 10,),
                                Expanded(
                                  flex: 4,
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(' Min: ${convertToCurrencyFormat(minAmount)??"0"}',style: AppStyles.smallLabelTextBlack),
                                      Text('Max: ${convertToCurrencyFormat(maxAmount)??"0"}  ',style: AppStyles.smallLabelTextBlack)
                                    ],
                                  ),
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
                                        // context.read<LoanCalculatorBloc>().add(GetLoanInterestRateEvent(_selectedLoanName.id, schemeId,_selectedPayIn.name,_selectedInterestType.name,enterAmount,dateTime.toString(), tenureTxtController.text));
                                      }, hint: "Enter Tenure", textInputType: TextInputType.number),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text('',style: AppStyles.boldTextBlack)),
                                const SizedBox(width: 10,),
                                Expanded(
                                  flex: 4,
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(' From: ${tenureFrom.toStringAsFixed(0)}',style: AppStyles.smallLabelTextBlack),
                                      Text('To: ${tenureTo.toStringAsFixed(0)}',style: AppStyles.smallLabelTextBlack)
                                    ],
                                  ),
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
                                        _selectedInstalmentMode = value;
                                       setState(() {});
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
                                        value:  double.parse(_currentRangeValues.toStringAsFixed(2)),
                                        divisions: 100,
                                        activeColor: AppStyles.btnColor,
                                        inactiveColor: AppStyles.bgColor3,
                                        min: double.parse(minInterestRate.toStringAsFixed(2)),
                                        max: double.parse(maxInterestRate.toStringAsFixed(2)),
                                        label: '${_currentRangeValues.toStringAsFixed(2)}%',
                                        onChanged: (value) {
                                            _currentRangeValues = value;
                                            setState(() {});
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
                            loanamount: enterAmount,
                            interesttype: _selectedInterestType.name,
                            loanpayin: _selectedPayIn.name,
                            interestrate: _currentRangeValues.toString(),
                            tenureofloan: tenureTxtController.text,
                            loaninstalmentmode: _selectedInstalmentMode.name,
                            loanId: _selectedLoanName.id
                        ));
                      }
                    },"Calculate"),
                  ],
                )
            );
  }
}

