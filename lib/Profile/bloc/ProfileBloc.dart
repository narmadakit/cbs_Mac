
import 'package:finsta_mac/Profile/bloc/ProfileEvent.dart';
import 'package:finsta_mac/Profile/bloc/ProfileState.dart';
import 'package:finsta_mac/network/Repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Home/model/MemberDetailsResponse.dart';
import '../../utils/SharedPrefs.dart';


class ProfileBloc extends Bloc<ProfileEvent,ProfileState>{
  Repository repo;
  ProfileBloc(this.repo) : super(ProfileInitState()){
    on<ProfileInitEvent>(getMemberDetailsByMobile);
  }

  getMemberDetailsByMobile(ProfileInitEvent event, Emitter<ProfileState> emit) async {
    String mobileNo = await SharedPrefs.getString(SharedPrefs.mobileNo);
    print("=====mobileNo $mobileNo");
    emit(ProfileLoadingState());
    try{
      List<MemberDetailsResponse> listData= await repo.getMemberDetailsRepo(mobileNo);
      emit(ProfileSuccessState(listData));
      // SharedPrefs.saveData(SharedPrefs.memberDetails, listData);
    }
    catch(e){
     emit(ProfileErrorState(e.toString()));
    }
  }

}