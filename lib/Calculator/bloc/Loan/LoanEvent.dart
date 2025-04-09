import 'package:equatable/equatable.dart';

abstract class LoanEvent extends Equatable{
}
class LoanInitEvent extends LoanEvent{
  // final String formName;
  // RDInitEvent(this.formName);
  @override
  List<Object?> get props => [];
}
class GetLoanTypeEvent extends LoanEvent{
  @override
  List<Object?> get props => [];
}