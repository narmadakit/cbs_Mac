
import 'package:finsta_mac/Calculator/bloc/FD/FDEvent.dart';
import 'package:finsta_mac/Calculator/bloc/FD/FDState.dart';
import 'package:finsta_mac/Calculator/model/DepositInterestRateModel.dart';
import 'package:finsta_mac/Calculator/model/DepositTenureModel.dart';
import 'package:finsta_mac/Calculator/model/FDMaturityModel.dart';
import 'package:finsta_mac/Calculator/model/SchemaDetailsModel.dart';
import 'package:finsta_mac/Calculator/model/FDDescriptionModel.dart';
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
    on<GetFDMaturityEvent>(getFDMaturityAmountBloc);
  }

  getTransactionSchemesBloc(FDInitEvent event, Emitter<FDStates> emit) async {
    emit(FDLoadingState());
    try{
      List<SchemaDetailsModel> listData= await repo.getAllTransactionsSchemesRepo(event.formName);
       emit(GetTransactionSuccessState(listData));
    }
    catch(e){
      emit(FDErrorState(e.toString()));
    }
  }

  getFDTenureListBloc(FDGetTenureEvent event, Emitter<FDStates> emit) async {
    emit(FDTenureLoadingState());
    try{
      List<DepositeTenureModel> listData= await repo.getFDTenureTypeRepo(event.fdName);
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
      DepositInterestRateModel responseData = await repo.getFDInterestTRateRepo(event.fdName,event.depositAmount,event.tenure,event.tenureMode,event.interestPayout);
      emit(FDInterestRateSuccessState(responseData));
    }
    catch(e){
      emit(FDErrorState(e.toString()));
    }
  }

  getFDSchemeDescriptionBloc(GetFDSchemeDescrEvent event, Emitter<FDStates> emit) async {
    emit(FDTenureLoadingState());
    try{
      List<FDDescriptionModel> responseData = await repo.getFDSchemeDescrRepo(event.fdName);
      emit(FDSchemeDescrSuccessState(responseData));
    }
    catch(e){
      emit(FDErrorState(e.toString()));
    }
  }

  getFDMaturityAmountBloc(GetFDMaturityEvent event, Emitter<FDStates> emit) async {
    emit(FDTenureLoadingState());
    try{
      List<FDMaturityModel> responseData = await repo.getFDMaturityAmountRepo(event.interestMode,event.tenure,event.enterAmount,
          event.interestPayout,event.compoundSimpleInterestType,event.interestRate,event.calTyPe,event.compoundType);
      emit(FDMaturitySuccessState(responseData));
    }
    catch(e){
      emit(FDErrorState(e.toString()));
    }
  }

}