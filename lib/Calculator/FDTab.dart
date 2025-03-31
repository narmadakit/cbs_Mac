import 'dart:developer';

import 'package:finsta_mac/Calculator/bloc/FdBloc/FDState.dart';
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
  String _selectedFDNameValue = "Select";
  String selectedFDConfigId = "";
  String _selectedTenureValue = "Select";
  List<KeyValueModel> fdList =[];
  List<SchemaDetailsModel> schemaList =[];
  List<KeyValueModel> tenureList =[];
  bool isTenureLoader=false;
  var tenureTxtController = TextEditingController();
  var depositAmountController = TextEditingController();

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
            fdList =SchemaDetailsModel.keyValueList(state.responseModel);
            return buildBody(context,state.responseModel);
          }
          else{
           return buildBody(context,schemaList);
          }

        },
        listener: (context, state) {
          if(state is FDGetTransactionSuccessState){
            fdList =SchemaDetailsModel.keyValueList(state.responseModel);
          }
          else if(state is FDTenureLoadingState){
            isTenureLoader = true;
          }
          else if(state is FDGetTenureSuccessState){
            isTenureLoader = false;
            _selectedTenureValue ="Select";
            tenureList =FdTenureModel.keyValueList(state.responseModel);
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
                      List<SchemaDetailsModel> fdConfigId = schemaList.where((item) => item.pSchemename == _selectedFDNameValue).toList();
                      selectedFDConfigId = fdConfigId[0].pshcemeConfigId.toString();
                      setState(() {
                      });
                      Navigator.pop(context);
                      context.read<FDBloc>().add(FDGetTenureEvent(_selectedFDNameValue));
                    },
                    hint: "",items:fdList,icon: Icons.arrow_downward,labelText: '', ),
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
                            onChanged: (value) {}, hint: "Enter Tenure", textInputType: TextInputType.number),
                      ),
                      SizedBox(width: 5,),
                      Expanded(
                        flex: 1,
                        child: CustomDropdown(context: context,selectedValue: _selectedTenureValue,
                          onChanged: (value) {
                            _selectedTenureValue = value;
                            context.read<FDBloc>().add(GetFDInterestDetailsEvent(selectedFDConfigId,_selectedTenureValue,tenureTxtController.text, _selectedTenureValue,depositAmountController.text));
                            setState(() {
                            });
                            Navigator.pop(context);
                          },
                          hint: "",items:tenureList,icon: Icons.arrow_downward,labelText: '', ),
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
                    child: Text('Deposit Amount',style: AppStyles.boldTextBlack)),
                SizedBox(width: 10,),
                Expanded(
                  flex: 3,
                  child:CustomTextField(
                      boxHeight: 48,
                      context: context, controller: tenureTxtController,
                      onChanged: (value) {}, hint: "Enter Deposit Amount", textInputType: TextInputType.number),
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
                  child: CustomDropdown(context: context,selectedValue: _selectedFDNameValue,
                    onChanged: (value) {
                      _selectedFDNameValue = value;
                      log("===_selectedValue $_selectedFDNameValue");
                      setState(() {
                      });
                      Navigator.pop(context);
                      context.read<FDBloc>().add(FDGetTenureEvent(_selectedFDNameValue));
                    },
                    hint: "",items:fdList,icon: Icons.arrow_downward,labelText: '', ),
                )
              ],
            ),


          ],
        );
  }
}
