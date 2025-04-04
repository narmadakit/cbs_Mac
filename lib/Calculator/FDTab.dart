import 'dart:developer';
import 'package:finsta_mac/Calculator/bloc/FdBloc/FDState.dart';
import 'package:finsta_mac/Calculator/model/FDInterestDetailsModel.dart';
import 'package:finsta_mac/Calculator/model/FdTenureModel.dart';
import 'package:finsta_mac/Calculator/model/SchemaDetailsModel.dart';
import 'package:finsta_mac/components/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/CustomDropdown.dart';
import '../components/KeyValueModel.dart';
import '../network/Repository.dart';
import '../utils/AppStyles.dart';
import 'bloc/FdBloc/FDBloc.dart';
import 'bloc/FdBloc/FDEvent.dart';
import 'model/FDSchemeDescModel.dart';

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
  List<FDSchemeDescrModel> fdSchemeDescList =[];
  bool isTenureLoader=false;
  var tenureTxtController = TextEditingController();
  var fdAmountController = TextEditingController();
  var interestRateController = TextEditingController();
  dynamic minInterestRate;
  dynamic maxInterestRate;
  bool isInterestRate=false;
  bool isDescriptionVisible=false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FDBloc>(create: (context) => FDBloc(Repository())..add(FDInitEvent('FIXED DEPOSIT')))
      ],
      child: BlocConsumer<FDBloc,FDStates>(
        builder: (context, state) {
          if(state is FDLoadingState){
            return Center(child: CircularProgressIndicator(color: AppStyles.btnColor));
          }
          if(state is FDGetTransactionSuccessState){
            schemaList = state.responseModel;
            fdKVList =SchemaDetailsModel.keyValueList(state.responseModel);
            return buildBody(context,state.responseModel);
          }
          else{
           return buildBody(context,schemaList);
          }

        },
        listener: (context, state) {
          if(state is FDGetTransactionSuccessState){
            fdKVList =SchemaDetailsModel.keyValueList(state.responseModel);
          }
          else if(state is FDTenureLoadingState){
            isTenureLoader = true;
            isInterestRate=false;
          }
          else if(state is FDGetTenureSuccessState){
            isTenureLoader = false;
            // _selectedTenureValue ="Select";
            tenureKVList =FdTenureModel.keyValueList(state.responseModel);
          }
          else if(state is FDInterestDetailsSuccessState){
            isTenureLoader = false;
            interestTypeKVList = FdInteresttype.keyValueList(state.responseModel.fdInteresttype!);
            interestPayOutList = state.responseModel.fdInteresttype![0].fdInterestPayoutList!;
            interestPayOutKVList  =  FdInterestPayoutList.keyValueList(interestPayOutList);
          }
          else if(state is FDInterestRateSuccessState){
            isTenureLoader = false;
            minInterestRate= state.responseModel.pMinInterestRate.toString();
            maxInterestRate= state.responseModel.pMaxInterestRate.toString();
            isInterestRate=true;
          }
          else if(state is FDSchemeDescrSuccessState){
            isTenureLoader = false;
            fdSchemeDescList = state.responseModel;
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
            SizedBox(height: gapHeight),
            Visibility(
              visible: isDescriptionVisible,
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
                          child: Text('Description',style: AppStyles.smallLabelText,),
                        ))),
              ),
            ),
            SizedBox(height: gapHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    flex: 1,
                    child: Text('FD Name',style: AppStyles.boldTextBlack)),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 3,
                  child: CustomDropdown(context: context,selectedValue: _selectedFDNameValue,
                    onChanged: (value) {
                      _selectedFDNameValue = value;
                      setState(() {
                      });
                      Navigator.pop(context);
                      context.read<FDBloc>().add(FDGetTenureEvent(_selectedFDNameValue.name));
                      context.read<FDBloc>().add(GetFDSchemeDescrEvent(_selectedFDNameValue.name));
                      isDescriptionVisible =true;
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
                    flex: 1,
                    child: Text('FD Amount',style: AppStyles.boldTextBlack)),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 3,
                  child:CustomTextField(
                      boxHeight: 50,
                      context: context, controller: fdAmountController,
                      onChanged: (value) {
                        if(tenureTxtController.text != "" && fdAmountController.text != ""){
                          context.read<FDBloc>().add(GetFDInterestDetailsEvent(_selectedFDNameValue.id,_selectedFDNameValue.name, tenureTxtController.text,_selectedTenureValue.name,fdAmountController.text));
                        }
                      }, hint: "Enter FD Amount", textInputType: TextInputType.number),
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
                  flex: 1,
                    child: Text('Tenure',style: AppStyles.boldTextBlack)),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(
                       flex: 2,
                        child: CustomTextField(
                            boxHeight: 50,
                            context: context, controller: tenureTxtController,
                            onChanged: (value) {
                              if(tenureTxtController.text != "" && fdAmountController.text != ""){
                                context.read<FDBloc>().add(GetFDInterestDetailsEvent(_selectedFDNameValue.id,_selectedFDNameValue.name, tenureTxtController.text,_selectedTenureValue.name,fdAmountController.text));
                              }
                            }, hint: "Enter Tenure", textInputType: TextInputType.number),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        flex: 1,
                        child: CustomDropdown(context: context,selectedValue: _selectedTenureValue,
                          onChanged: (value) {
                            _selectedTenureValue = value;
                            if(tenureTxtController.text != "" && fdAmountController.text != ""){
                              context.read<FDBloc>().add(GetFDInterestDetailsEvent(_selectedFDNameValue.id,_selectedFDNameValue.name, tenureTxtController.text,_selectedTenureValue.name,fdAmountController.text));
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
                    flex: 1,
                    child: Text('Interest\nType',style: AppStyles.boldTextBlack)),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 3,
                  child: CustomDropdown(context: context,selectedValue: _selectedInterestTypeValue,
                    onChanged: (value) {
                      _selectedInterestTypeValue = value;
                      setState(() {
                      });
                      Navigator.pop(context);
                      // context.read<FDBloc>().add(FDGetTenureEvent(_selectedFDNameValue.name));
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
                    flex: 1,
                    child: Text('Interest Payout',style: AppStyles.boldTextBlack)),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
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
            Visibility(
              visible: isInterestRate,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Expanded(
                      flex:2,
                        child: Container()),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          const Text('Min: '),
                          Text(minInterestRate??""),
                        ],
                      ),
                    ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            const Text('Max: '),
                            Text(maxInterestRate??""),
                          ],
                        ),
                      ),
                  ],),
                  const SizedBox(height: 5),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    flex: 1,
                    child: Text('Interest\nRate',style: AppStyles.boldTextBlack)),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 3,
                  child:CustomTextField(
                      boxHeight: 50,
                      context: context,
                      controller: interestRateController,
                      onChanged: (value) {
                      }, hint: "Enter Interest Rate", textInputType: TextInputType.number),
                )
              ],
            ),
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
                      headingRowHeight: 55,
                      horizontalMargin: 5,
                      showBottomBorder: true,
                      dataRowMaxHeight: 55,
                      columnSpacing: 12,
                      headingRowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blue.withOpacity(0.40)),
                      columns: [
                        DataColumn(
                          label: SizedBox(
                            width: 40,
                            child: Center(
                              child: Text(
                                "SL No",
                                style: AppStyles.smallLabelTextBold,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            child: Center(
                              child: Text(
                                "Deposit Amount",
                                style: AppStyles.smallLabelTextBold,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            child: Center(
                              child: Text(
                                "Investment Period",
                                style: AppStyles.smallLabelTextBold,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            child: Center(
                              child: Text(
                                "Interest Rate/Value Per 100",
                                style: AppStyles.smallLabelTextBold,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            child: Center(
                              child: Text(
                                "Interest Type",
                                style: AppStyles.smallLabelTextBold,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            child: Center(
                              child: Text(
                                "Compound Type",
                                style: AppStyles.smallLabelTextBold,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            child: Center(
                              child: Text(
                                "Interest PayOut",
                                  style: AppStyles.smallLabelTextBold,
                              ),
                            ),
                          ),
                        ),
                  DataColumn(
                    label: SizedBox(
                      child: Center(
                        child: Text(
                            "Applicant Type",
                            style: AppStyles.smallLabelTextBold,
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
          )
        );
      },
    );
  }
}

addressRows(List<FDSchemeDescrModel> descList){
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
                  data.pMinDepositAmount.toString(),
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
                  data.pcompoundinteresttype??"N/A",
                  style: AppStyles.smallLabelTextBlack)),
        )),
        DataCell(SizedBox(
          child: Center(
              child: Text(
                  data.pschemeMaturiytype??"N/A",
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
