
import 'package:finsta_mac/Calculator/bloc/RD/RDState.dart';
import 'package:finsta_mac/Calculator/model/RDDescriptionModel.dart';
import 'package:finsta_mac/Calculator/model/RDInterestDetailsModel.dart';
import 'package:finsta_mac/Calculator/model/SchemaDetailsModel.dart';
import 'package:finsta_mac/network/Repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/DepositTenureModel.dart';
import '../../model/DepositInterestRateModel.dart';
import '../../model/FDMaturityModel.dart';
import 'RDEvent.dart';

class RDBloc extends Bloc<RDEvent,RDStates>{
  Repository repo;
  RDBloc(this.repo):super(RDInitState()){
    on<RDInitEvent>(getTransactionSchemesBloc);
    on<RDGetTenureEvent>(getFDTenureListBloc);
    on<GetRDInterestDetailsEvent>(getRDInterestDetailsBloc);
    on<GetRDInterestRateEvent>(getRDInterestRateBloc);
    on<GetRdDescriptionEvent>(getRdDescriptionBloc);
    on<GetRDMaturityEvent>(getRDMaturityAmountBloc);
  }

  getTransactionSchemesBloc(RDInitEvent event, Emitter<RDStates> emit) async {
    emit(RDLoadingState());
    try{
      List<SchemaDetailsModel> listData= await repo.getAllTransactionsSchemesRepo(event.formName);
      emit(GetTransactionSuccessState(listData));
    }
    catch(e){
      emit(RDErrorState(e.toString()));
    }
  }

  getFDTenureListBloc(RDGetTenureEvent event, Emitter<RDStates> emit) async {
    emit(RDTenureLoadingState());
    try{
      List<DepositeTenureModel> listData= await repo.getRDTenureTypeRepo(event.rdName);
      emit(RDGetTenureSuccessState(listData));
    }
    catch(e){
      emit(RDErrorState(e.toString()));
    }
  }

  getRDInterestDetailsBloc(GetRDInterestDetailsEvent event, Emitter<RDStates> emit) async {
    emit(RDTenureLoadingState());
    try{
      RDInterestDetailsModel responseData = await repo.getRDInterestDetailsRepo(event.configID,event.rdName,event.tenure,event.tenureMode,event.amount);
      emit(RDInterestDetailsSuccessState(responseData));
    }
    catch(e){
      emit(RDErrorState(e.toString()));
    }
  }

  getRDInterestRateBloc(GetRDInterestRateEvent event, Emitter<RDStates> emit) async {
    emit(RDTenureLoadingState());
    try{
      DepositInterestRateModel responseData = await repo.getRDInterestTRateRepo(event.rdName,event.installmentAmount,event.tenure,event.tenureMode,event.interestPayout);
      emit(RDInterestRateSuccessState(responseData));
    }
    catch(e){
      emit(RDErrorState(e.toString()));
    }
  }

  getRdDescriptionBloc(GetRdDescriptionEvent event, Emitter<RDStates> emit) async {
    emit(RDTenureLoadingState());
    try{
      List<RDDescriptionModel> responseData = await repo.getRdDescriptionRepo(event.rdName);
      emit(RDSchemeDescrSuccessState(responseData));
    }
    catch(e){
      emit(RDErrorState(e.toString()));
    }
  }

  getRDMaturityAmountBloc(GetRDMaturityEvent event, Emitter<RDStates> emit) async {
    emit(RDTenureLoadingState());
    try{
      List<DepositMaturityModel> responseData = await repo.getRDMaturityAmountRepo(event.interestMode,event.tenure,event.enterAmount,
          event.interestPayout,event.compoundSimpleInterestType,event.interestRate,event.calTyPe,event.compoundType);
      emit(RDMaturitySuccessState(responseData));
    }
    catch(e){
      emit(RDErrorState(e.toString()));
    }
  }
}