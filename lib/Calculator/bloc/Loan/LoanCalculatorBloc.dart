import 'dart:async';

import 'package:finsta_mac/Calculator/bloc/Loan/LoansCalculatorEvent.dart';
import 'package:finsta_mac/Calculator/model/Loans/DepositLoanPayInModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanInstalmentModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanInterestRatesModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanNameModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanTypeModel.dart';
import 'package:finsta_mac/network/Repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/Loans/FinalLoanViewModel.dart';
import 'LoanCalculatorState.dart';

class LoanCalculatorBloc extends Bloc<LoanEvent,LoanCalculatorState>{
  Repository repo;
  LoanCalculatorBloc(this.repo):super(LoanInitState()){
    on<LoanInitEvent>(getLoanTypeBloc);
    on<GetLoanNameEvent>(getLoanNameBloc);
    on<GetLoanPayInEvent>(getLoanPayInBloc);
    on<GetLoanInterestTypeEvent>(getLoanInterestTypeBloc);
    on<GetLoanInterestRateEvent>(getLoanInterestRateBloc);
    on<GetLoanInstalmentModeEvent>(getLoanInstalmentModeBloc);
    on<GetLoanFinalLoanViewEvent>(getFinalLoanViewBloc);
  }

  getLoanTypeBloc(LoanInitEvent event, Emitter<LoanCalculatorState> emit) async {
    emit(LoanLoadingState());
    try{
        List<LoanTypeModel> listData=await repo.getLoanTypeRepo();
        emit(GeLoanTypeSuccessState(listData));
    }
    catch(e){
      emit(LoanErrorState(e.toString()));
    }
  }

   getLoanNameBloc(GetLoanNameEvent event, Emitter<LoanCalculatorState> emit) async {
    emit(LoanLoadingState());
    try{
      List<LoanNameModel> listData = await repo.getLoanNameRepo(event.loanTypeId);
      emit(GeLoanNameSuccessState(listData));
    }
    catch(e){
      emit(LoanErrorState(e.toString()));
    }
  }

  getLoanPayInBloc(GetLoanPayInEvent event, Emitter<LoanCalculatorState> emit) async {
    emit(LoanLoadingState());
    try{
      List<DepositLoanPayInModel> listData = await repo.getEmiLoanPayInRepo(event.loanId,event.schemeId);
      emit(GeLoanPayInSuccessState(listData));
    }
    catch(e){
      emit(LoanErrorState(e.toString()));
    }
  }

  getLoanInterestTypeBloc(GetLoanInterestTypeEvent event, Emitter<LoanCalculatorState> emit) async {
    emit(LoanLoadingState());
    try{
      List<LoanInterestRatesModel> listData = await repo.getLoanInterestTypeRepo(event.loanId,event.schemeId,event.loanPayIn);
      emit(GetLoanInterestTypeSuccessState(listData));
    }
    catch(e){
      emit(LoanErrorState(e.toString()));
    }
  }

  getLoanInterestRateBloc(GetLoanInterestRateEvent event, Emitter<LoanCalculatorState> emit) async {
    emit(LoanLoadingState());
    try{
      List<LoanInterestRatesModel> listData = await repo.getLoanInterestRateRepo(event.loanId,event.schemeId,event.loanPayIn,event.interestType,event.requestAmount,event.dateTimeNow,event.tenure);
      emit(GetLoanInterestRateSuccessState(listData));
    }
    catch(e){
      emit(LoanErrorState(e.toString()));
    }
  }

  getLoanInstalmentModeBloc(GetLoanInstalmentModeEvent event, Emitter<LoanCalculatorState> emit) async {
    emit(LoanLoadingState());
    try{
      List<LoanInstalmentModel> listData = await repo.getLoanInstalmentModeRepo(event.loanId);
      emit(GetInstalmentModeSuccessState(listData));
    }
    catch(e){
      emit(LoanErrorState(e.toString()));
    }
  }

  getFinalLoanViewBloc(GetLoanFinalLoanViewEvent event, Emitter<LoanCalculatorState> emit) async {
    emit(LoanLoadingState());
    try{
      FinalLoanViewModel responseData = await repo.getFinalLoanViewRepo(event.loanamount,event.interesttype,event.loanpayin,event.interestrate,event.tenureofloan,event.loaninstalmentmode,event.loanId);
      emit(GetFinalLoanViewSuccessState(responseData));
    }
    catch(e){
      emit(LoanErrorState(e.toString()));
    }
  }
}