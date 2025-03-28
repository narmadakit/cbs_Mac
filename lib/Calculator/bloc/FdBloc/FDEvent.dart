import 'package:equatable/equatable.dart';

abstract class FDEvent extends Equatable{
}
class FDInitEvent extends FDEvent{
  final String formName;
  FDInitEvent(this.formName);
  @override
  List<Object?> get props => [formName];

}
