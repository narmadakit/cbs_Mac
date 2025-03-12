import 'package:equatable/equatable.dart';
import 'package:finsta_mac/Login/model/CompanyDetailsModel.dart';

abstract class LoginEvent extends Equatable{}

class GetOtpEvent extends LoginEvent{
  final String mobile;

  GetOtpEvent(this.mobile);
  @override
  List<Object?> get props => [mobile];
}

class GetCompanyDetailsEvent extends LoginEvent{

  GetCompanyDetailsEvent();
  @override
  List<Object?> get props => [];
}