import 'package:equatable/equatable.dart';

abstract class FDEvent extends Equatable{
}
class FDInitEvent extends FDEvent{
  final String formName;
  FDInitEvent(this.formName);
  @override
  List<Object?> get props => [formName];
}

class FDGetTenureEvent extends FDEvent{
  final String fdName;
  FDGetTenureEvent(this.fdName);
  @override
  List<Object?> get props => [fdName];
}

class GetFDInterestDetailsEvent extends FDEvent{
  final String fdConfigID,fdName,tenure,tenureMode,depositAmount;

  GetFDInterestDetailsEvent(this.fdConfigID,this.fdName,this.tenure,this.tenureMode,this.depositAmount);
  @override
  List<Object?> get props => [fdConfigID,fdName,tenure,tenureMode,depositAmount];
}
