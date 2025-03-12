
import 'package:equatable/equatable.dart';
import 'package:finsta_mac/Home/model/LoanDataResponse.dart';

import '../../Home/model/MemberDetailsResponse.dart';

abstract class ProfileState extends Equatable{}

class ProfileInitState extends ProfileState{
  @override
  List<Object?> get props => [];
}

class ProfileLoadingState extends ProfileState{
  @override
  List<Object?> get props => [];
}

class ProfileSuccessState extends ProfileState{
  final List<MemberDetailsResponse> responseData;
  ProfileSuccessState(this.responseData);
  @override
  List<Object?> get props => [responseData];
}

class ProfileErrorState extends ProfileState{
  final String error;
  ProfileErrorState(this.error);
  @override
  List<Object?> get props => [error];
}




