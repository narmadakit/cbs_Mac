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
}