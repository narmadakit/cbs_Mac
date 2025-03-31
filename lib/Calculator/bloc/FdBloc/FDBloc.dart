import 'dart:developer';

import 'package:finsta_mac/Calculator/bloc/FdBloc/FDEvent.dart';
import 'package:finsta_mac/Calculator/bloc/FdBloc/FDState.dart';
import 'package:finsta_mac/Calculator/model/FDInterestDetailsModel.dart';
import 'package:finsta_mac/Calculator/model/FdTenureModel.dart';
import 'package:finsta_mac/Calculator/model/SchemaDetailsModel.dart';
import 'package:finsta_mac/network/Repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FDBloc extends Bloc<FDEvent,FDStates>{
  Repository repo;
  FDBloc(this.repo):super(FDInitState()){
    on<FDInitEvent>(getTransactionSchemesBloc);
    on<FDGetTenureEvent>(getFDTenureListBloc);
    on<GetFDInterestDetailsEvent>(getFDInterestDetailsBloc);
  }

  getTransactionSchemesBloc(FDInitEvent event, Emitter<FDStates> emit) async {
    emit(FDLoadingState());
    try{
      List<SchemaDetailsModel> listData= await repo.getAllTransactionsSchemesRepo(event.formName);
       emit(FDGetTransactionSuccessState(listData));
    }
    catch(e){
      emit(FDErrorState(e.toString()));
    }
  }

  getFDTenureListBloc(FDGetTenureEvent event, Emitter<FDStates> emit) async {
    emit(FDTenureLoadingState());
    try{
      List<FdTenureModel> listData= await repo.getFDTenureTypeRepo(event.fdName);
      emit(FDGetTenureSuccessState(listData));
    }
    catch(e){
      emit(FDErrorState(e.toString()));
    }
  }

  getFDInterestDetailsBloc(GetFDInterestDetailsEvent event, Emitter<FDStates> emit) async {
    emit(FDTenureLoadingState());
    try{
      List<FDInterestDetailsModel> listData= await repo.getFDInterestDetailsRepo(event.fdConfigID,event.fdName,event.tenure,event.tenureMode,event.depositAmount);
      emit(FDInterestDetailsSuccessState(listData));
    }
    catch(e){
      emit(FDErrorState(e.toString()));
    }
  }
}