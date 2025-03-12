import 'package:equatable/equatable.dart';
import 'package:finsta_mac/Login/model/CompanyDetailsModel.dart';
import 'package:finsta_mac/Login/model/GetOtpModel.dart';

abstract class LoginState extends Equatable {}

class LoginInitState extends LoginState{
  @override
  List<Object?> get props => [];
}

class LoginLoadingState extends LoginState{
  @override
  List<Object?> get props => [];
}

class LoginSucessState extends LoginState{
  final GetOtpModel responses;

  LoginSucessState(this.responses);
  @override
  List<Object?> get props => [responses];
}

class LoginErrorState extends LoginState{
  final String response;

  LoginErrorState(this.response);
  @override
  List<Object?> get props => [response];
}

class CompanyLoadingState extends LoginState{
  @override
  List<Object?> get props => [];
}
class CompanySuccessState extends LoginState{
  final CompanyDetailsModel data;

  CompanySuccessState(this.data);
  @override
  List<Object?> get props => [data];
}
class CompanyErrorState extends LoginState{
  final String errorMsg;

  CompanyErrorState(this.errorMsg);
  @override
  List<Object?> get props => [errorMsg];
}