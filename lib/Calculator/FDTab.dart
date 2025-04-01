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
  bool isTenureLoader=false;
  var tenureTxtController = TextEditingController();
  var fdAmountController = TextEditingController();
  var interestRateController = TextEditingController();

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
          }
          else if(state is FDGetTenureSuccessState){
            isTenureLoader = false;
            // _selectedTenureValue ="Select";
            tenureKVList =FdTenureModel.keyValueList(state.responseModel);
          }
          else if(state is FDInterestDetailsSuccessState){
            log("===== FDInterestDetailsSuccessState ${state.responseModel}");
            isTenureLoader = false;
            interestTypeKVList = FdInteresttype.keyValueList(state.responseModel.fdInteresttype!);
            interestPayOutList = state.responseModel.fdInteresttype![0].fdInterestPayoutList!;
            interestPayOutKVList  =  FdInterestPayoutList.keyValueList(interestPayOutList);
          }
        },
      ),
    );
  }

  Column buildBody(BuildContext context, List<SchemaDetailsModel> responseModel) {
    return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    flex: 1,
                    child: Text('FD Name',style: AppStyles.boldTextBlack)),
                SizedBox(width: 10,),
                Expanded(
                  flex: 3,
                  child: CustomDropdown(context: context,selectedValue: _selectedFDNameValue,
                    onChanged: (value) {
                      _selectedFDNameValue = value;
                      // List<SchemaDetailsModel> fdConfigId = schemaList.where((item) => item.pSchemename == _selectedFDNameValue).toList();
                      // selectedFDConfigId = fdConfigId[0].pshcemeConfigId.toString();
                      setState(() {
                      });
                      Navigator.pop(context);
                      context.read<FDBloc>().add(FDGetTenureEvent(_selectedFDNameValue.name));
                    },
                    hint: "",items:fdKVList,icon: Icons.arrow_downward,labelText: '', ),
                )
              ],
            ),
            const SizedBox(height: 10,),
            (isTenureLoader == true)?
            CircularProgressIndicator(color: AppStyles.btnColor):
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                    child: Text('Tenure',style: AppStyles.boldTextBlack)),
                SizedBox(width: 10,),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(
                       flex: 2,
                        child: CustomTextField(
                            boxHeight: 48,
                            context: context, controller: tenureTxtController,
                            onChanged: (value) {
                              if(tenureTxtController.text != "" && fdAmountController.text != ""){
                                context.read<FDBloc>().add(GetFDInterestDetailsEvent(_selectedFDNameValue.id,_selectedFDNameValue.name, tenureTxtController.text,_selectedTenureValue.name,fdAmountController.text));
                              }
                            }, hint: "Enter Tenure", textInputType: TextInputType.number),
                      ),
                      SizedBox(width: 5,),
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
            const SizedBox(height: 10,),
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
                      boxHeight: 48,
                      context: context, controller: fdAmountController,
                      onTap: () {
                        if(tenureTxtController.text != "" && fdAmountController.text != ""){
                          context.read<FDBloc>().add(GetFDInterestDetailsEvent(_selectedFDNameValue.id,_selectedFDNameValue.name, tenureTxtController.text,_selectedTenureValue.name,fdAmountController.text));
                        }
                      },
                      onChanged: (value) {
                        if(tenureTxtController.text != "" && fdAmountController.text != ""){
                          context.read<FDBloc>().add(GetFDInterestDetailsEvent(_selectedFDNameValue.id,_selectedFDNameValue.name, tenureTxtController.text,_selectedTenureValue.name,fdAmountController.text));
                        }
                      }, hint: "Enter FD Amount", textInputType: TextInputType.number),
                )
              ],
            ),
            const SizedBox(height: 10,),
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
                      log("===_selectedValue $_selectedInterestTypeValue");
                      setState(() {
                      });
                      Navigator.pop(context);
                      // context.read<FDBloc>().add(FDGetTenureEvent(_selectedFDNameValue.name));
                    },
                    hint: "",items:interestTypeKVList,icon: Icons.arrow_downward,labelText: '', ),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    flex: 1,
                    child: Text('Interest Payout',style: AppStyles.boldTextBlack)),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 3,
                  child: CustomDropdown(context: context,selectedValue: _selectedPayOutValue,
                    onChanged: (value) {
                      _selectedPayOutValue = value;
                      if(tenureTxtController.text != "" && fdAmountController.text != ""){
                        context.read<FDBloc>().add(GetFDInterestRateEvent(_selectedFDNameValue.name,tenureTxtController.text,_selectedTenureValue.name,fdAmountController.text,_selectedPayOutValue.name));
                      }
                      setState(() {
                      });
                      Navigator.pop(context);
                    },
                    hint: "",items:interestPayOutKVList,icon: Icons.arrow_downward,labelText: '', ),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    flex: 1,
                    child: Text('Interest Rate',style: AppStyles.boldTextBlack)),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 3,
                  child:CustomTextField(
                      boxHeight: 48,
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
}
