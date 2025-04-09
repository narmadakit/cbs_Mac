class DepositMaturityModel {
  dynamic pMatueritytAmount;
  dynamic pInterestamount;

  DepositMaturityModel({this.pMatueritytAmount, this.pInterestamount});

  DepositMaturityModel.fromJson(Map<String, dynamic> json) {
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