
import 'package:equatable/equatable.dart';
import 'package:finsta_mac/Home/model/BanneImageModel.dart';
import 'package:finsta_mac/Home/model/LoanDataResponse.dart';

import '../model/MembersAllDuesModel.dart';

abstract class HomeState extends Equatable{}

class HomeInitState extends HomeState{
  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState{
  @override
  List<Object?> get props => [];
}

class HomeSuccessState extends HomeState{
 final LoanDataResponse responseData;
 HomeSuccessState(this.responseData);
  @override
  List<Object?> get props => [responseData];
}
class HomeErrorState extends HomeState{
  final String error;
  HomeErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class AllDuesLoadingState extends HomeState{
  @override
  List<Object?> get props => [];
}

class AllDuesSuccessState extends HomeState{
  final List<MembersAllDuesModel> responseData;
  AllDuesSuccessState(this.responseData);
  @override
  List<Object?> get props => [responseData];
}

class AllDuesErrorState extends HomeState{
  final String error;
  AllDuesErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class BannerImageSuccessState extends HomeState{
  final List<BannerImageModel> responseData;
  BannerImageSuccessState(this.responseData);
  @override
  List<Object?> get props => [responseData];
}


