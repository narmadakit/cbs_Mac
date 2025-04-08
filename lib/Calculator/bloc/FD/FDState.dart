import 'package:equatable/equatable.dart';
import 'package:finsta_mac/Calculator/model/FDInterestDetailsModel.dart';
import 'package:finsta_mac/Calculator/model/FDDescriptionModel.dart';
import 'package:finsta_mac/Calculator/model/DepositTenureModel.dart';
import 'package:finsta_mac/Calculator/model/FDMaturityModel.dart';

import '../../model/DepositInterestRateModel.dart';
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

class GetTransactionSuccessState extends FDStates{
final List<SchemaDetailsModel> responseModel;
GetTransactionSuccessState(this.responseModel);
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
  final List<DepositeTenureModel> responseModel;
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
  final DepositInterestRateModel responseModel;
  FDInterestRateSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}

class FDSchemeDescrSuccessState extends FDStates{
  final List<FDDescriptionModel> responseModel;
  FDSchemeDescrSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}

class FDMaturitySuccessState extends FDStates{
  final List<FDMaturityModel> responseModel;
  FDMaturitySuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}