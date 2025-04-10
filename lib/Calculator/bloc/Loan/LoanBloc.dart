import 'dart:async';

import 'package:finsta_mac/Calculator/bloc/Loan/LoanEvent.dart';
import 'package:finsta_mac/Calculator/model/Loans/DepositLoanPayInModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanNameModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanTypeModel.dart';
import 'package:finsta_mac/network/Repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'LoanState.dart';

class LoanBloc extends Bloc<LoanEvent,LoanState>{
  Repository repo;
  LoanBloc(this.repo):super(LoanInitState()){
    on<LoanInitEvent>(getLoanTypeBloc);
    on<GetLoanNameEvent>(getLoanNameBloc);
    on<GetLoanPayInEvent>(getLoanPayInBloc);
  }


  getLoanTypeBloc(LoanInitEvent event, Emitter<LoanState> emit) async {
    emit(LoanLoadingState());
    try{
        List<LoanTypeModel> listData=await repo.getLoanTypeRepo();
        emit(GeLoanTypeSuccessState(listData));
    }
    catch(e){
      emit(LoanErrorState(e.toString()));
    }
  }

   getLoanNameBloc(GetLoanNameEvent event, Emitter<LoanState> emit) async {
    emit(LoanLoadingState());
    try{
      List<LoanNameModel> listData = await repo.getLoanNameRepo(event.loanTypeId);
      emit(GeLoanNameSuccessState(listData));
    }
    catch(e){
      emit(LoanErrorState(e.toString()));
    }
  }

  getLoanPayInBloc(GetLoanPayInEvent event, Emitter<LoanState> emit) async {
    emit(LoanLoadingState());
    try{
      List<DepositLoanPayInModel> listData = await repo.getEmiLoanPayInRepo(event.loanId,event.schemeId);
      emit(GeLoanPayInSuccessState(listData));
    }
    catch(e){
      emit(LoanErrorState(e.toString()));
    }
  }
}