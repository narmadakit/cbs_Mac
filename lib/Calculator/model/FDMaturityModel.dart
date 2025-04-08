class FDMaturityModel {
  dynamic pMatueritytAmount;
  dynamic pInterestamount;

  FDMaturityModel({this.pMatueritytAmount, this.pInterestamount});

  FDMaturityModel.fromJson(Map<String, dynamic> json) {
    pMatueritytAmount = json['pMatueritytAmount'];
    pInterestamount = json['pInterestamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pMatueritytAmount'] = this.pMatueritytAmount;
    data['pInterestamount'] = this.pInterestamount;
    return data;
  }
}