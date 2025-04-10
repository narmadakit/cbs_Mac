import 'dart:convert';
import 'dart:developer';

import 'package:finsta_mac/Home/bloc/HomeEvent.dart';
import 'package:finsta_mac/Home/bloc/HomeState.dart';
import 'package:finsta_mac/Home/model/BanneImageModel.dart';
import 'package:finsta_mac/Home/model/LoanDataResponse.dart';
import 'package:finsta_mac/network/Repository.dart';
import 'package:finsta_mac/utils/GlobalFunctions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Login/model/CompanyDetailsModel.dart';
import '../../utils/SharedPrefs.dart';
import '../model/MembersAllDuesModel.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  Repository repo;
  HomeBloc(this.repo) : super(HomeInitState()){
    on<HomeInitSEvent>(getLoanDetailsByMemberId);
    on<GetAllDuesEvent>(getMemberAllDues);
  }

  String memberId="";

  getLoanDetailsByMemberId(HomeInitSEvent event, Emitter<HomeState> emit) async {
    memberId = await SharedPrefs.getString(SharedPrefs.memberId);
    emit(HomeLoadingState());
    try{
      LoanDataResponse data= await repo.getLoanDetailsRepo(memberId);
      emit(HomeSuccessState(data));

      List<BannerImageModel> dataImage= await repo.getBannerImageRepo();
      emit(BannerImageSuccessState(dataImage));
    }
    catch(e){
      emit(HomeErrorState(e.toString()));
    }
  }

  // getBannerImage(HomeInitSEvent event, Emitter<HomeState> emit) async {
  //   emit(HomeLoadingState());
  //   try{
  //     List<BannerImageModel> data= await repo.getBannerImageRepo();
  //     emit(BannerImageSuccessState(data));
  //   }
  //   catch(e){
  //     emit(HomeErrorState(e.toString()));
  //   }
  // }

  getMemberAllDues(GetAllDuesEvent event, Emitter<HomeState> emit) async {
    memberId = await SharedPrefs.getString(SharedPrefs.memberId);

    emit(AllDuesLoadingState());
    try{
      List<MembersAllDuesModel> listData= await repo.getMemberAllDuesRepo(memberId,dateNow);
      emit(AllDuesSuccessState(listData));
    }
    catch(e){
      emit(AllDuesErrorState(e.toString()));
    }
  }

}