import 'package:equatable/equatable.dart';

abstract class LoanEvent extends Equatable{
}
class LoanInitEvent extends LoanEvent{
  @override
  List<Object?> get props => [];
}

class GetLoanTypeEvent extends LoanEvent{
  @override
  List<Object?> get props => [];
}

class GetLoanNameEvent extends LoanEvent{
  final String loanTypeId;
  GetLoanNameEvent(this.loanTypeId);
  @override
  List<Object?> get props => [loanTypeId];
}

class GetLoanPayInEvent extends LoanEvent{
  final String loanId;
  final String schemeId;
  GetLoanPayInEvent(this.loanId,this.schemeId);
  @override
  List<Object?> get props => [loanId,schemeId];
}

class GetLoanInterestTypeEvent extends LoanEvent{
  final String loanId;
  final String schemeId;
  final String loanPayIn;
  GetLoanInterestTypeEvent(this.loanId,this.schemeId,this.loanPayIn);
  @override
  List<Object?> get props => [loanId,schemeId,loanPayIn];
}

class GetLoanInterestRateEvent extends LoanEvent{
  final String loanId;
  final String schemeId;
  final String loanPayIn;
  final String interestType;
  final String requestAmount;
  final String dateTimeNow;
  final String tenure;

  GetLoanInterestRateEvent(this.loanId,this.schemeId,this.loanPayIn,this.interestType,
  this.requestAmount,this.dateTimeNow,this.tenure);
  @override
  List<Object?> get props => [loanId,schemeId,loanPayIn,interestType,requestAmount,dateTimeNow,tenure];
}

class GetLoanInstalmentModeEvent extends LoanEvent{
  final String loanId;
  GetLoanInstalmentModeEvent(this.loanId);
  @override
  List<Object?> get props => [loanId];
}

class GetLoanFinalLoanViewEvent extends LoanEvent{
  final String loanamount;
  final String interesttype;
  final String loanpayin;
  final String interestrate;
  final String tenureofloan;
  final String loaninstalmentmode;
  final String loanId;
  GetLoanFinalLoanViewEvent({required this.loanamount,required this.interesttype,required this.loanpayin,required this.interestrate,required this.tenureofloan,required this.loaninstalmentmode,required this.loanId});
  @override
  List<Object?> get props => [loanamount,interesttype,loanpayin,interestrate,tenureofloan,loaninstalmentmode,loanId];
}