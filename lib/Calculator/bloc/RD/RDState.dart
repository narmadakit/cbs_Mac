import 'package:equatable/equatable.dart';
import 'package:finsta_mac/Calculator/model/DepositTenureModel.dart';
import '../../model/DepositInterestRateModel.dart';
import '../../model/RDDescriptionModel.dart';
import '../../model/RDInterestDetailsModel.dart';
import '../../model/SchemaDetailsModel.dart';

abstract class RDStates extends Equatable{}

class RDInitState extends RDStates{
  @override
  List<Object?> get props => [];
}

class RDLoadingState extends RDStates{
  @override
  List<Object?> get props => [];
}

class GetTransactionSuccessState extends RDStates{
  final List<SchemaDetailsModel> responseModel;
  GetTransactionSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}

class RDSuccessState extends RDStates{
  @override
  List<Object?> get props => [];
}

class RDErrorState extends RDStates{
  final String error;
  RDErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

//Tenure
class RDTenureLoadingState extends RDStates{
  @override
  List<Object?> get props => [];
}
class RDGetTenureSuccessState extends RDStates{
  final List<DepositeTenureModel> responseModel;
  RDGetTenureSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}
//Interest details
class RDInterestDetailsSuccessState extends RDStates{
  final RDInterestDetailsModel responseModel;
  RDInterestDetailsSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}

class RDInterestRateSuccessState extends RDStates{
  final DepositInterestRateModel responseModel;
  RDInterestRateSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}

class RDSchemeDescrSuccessState extends RDStates{
  final List<RDDescriptionModel> responseModel;
  RDSchemeDescrSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}