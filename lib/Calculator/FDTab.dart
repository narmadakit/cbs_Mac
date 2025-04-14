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
  var tenureTxtController = TextEditingController();
  var fdAmountController = TextEditingController();
  var interestRateController = TextEditingController();
  double minInterestRate =0.0;
  double maxInterestRate=20.0;
  // Define the current values for the range
  double _currentRangeValues = 15;
  bool isInterestRate=false;
  bool isDescriptionVisible=false;
  FDInterestDetailsModel interestDetailsModel=FDInterestDetailsModel();
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
            fdKVList =SchemaDetailsModel.keyValueList(state.responseModel);
          }
          else if(state is FDTenureLoadingState){
            isTenureLoader = true;
            isInterestRate=false;
          }
          else if(state is FDGetTenureSuccessState){
            isTenureLoader = false;
            // _selectedTenureValue ="Select";
            tenureKVList =DepositeTenureModel.keyValueList(state.responseModel);
          }
          else if(state is FDInterestDetailsSuccessState){
            isTenureLoader = false;
            interestTypeKVList = FdInteresttype.keyValueList(state.responseModel.fdInteresttype!);
            interestPayOutList = state.responseModel.fdInteresttype![0].fdInterestPayoutList!;
            interestPayOutKVList  =  FdInterestPayoutList.keyValueList(interestPayOutList);
            interestDetailsModel = state.responseModel;
          }
          else if(state is FDInterestRateSuccessState){
            isTenureLoader = false;
            minInterestRate= double.parse(state.responseModel.pMinInterestRate.toString());
            maxInterestRate= double.parse(state.responseModel.pMaxInterestRate.toString());
            _currentRangeValues = maxInterestRate;
            isInterestRate=true;
          }
          else if(state is FDSchemeDescrSuccessState){
            isTenureLoader = false;
            fdSchemeDescList = state.responseModel;
          }
          else if(state is FDMaturitySuccessState){
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
    double gapHeight=20.0;
    return Column(
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
                    flex: 2,
                    child: Text('FD Amount',style: AppStyles.boldTextBlack)),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 4,
                  child:CustomTextField(
                      boxHeight: 45,
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
                            onChanged: (value) {
                              if(tenureTxtController.text != "" && fdAmountController.text != ""){
                                context.read<FDBloc>().add(GetFDInterestDetailsEvent(_selectedFDNameValue.id,_selectedFDNameValue.name, tenureTxtController.text,_selectedTenureValue.name,fdAmountController.text));
                              }
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
            payButton(() {
              context.read<FDBloc>().add(GetFDMaturityEvent(_selectedTenureValue.name,tenureTxtController.text,fdAmountController.text,
              _selectedPayOutValue.name,_selectedInterestTypeValue.name,
                interestRateController.text,interestDetailsModel.pCaltype.toString(),interestDetailsModel.pCompoundInterestType.toString()
              ));
            },"Calculate")
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
                          label: SizedBox(
                            child: Center(
                              child: Text(
                                "Deposit Amount",
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            child: Center(
                              child: Text(
                                "Investment Period",
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            child: Center(
                              child: Text(
                                "Interest Rate/Value Per 100",
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            child: Center(
                              child: Text(
                                "Interest Type",
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            child: Center(
                              child: Text(
                                "Compound Type",
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            child: Center(
                              child: Text(
                                "Interest PayOut",

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
          child: Center(
              child: Text(
                  data.pMinDepositAmount.toString(),
                  style: AppStyles.smallLabelTextBlack)),
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
                  data.pschemeMaturiytype ?? "N/A",
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
