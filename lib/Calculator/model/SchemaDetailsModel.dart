import '../../Home/model/MemberDetailsResponse.dart';
import '../../components/KeyValueModel.dart';

class SchemaDetailsModel {
  int? pshcemeConfigId;
  String? pSchemename;
  String? pSchemecode;
  String? pSchemenameCode;
  String? pSchemeCalculationmode;

  SchemaDetailsModel(
      {this.pshcemeConfigId,
        this.pSchemename,
        this.pSchemecode,
        this.pSchemenameCode,
        this.pSchemeCalculationmode});

  SchemaDetailsModel.fromJson(Map<String, dynamic> json) {
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

  //API returns JSON array not json object so that is List not Map.
  static List<SchemaDetailsModel> fromJsonList(List list) {
    return list.map((item) => SchemaDetailsModel.fromJson(item)).toList();
  }

  static List<KeyValueModel> depositTypesKeyValueList(List<SchemaDetailsModel> list) {
    return list.map((member) {
      return KeyValueModel(id: member.pSchemename.toString(), name: member.pshcemeConfigId.toString());
    }).toList();
  }
}