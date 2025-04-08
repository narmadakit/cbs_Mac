import 'package:equatable/equatable.dart';
import 'package:finsta_mac/Calculator/model/FDMaturityModel.dart';

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

class GetFDInterestRateEvent extends FDEvent{
  final String fdName,depositAmount,tenure,tenureMode,interestPayout;

  GetFDInterestRateEvent(this.fdName,this.depositAmount,this.tenure,this.tenureMode,this.interestPayout);
  @override
  List<Object?> get props => [fdName,depositAmount,tenure,tenureMode,interestPayout];
}

class GetFDSchemeDescrEvent extends FDEvent{
  final String fdName;
  GetFDSchemeDescrEvent(this.fdName);
  @override
  List<Object?> get props => [fdName];
}

class GetFDMaturityEvent extends FDEvent{
  final String interestMode;
  final String tenure;
  final String enterAmount;
  final String interestPayout;
  final String compoundSimpleInterestType;
  final String  interestRate;
  final String  calTyPe;
  final String  compoundType;
  GetFDMaturityEvent(
      this.interestMode,this.tenure,this.enterAmount,this.interestPayout,
      this.compoundSimpleInterestType,this.interestRate,this.calTyPe,this.compoundType);
  @override
  List<Object?> get props => [interestMode,tenure,enterAmount,interestPayout,compoundSimpleInterestType,
    interestRate,calTyPe,compoundType];
}
