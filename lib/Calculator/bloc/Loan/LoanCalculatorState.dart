import 'package:equatable/equatable.dart';
import 'package:finsta_mac/Calculator/model/Loans/DepositLoanPayInModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/FinalLoanViewModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanInstalmentModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanInterestRatesModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanNameModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanTypeModel.dart';

abstract class LoanCalculatorState extends Equatable{}

class LoanInitState extends LoanCalculatorState{
  @override
  List<Object?> get props => [];
}

class LoanLoadingState extends LoanCalculatorState{
  @override
  List<Object?> get props => [];
}

class GeLoanTypeSuccessState extends LoanCalculatorState{
  final List<LoanTypeModel> responseModel;
  GeLoanTypeSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}

class GeLoanNameSuccessState extends LoanCalculatorState{
  final List<LoanNameModel> responseModel;
  GeLoanNameSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}
class GeLoanPayInSuccessState extends LoanCalculatorState{
  final List<DepositLoanPayInModel> responseModel;
  GeLoanPayInSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}

class LoanErrorState extends LoanCalculatorState{
  final String error;
  LoanErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class GetLoanInterestTypeSuccessState extends LoanCalculatorState{
  final List<LoanInterestRatesModel> responseModel;
  GetLoanInterestTypeSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}

class GetMinMaxLoanAmountSuccessState extends LoanCalculatorState{
  final List<LoanInterestRatesModel> responseModel;
  GetMinMaxLoanAmountSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}

class GetLoanInterestRateSuccessState extends LoanCalculatorState{
  final List<LoanInterestRatesModel> responseModel;
  GetLoanInterestRateSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}

class GetInstalmentModeSuccessState extends LoanCalculatorState{
  final List<LoanInstalmentModel> responseModel;
  GetInstalmentModeSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}

class GetFinalLoanViewSuccessState extends LoanCalculatorState{
  final FinalLoanViewModel responseModel;
  GetFinalLoanViewSuccessState(this.responseModel);
  @override
  List<Object?> get props => [responseModel];
}