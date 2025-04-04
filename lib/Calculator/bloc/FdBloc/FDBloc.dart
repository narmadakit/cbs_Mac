
import 'dart:developer';

import 'package:finsta_mac/Calculator/bloc/FdBloc/FDEvent.dart';
import 'package:finsta_mac/Calculator/bloc/FdBloc/FDState.dart';
import 'package:finsta_mac/Calculator/model/FDInterestRateModel.dart';
import 'package:finsta_mac/Calculator/model/FdTenureModel.dart';
import 'package:finsta_mac/Calculator/model/SchemaDetailsModel.dart';
import 'package:finsta_mac/Calculator/model/FDSchemeDescModel.dart';
import 'package:finsta_mac/network/Repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/FDInterestDetailsModel.dart';

class FDBloc extends Bloc<FDEvent,FDStates>{
  Repository repo;
  FDBloc(this.repo):super(FDInitState()){
    on<FDInitEvent>(getTransactionSchemesBloc);
    on<FDGetTenureEvent>(getFDTenureListBloc);
    on<GetFDInterestDetailsEvent>(getFDInterestDetailsBloc);
    on<GetFDInterestRateEvent>(getFDInterestRateBloc);
    on<GetFDSchemeDescrEvent>(getFDSchemeDescriptionBloc);
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
      FDInterestDetailsModel responseData = await repo.getFDInterestDetailsRepo(event.fdConfigID,event.fdName,event.tenure,event.tenureMode,event.depositAmount);
       emit(FDInterestDetailsSuccessState(responseData));
    }
    catch(e){
      emit(FDErrorState(e.toString()));
    }
  }

  getFDInterestRateBloc(GetFDInterestRateEvent event, Emitter<FDStates> emit) async {
    emit(FDTenureLoadingState());
    try{
      FDInterestRateModel responseData = await repo.getFDInterestTRateRepo(event.fdName,event.depositAmount,event.tenure,event.tenureMode,event.interestPayout);
      emit(FDInterestRateSuccessState(responseData));
    }
    catch(e){
      emit(FDErrorState(e.toString()));
    }
  }

  getFDSchemeDescriptionBloc(GetFDSchemeDescrEvent event, Emitter<FDStates> emit) async {
    emit(FDTenureLoadingState());
    try{
      List<FDSchemeDescrModel> responseData = await repo.getFDSchemeDescrRepo(event.fdName);
      emit(FDSchemeDescrSuccessState(responseData));
    }
    catch(e){
      emit(FDErrorState(e.toString()));
    }
  }
}