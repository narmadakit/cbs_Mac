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