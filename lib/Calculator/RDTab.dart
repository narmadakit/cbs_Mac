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
  bool isTenureLoader=false;
  var tenureTxtController = TextEditingController();
  var rdAmountController = TextEditingController();
  var interestRateController = TextEditingController();
  double minInterestRate =0.0;
  double maxInterestRate=20.0;
  // Define the current values for the range
  double _currentRangeValues = 15;
  bool isInterestRate=false;
  bool isDescriptionVisible=false;
  RDInterestDetailsModel interestDetailsModel=RDInterestDetailsModel();
  List<DepositMaturityModel> maturityList =[];
  bool isAmountVisible=false;

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
          }
          else if(state is RDTenureLoadingState){
            isTenureLoader = true;
            isInterestRate=false;
          }
          else if(state is RDGetTenureSuccessState){
            isTenureLoader = false;
            // _selectedTenureValue ="Select";
            tenureKVList =DepositeTenureModel.rdTenurekeyValueList(state.responseModel);
            payInKVList =DepositeTenureModel.rdPayInKeyValueList(state.responseModel);
          }
          else if(state is RDInterestDetailsSuccessState){
            isTenureLoader = false;
            interestTypeKVList = RdInteresttype.keyValueList(state.responseModel.rdInteresttype!);
            interestPayOutList = state.responseModel.rdInteresttype![0].rdInterestPayoutList!;
            interestPayOutKVList  =  RdInterestPayoutList.keyValueList(interestPayOutList);
            interestDetailsModel = state.responseModel;
          }
          else if(state is RDInterestRateSuccessState){
            isTenureLoader = false;
            if(state.responseModel.pMinInterestRate != null && state.responseModel.pMaxInterestRate != null){
              minInterestRate= double.parse(state.responseModel.pMinInterestRate.toString());
              maxInterestRate= double.parse(state.responseModel.pMaxInterestRate.toString());
            }
            _currentRangeValues = maxInterestRate;
            isInterestRate=true;
          }
          else if(state is RDSchemeDescrSuccessState){
            isTenureLoader = false;
            descriptionList = state.responseModel;
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

  Column buildBody(BuildContext context, List<SchemaDetailsModel> responseModel) {
    double gapHeight=15.0;
    return Column(
      children: [
        Visibility(
          visible: isDescriptionVisible,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
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
              flex: 3,
              child: CustomDropdown(context: context,selectedValue: _selectedRDNameValue,
                onChanged: (value) {
                  _selectedRDNameValue = value;
                  if(_selectedRDNameValue.name == "DAILY DEPOSITS"){
                    isAmountVisible = false;
                  }
                  else{
                    isAmountVisible=true;
                  }
                  setState(() {
                  });
                  Navigator.pop(context);
                  context.read<RDBloc>().add(RDGetTenureEvent(_selectedRDNameValue.name));
                  context.read<RDBloc>().add(GetRdDescriptionEvent(_selectedRDNameValue.name));
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
                    flex: 3,
                    child:CustomTextField(
                        boxHeight: 45,
                        context: context, controller: rdAmountController,
                        onChanged: (value) {
                          if(tenureTxtController.text != "" && rdAmountController.text != ""){
                            context.read<RDBloc>().add(GetRDInterestDetailsEvent(_selectedRDNameValue.id,_selectedRDNameValue.name, tenureTxtController.text,_selectedTenureValue.name,rdAmountController.text));
                          }
                        }, hint: "Enter RD Installment Amount", textInputType: TextInputType.number),
                  )
                ],
              ),
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
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomTextField(
                        boxHeight: 45,
                        context: context, controller: tenureTxtController,
                        onChanged: (value) {
                          if(tenureTxtController.text != "" && rdAmountController.text != ""){
                            context.read<RDBloc>().add(GetRDInterestDetailsEvent(_selectedRDNameValue.id,_selectedRDNameValue.name, tenureTxtController.text,_selectedTenureValue.name,rdAmountController.text));
                          }
                        }, hint: "Enter Tenure", textInputType: TextInputType.number),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    flex: 2,
                    child: CustomDropdown(context: context,selectedValue: _selectedTenureValue,
                      onChanged: (value) {
                        _selectedTenureValue = value;
                        if(tenureTxtController.text != "" && rdAmountController.text != ""){
                          context.read<RDBloc>().add(GetRDInterestDetailsEvent(_selectedRDNameValue.id,_selectedRDNameValue.name, tenureTxtController.text,_selectedPayInValue.name,rdAmountController.text));
                        }
                        setState(() {
                        });
                        Navigator.pop(context);
                      },
                      hint: "",items:tenureKVList,icon: Icons.arrow_downward,labelText: '', ),
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(height: gapHeight),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                flex: 2,
                child: Text('Installment Pay-In',style: AppStyles.boldTextBlack)),
            const SizedBox(width: 10,),
            Expanded(
              flex: 3,
              child: CustomDropdown(context: context,selectedValue: _selectedPayInValue,
                onChanged: (value) {
                  _selectedPayInValue = value;
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
              flex: 3,
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
              flex: 3,
              child: CustomDropdown(context: context,selectedValue: _selectedPayOutValue,
                onChanged: (value) {
                  _selectedPayOutValue = value;
                  if(tenureTxtController.text != "" && rdAmountController.text != ""){
                    context.read<RDBloc>().add(GetRDInterestRateEvent(_selectedRDNameValue.name, rdAmountController.text, tenureTxtController.text, _selectedTenureValue.name, _selectedPayOutValue.name));
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
              flex: 4,
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
                    interestRateController.text = value.toString();
                  });
                },),
            ),
          ],
        ),

        SizedBox(height: gapHeight),
        SizedBox(height: gapHeight),
        ListView.builder(
          shrinkWrap: true,
          itemCount: maturityList.length,
          itemBuilder:(context, i) {
            return Container(
              decoration: BoxDecoration(
                  color: AppStyles.gridColor,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text('Interest Amount',style: AppStyles.boldTextBlack,),
                        SizedBox(height: 10,),
                        Text(maturityList[i].pInterestamount.toString(),style: AppStyles.smallLabelTextBold),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Maturity Amount',style: AppStyles.boldTextBlack),
                        SizedBox(height: 10,),
                        Text(maturityList[i].pMatueritytAmount.toString(),style: AppStyles.smallLabelTextBold),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: gapHeight),
        SizedBox(height: gapHeight),
        SizedBox(height: gapHeight),

        Visibility(
          visible: isAmountVisible,
          child: payButton(() {
            context.read<RDBloc>().add(GetRDMaturityEvent(_selectedPayInValue.name,tenureTxtController.text, rdAmountController.text,
                _selectedPayOutValue.name,_selectedInterestTypeValue.name,
                interestRateController.text,interestDetailsModel.pCaltype.toString(),interestDetailsModel.pCompoundInterestType.toString()
            ));
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
                            label: SizedBox(
                              child: Center(
                                child: Text(
                                  "Installment Amount",
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              child: Center(
                                child: Text(
                                  "Investment Period"
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              child: Center(
                                child: Text(
                                  "Interest Rate/Value Per 100"
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              child: Center(
                                child: Text(
                                  "Interest Type"
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              child: Center(
                                child: Text(
                                  "Compound Type"
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              child: Center(
                                child: Text(
                                  "Interest PayOut"
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
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
          child: Center(
              child: Text(
              "${data.pMinInstallmentAmount.toString()} - ${data.pMaxInstallmentAmount.toString()}",
                  style: AppStyles.smallLabelTextBlack)),
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
