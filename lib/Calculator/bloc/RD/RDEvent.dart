import 'package:equatable/equatable.dart';

abstract class RDEvent extends Equatable{
}
class RDInitEvent extends RDEvent{
  final String formName;
  RDInitEvent(this.formName);
  @override
  List<Object?> get props => [formName];
}

class RDGetTenureEvent extends RDEvent{
  final String rdName;
  RDGetTenureEvent(this.rdName);
  @override
  List<Object?> get props => [rdName];
}

class GetRDInterestDetailsEvent extends RDEvent{
  final String configID,rdName,tenure,tenureMode,depositAmount;

  GetRDInterestDetailsEvent(this.configID,this.rdName,this.tenure,this.tenureMode,this.depositAmount);
  @override
  List<Object?> get props => [configID,rdName,tenure,tenureMode,depositAmount];
}

class GetRDInterestRateEvent extends RDEvent{
  final String rdName,installmentAmount,tenure,tenureMode,interestPayout;

  GetRDInterestRateEvent(this.rdName,this.installmentAmount,this.tenure,this.tenureMode,this.interestPayout);
  @override
  List<Object?> get props => [rdName,installmentAmount,tenure,tenureMode,interestPayout];
}

class GetRdDescriptionEvent extends RDEvent{
  final String rdName;
  GetRdDescriptionEvent(this.rdName);
  @override
  List<Object?> get props => [rdName];
}
