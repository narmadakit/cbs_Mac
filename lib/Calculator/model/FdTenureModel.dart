import '../../components/KeyValueModel.dart';
import 'SchemaDetailsModel.dart';

class FdTenureModel {
  dynamic pTenurename;
  dynamic pSortorder;

  FdTenureModel({this.pTenurename, this.pSortorder});

  FdTenureModel.fromJson(Map<String, dynamic> json) {
    pTenurename = json['pTenurename'];
    pSortorder = json['pSortorder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pTenurename'] = this.pTenurename;
    data['pSortorder'] = this.pSortorder;
    return data;
  }

  static List<KeyValueModel> keyValueList(List<FdTenureModel> list) {
    return list.map((member) {
      return KeyValueModel(id: member.pSortorder.toString(), name: member.pTenurename.toString());
    }).toList();
  }
}