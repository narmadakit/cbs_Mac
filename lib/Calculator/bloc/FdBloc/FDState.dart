import 'package:equatable/equatable.dart';

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