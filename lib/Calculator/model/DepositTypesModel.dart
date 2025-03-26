import '../../Home/model/MemberDetailsResponse.dart';
import '../../components/KeyValueModel.dart';

class DepositTypesModel {
  int? pshcemeConfigId;
  String? pSchemename;
  String? pSchemecode;
  String? pSchemenameCode;
  String? pSchemeCalculationmode;

  DepositTypesModel(
      {this.pshcemeConfigId,
        this.pSchemename,
        this.pSchemecode,
        this.pSchemenameCode,
        this.pSchemeCalculationmode});

  DepositTypesModel.fromJson(Map<String, dynamic> json) {
    pshcemeConfigId = json['pshcemeConfigId'];
    pSchemename = json['pSchemename'];
    pSchemecode = json['pSchemecode'];
    pSchemenameCode = json['pSchemenameCode'];
    pSchemeCalculationmode = json['pSchemeCalculationmode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pshcemeConfigId'] = this.pshcemeConfigId;
    data['pSchemename'] = this.pSchemename;
    data['pSchemecode'] = this.pSchemecode;
    data['pSchemenameCode'] = this.pSchemenameCode;
    data['pSchemeCalculationmode'] = this.pSchemeCalculationmode;
    return data;
  }

  static List<KeyValueModel> depositTypesKeyValueList(List<DepositTypesModel> list) {
    return list.map((member) {
      return KeyValueModel(id: member.pSchemename.toString(), name: member.pshcemeConfigId.toString());
    }).toList();
  }
}