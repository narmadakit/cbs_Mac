import 'dart:async';

import 'package:finsta_mac/Calculator/bloc/FdBloc/FDEvent.dart';
import 'package:finsta_mac/Calculator/bloc/FdBloc/FDState.dart';
import 'package:finsta_mac/Calculator/model/SchemaDetailsModel.dart';
import 'package:finsta_mac/network/Repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FDBloc extends Bloc<FDEvent,FDStates>{
  Repository repo;
  FDBloc(this.repo):super(FDInitState()){
    on<FDInitEvent>(getTransactionSchemes);
  }

  getTransactionSchemes(FDInitEvent event, Emitter<FDStates> emit) async {
    emit(FDLoadingState());
    try{
      List<SchemaDetailsModel> listData= await repo.getAllTransactionsSchemes(event.formName);
     if(listData.isNotEmpty){
       emit(FDGetTransactionSuccessState(listData));
     }
    }
    catch(e){
      emit(FDErrorState(e.toString()));
    }
  }
}