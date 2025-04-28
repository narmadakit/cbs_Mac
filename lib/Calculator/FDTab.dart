import 'dart:developer';
import 'package:finsta_mac/Calculator/bloc/FD/FDState.dart';
import 'package:finsta_mac/Calculator/model/FDInterestDetailsModel.dart';
import 'package:finsta_mac/Calculator/model/DepositTenureModel.dart';
import 'package:finsta_mac/Calculator/model/FDMaturityModel.dart';
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
import 'bloc/FD/FDBloc.dart';
import 'bloc/FD/FDEvent.dart';
import 'model/FDDescriptionModel.dart';

class FDTabWidget extends StatefulWidget {
  const FDTabWidget({
    super.key,
  });

  @override
  State<FDTabWidget> createState() => _FDTabWidgetState();
}

class _FDTabWidgetState extends State<FDTabWidget> {
  var _selectedFDNameValue = KeyValueModel(id: "0", name: "Select");
  var _selectedTenureValue = KeyValueModel(id: "0", name: "Select");
  var _selectedInterestTypeValue = KeyValueModel(id: "0", name: "Select");
  var _selectedPayOutValue = KeyValueModel(id: "0", name: "Select");
  List<KeyValueModel> fdKVList =[];
  List<SchemaDetailsModel> schemaList =[];
  List<FdInterestPayoutList> interestPayOutList =[];
  List<KeyValueModel> tenureKVList =[];
  List<KeyValueModel> interestTypeKVList =[];
  List<KeyValueModel> interestPayOutKVList =[];
  List<FDDescriptionModel> fdSchemeDescList =[];
  List<DepositMaturityModel> maturityList =[];
  bool isTenureLoader=false;
  bool isMaturityLoader=false;
  var tenureTxtController = TextEditingController();
  var fdAmountController = TextEditingController();
  var interestRateController = TextEditingController();
  double minInterestRate =0.0;
  double maxInterestRate=0.0;
  // Define the current values for the range
  double _currentRangeValues = 0;
  bool isInterestRate=false;
  bool isDescriptionVisible=false;
  FDInterestDetailsModel interestDetailsModel=FDInterestDetailsModel();
  var enterAmount;
  double minAmount =0.0;
  double maxAmount =0.0;
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
        BlocProvider<FDBloc>(create: (context) => FDBloc(Repository())..add(FDInitEvent('FIXED DEPOSIT')))
        //FDInitEvent
        //FDGetTenureEvent
        //GetFDSchemeDescrEvent
        //GetFDInterestDetailsEvent
      ],
      child: BlocConsumer<FDBloc,FDStates>(
        builder: (context, state) {
          if(state is FDLoadingState){
            return Center(child: CircularProgressIndicator(color: AppStyles.btnColor));
          }
          if(state is GetTransactionSuccessState){
            schemaList = state.responseModel;
            fdKVList =SchemaDetailsModel.keyValueList(state.responseModel);
            return buildBody(context,state.responseModel);
          }
          else{
           return buildBody(context,schemaList);
          }

        },
        listener: (context, state) {
          if(state is GetTransactionSuccessState){
            ///Get pSchemename
            fdKVList =SchemaDetailsModel.keyValueList(state.responseModel);
          }
          else if(state is FDTenureLoadingState){
            isTenureLoader = true;
            isInterestRate=false;
            isMaturityLoader = false;
          }
          else if(state is FDSchemeDescrSuccessState){
            //Get Min-max amount,tenure,Interest rate
            isTenureLoader = false;
            fdSchemeDescList = state.responseModel;
            if(fdSchemeDescList.isNotEmpty){
              minAmount = double.parse(fdSchemeDescList[0].pMinDepositAmount.toString());
              maxAmount = double.parse(fdSchemeDescList[0].pMaxdepositAmount.toString());
            }
          }
          else if(state is FDGetTenureSuccessState){
            // Get Tenures
            isTenureLoader = false;
            // _selectedTenureValue ="Select";
            tenureKVList =DepositeTenureModel.keyValueList(state.responseModel);
          }
          else if(state is FDInterestDetailsSuccessState){
            //Get pInteresttype
            isTenureLoader = false;
            interestDetailsModel = state.responseModel;
            if(state.responseModel.fdInteresttype?.isNotEmpty ?? false) {
              interestTypeKVList = FdInteresttype.keyValueList(state.responseModel.fdInteresttype!);
              interestPayOutList = state.responseModel.fdInteresttype![0].fdInterestPayoutList!;
              interestPayOutKVList  =  FdInterestPayoutList.keyValueList(interestPayOutList);
            }
            else{
              if((double.parse(enterAmount) < minAmount) || (double.parse(enterAmount) > maxAmount)) {
                showSnackBar(context, 'Enter valid amount\nTo know more see the Description');
              }
              else{
                isTenureLoader = false;
                showSnackBar(context, 'Enter Valid Tenure');
              }
            }
          }
          else if(state is FDInterestRateSuccessState){
            isTenureLoader = false;
            minInterestRate= double.parse(state.responseModel.pMinInterestRate.toString());
            maxInterestRate= double.parse(state.responseModel.pMaxInterestRate.toString());
            _currentRangeValues = minInterestRate;
            isInterestRate=true;
          }
          else if(state is FDMaturitySuccessState){
            //Get MaturityData
            isTenureLoader = false;
            isMaturityLoader = false;
            maturityList = state.responseModel;
          }
          else{
            isTenureLoader = false;
            // showSnackBar(context, 'Enter Valid Data');
          }
        },
      ),
    );
  }

  Widget buildBody(BuildContext context, List<SchemaDetailsModel> responseModel) {
    double gapHeight=20.0;
    return Column(
      children: [
        Column(
              children: [
                Visibility(
                  visible: isDescriptionVisible,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        if(fdSchemeDescList.isNotEmpty){
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
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text('FD Name',style: AppStyles.boldTextBlack)),
                    const SizedBox(width: 10,),
                    Expanded(
                      flex: 4,
                      child: CustomDropdown(context: context,selectedValue: _selectedFDNameValue,
                        onChanged: (value) {
                          _selectedFDNameValue = value;
                          Navigator.pop(context);
                          context.read<FDBloc>().add(FDGetTenureEvent(_selectedFDNameValue.name));
                          context.read<FDBloc>().add(GetFDSchemeDescrEvent(_selectedFDNameValue.name));
                          isDescriptionVisible =true;
                          clearDataFunction();
                        },
                        hint: "",items:fdKVList,icon: Icons.arrow_downward,labelText: '', ),
                    )
                  ],
                ),
                SizedBox(height: gapHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Text('FD Amount',style: AppStyles.boldTextBlack)),
                    const SizedBox(width: 10,),
                    Expanded(
                      flex: 4,
                      child:FocusScope(
                        node: _fdAmountFocusNode,
                        onFocusChange: (value) {
                          if (!value) {
                            if(tenureTxtController.text != ""){
                              context.read<FDBloc>().add(GetFDInterestDetailsEvent(_selectedFDNameValue.id,_selectedFDNameValue.name, tenureTxtController.text,_selectedTenureValue.name,enterAmount));
                            }
                           else if((double.parse(enterAmount) < minAmount) || (double.parse(enterAmount) > maxAmount)) {
                              showSnackBar(context, 'Enter Valid Amount To Know More See The Description');
                            }
                            _selectedInterestTypeValue = KeyValueModel(id: "0", name: "Select");
                            _selectedPayOutValue = KeyValueModel(id: "0", name: "Select");
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        child: CustomTextFieldAmount(
                            boxHeight: 45,
                            context: context, controller: fdAmountController,
                            onChanged: (value) {
                              enterAmount =  removeCommasFromNumber(value).toString();
                            }, hint: "Enter FD Amount", textInputType: TextInputType.number),
                      ),
                    )
                  ],
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
                                boxHeight: 50,
                                context: context, controller: tenureTxtController,
                                onTap: () {
                                  setState(() {
                                    _selectedTenureValue = KeyValueModel(id: "0", name: "Select");
                                  });
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _selectedTenureValue = KeyValueModel(id: "0", name: "Select");
                                  });
                                }, hint: "Enter Tenure", textInputType: TextInputType.number),
                          ),
                          const SizedBox(width: 5,),
                          Expanded(
                            flex: 2,
                            child: CustomDropdown(context: context,selectedValue: _selectedTenureValue,
                              onChanged: (value) {
                                _selectedTenureValue = value;
                                if(tenureTxtController.text != "" && fdAmountController.text != ""){
                                  context.read<FDBloc>().add(GetFDInterestDetailsEvent(_selectedFDNameValue.id,_selectedFDNameValue.name, tenureTxtController.text,_selectedTenureValue.name,fdAmountController.text));
                                }
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
                          if(tenureTxtController.text != "" && fdAmountController.text != ""){
                            context.read<FDBloc>().add(GetFDInterestRateEvent(_selectedFDNameValue.name, fdAmountController.text, tenureTxtController.text, _selectedTenureValue.name, _selectedPayOutValue.name));
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
                        child: Text('Interest Rate\n(Per Annum)',style: AppStyles.boldTextBlack)),
                    const SizedBox(width: 10,),
                   Expanded(
                     flex: 5,
                     child: Column(
                       children: [
                         Slider(
                           value: double.parse(_currentRangeValues.toStringAsFixed(2)),
                           divisions: 100,
                           activeColor: AppStyles.btnColor,
                           inactiveColor: AppStyles.bgColor3,
                           min: double.parse(minInterestRate.toStringAsFixed(2)),
                           max: double.parse(maxInterestRate.toStringAsFixed(2)),
                           label: '${_currentRangeValues.toStringAsFixed(2)}%',
                           onChanged: (value) {
                             setState(() {
                               _currentRangeValues = value;
                               interestRateController.text = value.toString();
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
                isMaturityLoader==true?CircularProgressIndicator(color: AppStyles.btnColor):
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
                                  const SizedBox(height: 10),
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
                                  SizedBox(height: 10,),
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
                )
                :Container(),
                SizedBox(height: gapHeight),
                SizedBox(height: gapHeight),
              ],
            ),
        payButton(() {
    if(validate()){
      isMaturityLoader = true;
      context.read<FDBloc>().add(GetFDMaturityEvent(_selectedTenureValue.name,tenureTxtController.text,enterAmount.toString(),
          _selectedPayOutValue.name,_selectedInterestTypeValue.name,
          _currentRangeValues.toString(),interestDetailsModel.pCaltype.toString(),interestDetailsModel.pCompoundInterestType.toString()
      ));
    }
        },"Calculate")
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Text(_selectedFDNameValue.name,style: AppStyles.highLightText,),
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
                          columns: const[
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
                                    "Deposit Amount",
                                  ),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Center(
                                  child: Text(
                                    "Tenure",
                                  ),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Center(
                                  child: Text(
                                    "Interest Rate\nValue Per 100",
                                  ),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Center(
                                  child: Text(
                                    "Interest Type",
                                  ),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Center(
                                  child: Text(
                                    "Compound Type",
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
                          rows: addressRows(fdSchemeDescList)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  clearDataFunction(){
    _selectedTenureValue = KeyValueModel(id: "0", name: "Select");
    _selectedInterestTypeValue = KeyValueModel(id: "0", name: "Select");
    fdAmountController.text ="";
    tenureTxtController.text="";
    _selectedPayOutValue = KeyValueModel(id: "0", name: "Select");
    _currentRangeValues=0;
    minInterestRate=0;
    maxInterestRate=0;
    maturityList=[];
  }

  bool validate(){
    if(_selectedFDNameValue.name == "Select"){
      showSnackBar(context, 'Enter FD Name');
      return false;
    }
    else if(fdAmountController.text == ""){
      showSnackBar(context, 'Enter FD Amount');
      return false;
    }
    else if((double.parse(enterAmount) < minAmount) || (double.parse(enterAmount) > maxAmount)) {
      showSnackBar(context, 'Enter Valid Amount To Know More See The Description');
      return false;
    }
    else if(tenureTxtController.text == ""){
      showSnackBar(context, 'Enter Tenure To Know More See The Description');
      return false;
    }
    else if(_selectedTenureValue.name == "Select"){
      showSnackBar(context, 'Enter Tenure Mode');
      return false;
    }
    else if(_selectedInterestTypeValue.name == "Select"){
      showSnackBar(context, 'Enter Interest Type ');
      return false;
    }
    else if(_selectedPayOutValue.name == "Select"){
      showSnackBar(context, 'Enter Interest Payout ');
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
}

addressRows(List<FDDescriptionModel> descList){
  return descList.asMap().map((i, data) {
    return MapEntry(
      i,
      DataRow(cells: [
        DataCell(SizedBox(
          child: Center(
              child: Text(
                  "${i + 1}",
                  style: AppStyles.smallLabelTextBlack)),
        )),
        DataCell(SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getRuppeText(fontSize: 14),
              Text(
                  data.pMinDepositAmount.toString(),
                  style: AppStyles.smallLabelTextBlack),
            ],
          ),
        )),
        DataCell(SizedBox(
          child: Center(
              child: Text("${data.pInvestmentPeriodFrom} - ${data.pInvestmentPeriodTo}",
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
                  data.pcompoundinteresttype ?? "N/A",
                  style: AppStyles.smallLabelTextBlack)),
        )),
        DataCell(SizedBox(
          child: Center(
              child: Text(
                  data.pInterestPayOut ?? "N/A",
                  style: AppStyles.smallLabelTextBlack)),
        )),
        DataCell(SizedBox(
          child: Center(
              child: Text(
                  data.papplicanttype.toString(),
                  style: AppStyles.smallLabelTextBlack)),
        )),
      ]
      ),
    );
  }).values.toList();
}
