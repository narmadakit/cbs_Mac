import 'dart:async';

import 'package:finsta_mac/Login/bloc/LoginEvent.dart';
import 'package:finsta_mac/Login/bloc/LoginState.dart';
import 'package:finsta_mac/Login/model/CompanyDetailsModel.dart';
import 'package:finsta_mac/Login/model/GetOtpModel.dart';
import 'package:finsta_mac/network/Repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  Repository repo;
  LoginBloc(this.repo):super(LoginInitState()){
    on<GetOtpEvent>(getOtpBloc);
    on<GetCompanyDetailsEvent>(getCompanyDetailsBloc);
  }


   getOtpBloc(GetOtpEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try{
      GetOtpModel data=await repo.getOtpRepo(event.mobile);
      print("=========data ${data.pIsSaved}");
      emit(LoginSucessState(data));
    }
    catch(e){
      emit(LoginErrorState(e.toString()));
    }
  }

   getCompanyDetailsBloc(GetCompanyDetailsEvent event, Emitter<LoginState> emit) async {
    emit(CompanyLoadingState());
    try{
      CompanyDetailsModel data= await repo.getCompanyDetailsRepo();
      emit(CompanySuccessState(data));
    }
    catch(e){
      emit(CompanyErrorState(e.toString()));
    }
  }
}