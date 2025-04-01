class FDInterestRateModel {
  dynamic pTenureCount;
  dynamic pMinInterestRate;
  dynamic pMaxInterestRate;
  dynamic pReferralcommisiontype;
  dynamic pReferralCommisionvalue;
  dynamic pRatePerSquareYard;
  dynamic pValuefor100;
  dynamic pCaltype;

  FDInterestRateModel(
      {this.pTenureCount,
        this.pMinInterestRate,
        this.pMaxInterestRate,
        this.pReferralcommisiontype,
        this.pReferralCommisionvalue,
        this.pRatePerSquareYard,
        this.pValuefor100,
        this.pCaltype});

  FDInterestRateModel.fromJson(Map<String, dynamic> json) {
    pTenureCount = json['pTenureCount'];
    pMinInterestRate = json['pMinInterestRate'];
    pMaxInterestRate = json['pMaxInterestRate'];
    pReferralcommisiontype = json['pReferralcommisiontype'];
    pReferralCommisionvalue = json['pReferralCommisionvalue'];
    pRatePerSquareYard = json['pRatePerSquareYard'];
    pValuefor100 = json['pValuefor100'];
    pCaltype = json['pCaltype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pTenureCount'] = this.pTenureCount;
    data['pMinInterestRate'] = this.pMinInterestRate;
    data['pMaxInterestRate'] = this.pMaxInterestRate;
    data['pReferralcommisiontype'] = this.pReferralcommisiontype;
    data['pReferralCommisionvalue'] = this.pReferralCommisionvalue;
    data['pRatePerSquareYard'] = this.pRatePerSquareYard;
    data['pValuefor100'] = this.pValuefor100;
    data['pCaltype'] = this.pCaltype;
    return data;
  }
}