import 'package:equatable/equatable.dart';
import 'package:finsta_mac/Calculator/model/Loans/DepositLoanPayInModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanNameModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanTypeModel.dart';

abstract class LoanState extends Equatable{}

class LoanInitState extends LoanState{
  @override
  List<Object?> get props => [];
}

class LoanLoadingState extends LoanState{
  @override
  List<Object?> get props => [];
}

class GeLoanTypeSuccessState extends LoanState{
  final List<LoanTypeModel> responseModel;
  GeLoanTypeSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}

class GeLoanNameSuccessState extends LoanState{
  final List<LoanNameModel> responseModel;
  GeLoanNameSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}
class GeLoanPayInSuccessState extends LoanState{
  final List<DepositLoanPayInModel> responseModel;
  GeLoanPayInSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}


class LoanErrorState extends LoanState{
  final String error;
  LoanErrorState(this.error);
  @override
  List<Object?> get props => [error];
}