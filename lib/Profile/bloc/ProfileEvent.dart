import 'package:equatable/equatable.dart';
import 'package:finsta_mac/Home/model/MemberDetailsResponse.dart';

abstract class ProfileEvent extends Equatable {}

class ProfileInitEvent extends ProfileEvent{
  @override
  List<Object?> get props => [];
}

class ProfileSuccessEvent extends ProfileEvent{
  final List<MemberDetailsResponse> responseData =[];
  @override
  List<Object?> get props => [responseData];
}
