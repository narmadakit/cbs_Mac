import '../../components/KeyValueModel.dart';

class DepositeTenureModel {
  dynamic pTenurename;
  dynamic pSortorder;
  dynamic pTenurenature;
  dynamic pPayinduration;

  DepositeTenureModel({this.pTenurename, this.pSortorder});

  DepositeTenureModel.fromJson(Map<String, dynamic> json) {
    pTenurename = json['pTenurename'];
    pSortorder = json['pSortorder'];
    pTenurenature = json['pTenurenature'];
    pPayinduration = json['pPayinduration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pTenurename'] = this.pTenurename;
    data['pSortorder'] = this.pSortorder;
    data['pTenurenature'] = this.pTenurenature;
    data['pPayinduration'] = this.pPayinduration;
    return data;
  }

  static List<KeyValueModel> keyValueList(List<DepositeTenureModel> list) {
    return list.map((member) {
      return KeyValueModel(id: member.pSortorder.toString(), name: member.pTenurename.toString());
    }).toList();
  }
  static List<KeyValueModel> rdTenurekeyValueList(List<DepositeTenureModel> list) {
    return list.map((member) {
      return KeyValueModel(id: member.pTenurename.toString(), name: member.pTenurenature.toString());
    }).toList();
  }

  static List<KeyValueModel> rdPayInKeyValueList(List<DepositeTenureModel> list) {
    return list.map((member) {
      return KeyValueModel(id: member.pPayinduration.toString(), name: member.pTenurename.toString());
    }).toList();
  }
}