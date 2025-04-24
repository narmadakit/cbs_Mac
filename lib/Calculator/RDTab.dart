import 'dart:developer';

import 'package:finsta_mac/Calculator/bloc/RD/RDBloc.dart';
import 'package:finsta_mac/Calculator/bloc/RD/RDEvent.dart';
import 'package:finsta_mac/Calculator/bloc/RD/RDState.dart';
import 'package:finsta_mac/Calculator/model/DepositTenureModel.dart';
import 'package:finsta_mac/Calculator/model/RDDescriptionModel.dart';
import 'package:finsta_mac/Calculator/model/RDInterestDetailsModel.dart';
import 'package:finsta_mac/Calculator/model/SchemaDetailsModel.dart';
import 'package:finsta_mac/components/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/AppWidgets.dart';
import '../components/CustomDropdown.dart';
import '../components/KeyValueModel.dart';
import '../network/Repository.dart';
import '../utils/AppStyles.dart';
import '../utils/CustomTextFieldAmount.dart';
import '../utils/GlobalFunctions.dart';
import 'model/FDMaturityModel.dart';

class RDTabWidget extends StatefulWidget {
  const RDTabWidget({
    super.key,
  });

  @override
  State<RDTabWidget> createState() => _RDTabWidgetState();
}

class _RDTabWidgetState extends State<RDTabWidget> {
  var _selectedRDNameValue = KeyValueModel(id: "0", name: "Select");
  var _selectedTenureValue = KeyValueModel(id: "0", name: "Select");
  var _selectedInterestTypeValue = KeyValueModel(id: "0", name: "Select");
  var _selectedPayInValue = KeyValueModel(id: "0", name: "Select");
  var _selectedPayOutValue = KeyValueModel(id: "0", name: "Select");
  List<KeyValueModel> rdKVList =[];
  List<SchemaDetailsModel> schemaList =[];
  List<RdInterestPayoutList> interestPayOutList =[];
  List<KeyValueModel> tenureKVList =[];
  List<KeyValueModel> payInKVList =[];
  List<KeyValueModel> interestTypeKVList =[];
  List<KeyValueModel> interestPayOutKVList =[];
  List<RDDescriptionModel> descriptionList =[];
  double tenureFrom=0;
  double tenureTo=0;
  bool isTenureLoader=false;
  var tenureTxtController = TextEditingController();
  var amountController = TextEditingController();
  var interestRateController = TextEditingController();
  double minInterestRate =0.0;
  double maxInterestRate=0.0;
  // Define the current values for the range
  double _currentRangeValues = 0;
  bool isInterestRate=false;
  bool isDescriptionVisible=false;
  RDInterestDetailsModel interestDetailsModel=RDInterestDetailsModel();
  List<DepositMaturityModel> maturityList =[];
  bool isAmountVisible=false;
  var enterAmount;
  double minAmount =0.0;
  double maxAmount=0.0;
  FocusScopeNode _fdAmountFocusNode = FocusScopeNode();

  @override
  void dispose() {
    _fdAmountFocusNode.dispose();  // Don't forget to dispose of the FocusNode
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RDBloc>(create: (context) => RDBloc(Repository())..add(RDInitEvent('RECURRING DEPOSIT')))
      ],
      child: BlocConsumer<RDBloc,RDStates>(
        builder: (context, state) {
          if(state is RDLoadingState){
            return Center(child: CircularProgressIndicator(color: AppStyles.btnColor));
          }
          if(state is GetTransactionSuccessState){
            schemaList = state.responseModel;
            rdKVList =SchemaDetailsModel.keyValueList(state.responseModel);
            return buildBody(context,state.responseModel);
          }
          else{
            return buildBody(context,schemaList);
          }
        },
        listener: (context, state) {
          if(state is GetTransactionSuccessState){
            rdKVList =SchemaDetailsModel.keyValueList(state.responseModel);
            clearDataFunction();
          }
          else if(state is RDTenureLoadingState){
            isTenureLoader = true;
            isInterestRate=false;
          }
          else if(state is RDSchemeDescrSuccessState){
            isTenureLoader = false;
            descriptionList = state.responseModel;
            if(descriptionList.isNotEmpty){
              minAmount = double.parse(descriptionList[0].pMinInstallmentAmount.toString());
              maxAmount = double.parse(descriptionList[0].pMaxInstallmentAmount.toString());
              // tenureFrom = double.parse(descriptionList[0].pInvestmentPeriodFrom.toString());
              // tenureTo = double.parse(descriptionList[0].pInvestmentPeriodTo.toString());
            }
          }
          else if(state is RDGetTenureSuccessState){
            isTenureLoader = false;
            // _selectedTenureValue ="Select";
            tenureKVList =DepositeTenureModel.rdTenurekeyValueList(state.responseModel);
            payInKVList =DepositeTenureModel.rdPayInKeyValueList(state.responseModel);
          }
          else if(state is RDInterestDetailsSuccessState){
            isTenureLoader = false;
            interestDetailsModel = state.responseModel;
            if(state.responseModel.rdInteresttype != null){
              interestTypeKVList = RdInteresttype.keyValueList(state.responseModel.rdInteresttype!);
              interestPayOutList = state.responseModel.rdInteresttype![0].rdInterestPayoutList!;
              interestPayOutKVList  =  RdInterestPayoutList.keyValueList(interestPayOutList);
              }
            else{
                if ((enterAmount < minAmount) || (enterAmount > maxAmount)) {
                  showSnackBar(context, 'Enter valid amount\nTo know more see the Description');
                }
              else{
                showSnackBar(context, 'Enter Valid Tenure');
                tenureTxtController.text="";
              }

              // _selectedTenureValue = KeyValueModel(id: "0", name: "Select");
            }
          }
          else if(state is RDInterestRateSuccessState){
            isTenureLoader = false;
            if(state.responseModel.pMinInterestRate != null && state.responseModel.pMaxInterestRate != null){
              minInterestRate= double.parse(state.responseModel.pMinInterestRate.toString());
              maxInterestRate= double.parse(state.responseModel.pMaxInterestRate.toString());
            }
            _currentRangeValues = minInterestRate;
            isInterestRate=true;
          }
          else if(state is RDMaturitySuccessState){
            isTenureLoader = false;
            maturityList = state.responseModel;
          }
          else{
            isTenureLoader = false;
          }
        },
      ),
    );
  }

  clearDataFunction(){
    maturityList =[];
    _selectedTenureValue = KeyValueModel(id: "0", name: "Select");
    amountController.text ="";
    tenureTxtController.text="";
    _selectedPayInValue = KeyValueModel(id: "0", name: "Select");
    _selectedInterestTypeValue = KeyValueModel(id: "0", name: "Select");
    _selectedPayOutValue = KeyValueModel(id: "0", name: "Select");
    interestRateController.text = "0";
     minInterestRate =0.0;
     maxInterestRate=0.0;
     _currentRangeValues=0;
  }

  bool validate(){
    if(_selectedRDNameValue.name == "Select"){
      showSnackBar(context, 'Enter RD Name');
      return false;
    }
    else if(amountController.text == ""){
      showSnackBar(context, 'Enter RD Installment Amount');
      return false;
    }
    else if((enterAmount < minAmount) || (enterAmount > maxAmount)) {
      showSnackBar(context, 'Enter Valid Amount To Know More See The Description');
      return false;
    }
    // else if((double.parse(tenureTxtController.text) < tenureFrom) || (double.parse(tenureTxtController.text) > tenureTo)) {
    //   showSnackBar(context, 'Enter Valid Tenure');
    //   return false;
    // }
    else if(tenureTxtController.text == ""){
      showSnackBar(context, 'Enter Tenure');
      return false;
    }
    else if(_selectedTenureValue.name == "Select"){
      showSnackBar(context, 'Enter Tenure Mode');
      return false;
    }
    else if(_selectedPayInValue.name == "Select"){
      showSnackBar(context, 'Enter Installment Pay-In');
      return false;
    }
    else if(_selectedInterestTypeValue.name == "Select"){
      showSnackBar(context, 'Enter Interest Type');
      return false;
    }
    else if(_selectedPayOutValue.name == "Select"){
      showSnackBar(context, 'Enter Interest Payout');
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


  Column buildBody(BuildContext context, List<SchemaDetailsModel> responseModel) {
    double gapHeight=20.0;
    return Column(
      children: [
        Column(
          children: [
            Visibility(
              visible: isDescriptionVisible,
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: GestureDetector(
                  onTap: () {
                    if(descriptionList.isNotEmpty){
                      _showBottomSheet(context);
                    }
                  },
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: AppStyles.borderRadiusCircularColor,
                            color: AppStyles.btnColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Description',style: AppStyles.customTextStyle(color: Colors.white,fontSize: 12),),
                          ))),
                ),
              ),
            ),
            SizedBox(height: gapHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    flex: 2,
                    child: Text('RD Name',style: AppStyles.boldTextBlack)),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 4,
                  child: CustomDropdown(context: context,
                    selectedValue: _selectedRDNameValue,
                    onChanged: (value) {
                      _selectedRDNameValue = value;
                        isAmountVisible=true;
                        clearDataFunction();
                      setState(() {
                      });
                      Navigator.pop(context);
                      context.read<RDBloc>().add(RDGetTenureEvent(_selectedRDNameValue.name));
                      context.read<RDBloc>().add(GetRdDescriptionEvent(_selectedRDNameValue.name));
                      amountController.text="";
                      tenureTxtController.text="";
                      isDescriptionVisible =true;
                    },
                    hint: "",items:rdKVList,icon: Icons.arrow_downward,labelText: '', ),
                )
              ],
            ),
            Visibility(
              visible:isAmountVisible,
              child: Column(
                children: [
                  SizedBox(height: gapHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text('RD Installment Amount',style: AppStyles.boldTextBlack)),
                      const SizedBox(width: 10,),
                      Expanded(
                        flex: 4,
                        child:FocusScope(
                          node: _fdAmountFocusNode,
                          onFocusChange: (value) {
                            if (!value) {
                              if((enterAmount < minAmount) ||(enterAmount > maxAmount)){
                                showSnackBar(context, 'Enter valid amount\nTo know more see the Description');
                              }
                              else{
                                if(tenureTxtController.text != "" && amountController.text != ""){
                                  context.read<RDBloc>().add(GetRDInterestDetailsEvent(_selectedRDNameValue.id,_selectedRDNameValue.name, tenureTxtController.text,_selectedTenureValue.id,enterAmount.toString()));
                                }
                              }
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          child: CustomTextFieldAmount(
                              boxHeight: 45,
                              context: context,
                              controller: amountController,
                              onChanged: (value) {
                                enterAmount =  double.parse(removeCommasFromNumber(value).toString());
                                log("=====enterAmount $enterAmount");
                                _selectedInterestTypeValue = KeyValueModel(id: "0", name: "Select");
                                _selectedPayOutValue = KeyValueModel(id: "0", name: "Select");
                                _selectedPayOutValue = KeyValueModel(id: "0", name: "Select");
                                setState(() {});
                              }, hint: "Enter RD Installment Amount", textInputType: TextInputType.number),
                        ),
                      )
                    ],
                  ),
                  // const SizedBox(height: 5),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     Expanded(
                  //         flex: 2,
                  //         child: Text('',style: AppStyles.boldTextBlack)),
                  //     const SizedBox(width: 10,),
                  //     Expanded(
                  //       flex: 4,
                  //       child:Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text('Min: ${convertToCurrencyFormat2(double.tryParse(minAmount)??"0")}',style: AppStyles.smallLabelTextBlack),
                  //           Text('Max: ${convertToCurrencyFormat2(double.tryParse(maxAmount)??"0")}',style: AppStyles.smallLabelTextBlack)
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),

            SizedBox(height: gapHeight),
            (isTenureLoader == true)?
            CircularProgressIndicator(color: AppStyles.btnColor):
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    flex: 2,
                    child: Text('Tenure',style: AppStyles.boldTextBlack)),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomTextField(
                            boxHeight: 45,
                            context: context, controller: tenureTxtController,
                            onTap: () {
                              setState(() {
                                _selectedTenureValue = KeyValueModel(id: "0", name: "Select");
                              });
                            },
                            onChanged: (value){ },
                             hint: "Enter Tenure", textInputType: TextInputType.number),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        flex: 2,
                        child: CustomDropdown(context: context,selectedValue: _selectedTenureValue,
                          onChanged: (value) {
                            _selectedTenureValue = value;
                              if(tenureTxtController.text != "" && amountController.text != ""){
                                context.read<RDBloc>().add(GetRDInterestDetailsEvent(_selectedRDNameValue.id,_selectedRDNameValue.name,tenureTxtController.text,_selectedTenureValue.id,enterAmount.toString()));
                              }
                            else{
                                context.read<RDBloc>().add(GetRDInterestDetailsEvent(_selectedRDNameValue.id,_selectedRDNameValue.name,tenureTxtController.text,_selectedTenureValue.id,minAmount.toString()));
                            }
                            setState(() {});
                            Navigator.pop(context);
                          },
                          hint: "",items:tenureKVList,icon: Icons.arrow_downward,labelText: '', ),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),

            // (tenureFrom=="")?Container():
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Expanded(
            //         flex: 2,
            //         child: Text('',style: AppStyles.boldTextBlack)),
            //     const SizedBox(width: 10,),
            //     Expanded(
            //       flex: 2,
            //       child:Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           Text('$tenureFrom - ',style: AppStyles.smallLabelTextBlack),
            //           Text(tenureTo,style: AppStyles.smallLabelTextBlack)
            //         ],
            //       ),
            //     ),
            //     Expanded(flex: 2, child: Container())
            //   ],
            // ),
            SizedBox(height: gapHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    flex: 2,
                    child: Text('Installment\nPay-In',style: AppStyles.boldTextBlack)),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 4,
                  child: CustomDropdown(context: context,selectedValue: _selectedPayInValue,
                    onChanged: (value) {
                      _selectedPayInValue = value;
                      if(tenureTxtController.text != "" && amountController.text != ""){
                        context.read<RDBloc>().add(GetRDInterestDetailsEvent(_selectedRDNameValue.id,_selectedRDNameValue.name, tenureTxtController.text,_selectedPayInValue.name,amountController.text));
                      }
                      setState(() {
                      });
                      Navigator.pop(context);
                    },
                    hint: "",items:payInKVList,icon: Icons.arrow_downward,labelText: '', ),
                )
              ],
            ),
            SizedBox(height: gapHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    flex: 2,
                    child: Text('Interest Type',style: AppStyles.boldTextBlack)),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 4,
                  child: CustomDropdown(context: context,selectedValue: _selectedInterestTypeValue,
                    onChanged: (value) {
                      _selectedInterestTypeValue = value;
                      setState(() {
                      });
                      Navigator.pop(context);
                    },
                    hint: "",items:interestTypeKVList,icon: Icons.arrow_downward,labelText: '', ),
                )
              ],
            ),
            SizedBox(height: gapHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    flex: 2,
                    child: Text('Interest Payout',style: AppStyles.boldTextBlack)),
                const SizedBox(width: 10),
                Expanded(
                  flex: 4,
                  child: CustomDropdown(context: context,selectedValue: _selectedPayOutValue,
                    onChanged: (value) {
                      _selectedPayOutValue = value;
                        if(tenureTxtController.text != "" && amountController.text != ""){
                          context.read<RDBloc>().add(GetRDInterestRateEvent(_selectedRDNameValue.name, enterAmount.toString(), tenureTxtController.text, _selectedTenureValue.id, _selectedPayOutValue.name));
                        }
                      else{
                        context.read<RDBloc>().add(GetRDInterestRateEvent(_selectedRDNameValue.name, minAmount.toString(),tenureTxtController.text, _selectedTenureValue.id, _selectedPayOutValue.name));
                      }

                      setState(() {
                      });
                      Navigator.pop(context);
                    },
                    hint: "",items:interestPayOutKVList,icon: Icons.arrow_downward,labelText: '', ),
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
                        label: '${_currentRangeValues.toStringAsFixed(1)}%',
                        onChanged: (value) {
                          setState(() {
                            _currentRangeValues = value;
                            interestRateController.text = _currentRangeValues.toString();
                          });
                        },),
                      Text("(${_currentRangeValues.toStringAsFixed(2)} %)" ,style: AppStyles.smallLabelTextBold),
                    ],
                  ),

                ),
              ],
            ),

            SizedBox(height: gapHeight),
            (maturityList.isNotEmpty)?
            ListView.builder(
              shrinkWrap: true,
              itemCount: maturityList.length,
              itemBuilder:(context, i) {
                return Container(
                  decoration: BoxDecoration(
                      color: AppStyles.bgColor2,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Interest Amount',style: AppStyles.boldTextBlack,),
                            const SizedBox(height: 8,),
                            Row(
                              children: [
                                getRuppeText(fontSize: 15,color: AppStyles.btnColor),
                                Text(maturityList[i].pInterestamount.toString(),style: AppStyles.highLightText),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Maturity Amount',style: AppStyles.boldTextBlack),
                            const SizedBox(height: 8,),
                            Row(
                              children: [
                                getRuppeText(fontSize: 15,color: AppStyles.btnColor),
                                Text(maturityList[i].pMatueritytAmount.toString(),style: AppStyles.highLightText),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ):Container(),
            SizedBox(height: gapHeight),
          ],
        ),
        
        Visibility(
          visible: isAmountVisible,
          child: payButton(() {
            if(validate()){
              context.read<RDBloc>().add(GetRDMaturityEvent(_selectedPayInValue.name,tenureTxtController.text, enterAmount.toString(),
                  _selectedPayOutValue.name,_selectedInterestTypeValue.name,
                  _currentRangeValues.toString(),interestDetailsModel.pCaltype.toString(),interestDetailsModel.pCompoundInterestType.toString()
              ));
            }
          },"Calculate"),
        )
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          // height: 350,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 10,),
                Text(_selectedRDNameValue.name,style: AppStyles.highLightText,),
                const SizedBox(height: 10,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
                    child: DataTable(
                        border: TableBorder.all(
                          width: 0.5,
                          color:Colors.grey,
                        ),
                        dataTextStyle: AppStyles.smallLabelTextBold,
                        headingTextStyle: AppStyles.customTextStyle(color: Colors.white,fontSize: 11),
                        headingRowHeight: 55,
                        horizontalMargin: 5,
                        showBottomBorder: true,
                        dataRowMaxHeight: 55,
                        columnSpacing: 12,
                        headingRowColor: MaterialStateProperty.resolveWith<Color>((states) {
                          return AppStyles.btnColor; // Color when the slider is active
                        }),
                        columns: const [
                          DataColumn(
                            label: SizedBox(
                              width: 40,
                              child: Center(
                                child: Text(
                                  "SL No",
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Center(
                                child: Text(
                                  "Installment Amount",
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Center(
                                child: Text(
                                  "Tenure"
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Center(
                                child: Text(
                                  "Interest Rate\nValue Per 100"
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Center(
                                child: Text(
                                  "Interest Type"
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Center(
                                child: Text(
                                  "Compound Type"
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Center(
                                child: Text(
                                  "Interest PayOut"
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Center(
                                child: Text(
                                  "Applicant Type"
                                ),
                              ),
                            ),
                          ),
                        ],
                        rows: addressRows(descriptionList)
                    ),
                  ),
                ),
              ],
            )
        );
      },
    );
  }
}

addressRows(List<RDDescriptionModel> descList){
  return descList.asMap().map((i, data) => MapEntry(i,
      DataRow(cells:[
        DataCell(SizedBox(
          child: Center(
              child: Text(
                  "${i+1}",
                  style: AppStyles.smallLabelTextBlack)),
        )),
        DataCell(SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getRuppeText(fontSize: 14),
              Text(
              "${data.pMinInstallmentAmount.toString()} - ${data.pMaxInstallmentAmount.toString()}",
                  style: AppStyles.smallLabelTextBlack),
            ],
          ),
        )),
        DataCell(SizedBox(
          child: Center(
              child: Text( "${data.pInvestmentPeriodFrom} - ${data.pInvestmentPeriodTo}",
                  style: AppStyles.smallLabelTextBlack)),
        )),
        DataCell(
            SizedBox(
              child: Center(
                child: Text("${data.pInterestRateFrom} - ${data.pInterestRateTo}",
                    style: AppStyles.smallLabelTextBlack),
              ),
            )),
        DataCell(
            SizedBox(
              child: Text(data.pInterestType.toString(),
                  style: AppStyles.smallLabelTextBlack),
            )),
        DataCell(SizedBox(
          child: Center(
              child: Text(
                  data.pCompoundType??"N/A",
                  style: AppStyles.smallLabelTextBlack)),
        )),
        DataCell(SizedBox(
          child: Center(
              child: Text(
                  data.pInterestPayOut??"N/A",
                  style: AppStyles.smallLabelTextBlack)),
        )),
        DataCell(SizedBox(
          child: Center(
              child: Text(
                  data.papplicanttype.toString(),
                  style: AppStyles.smallLabelTextBlack)),
        )),
      ]
      )
  )).values.toList();
}
