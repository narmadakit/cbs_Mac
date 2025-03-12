import 'package:equatable/equatable.dart';
import 'package:finsta_mac/Home/model/LoanDataResponse.dart';

abstract class HomeEvent extends Equatable {}

class HomeInitSEvent extends HomeEvent{
  @override
  List<Object?> get props => [];
}

class HomeSuccessEvent extends HomeEvent{
  final LoanDataResponse responseData =LoanDataResponse();
  @override
  List<Object?> get props => [responseData];
}

class GetAllDuesEvent extends HomeEvent{
  GetAllDuesEvent();
  @override
  List<Object?> get props => [];
}