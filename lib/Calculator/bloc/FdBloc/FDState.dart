import 'package:equatable/equatable.dart';
import 'package:finsta_mac/Calculator/model/FDInterestDetailsModel.dart';
import 'package:finsta_mac/Calculator/model/FdTenureModel.dart';

import '../../model/FDInterestRateModel.dart';
import '../../model/SchemaDetailsModel.dart';

abstract class FDStates extends Equatable{}

class FDInitState extends FDStates{
  @override
  List<Object?> get props => [];
}

class FDLoadingState extends FDStates{
  @override
  List<Object?> get props => [];
}

class FDGetTransactionSuccessState extends FDStates{
final List<SchemaDetailsModel> responseModel;
FDGetTransactionSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}

class FDSuccessState extends FDStates{
  @override
  List<Object?> get props => [];
}

class FDErrorState extends FDStates{
  final String error;
  FDErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

//Tenure
class FDTenureLoadingState extends FDStates{
  @override
  List<Object?> get props => [];
}
class FDGetTenureSuccessState extends FDStates{
  final List<FdTenureModel> responseModel;
  FDGetTenureSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}
 //Interest details
class FDInterestDetailsSuccessState extends FDStates{
  final FDInterestDetailsModel responseModel;
  FDInterestDetailsSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}

class FDInterestRateSuccessState extends FDStates{
  final FDInterestRateModel responseModel;
  FDInterestRateSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}