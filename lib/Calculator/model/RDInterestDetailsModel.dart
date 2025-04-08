import 'package:finsta_mac/components/KeyValueModel.dart';

class RDInterestDetailsModel {
  List<RdInteresttype>? rdInteresttype;
  dynamic pRdAmount;
  dynamic pMinInstallmentAmount;
  dynamic pMaxInstallmentAmount;
  dynamic pInvestmentPeriodFrom;
  dynamic pInvestmentPeriodTo;
  dynamic pInterestType;
  dynamic pInterestRateFrom;
  dynamic pInterestRateTo;
  dynamic pInterestOrValueForHundred;
  dynamic pInterestTenureMode;
  dynamic pInterestTenure;
  dynamic pInterestAmount;
  dynamic pDepositAmount;
  dynamic pinstallmentAmount;
  dynamic pMaturityAmount;
  dynamic pPayinDenomination;
  dynamic pInterestPayOut;
  dynamic pCompoundInterestType;
  dynamic pInterestRate;
  dynamic pDepositDate;
  dynamic pMaturityDate;
  bool? pIsinterestDepositinSaving;
  bool? pIsAutoRenew;
  bool? pIsRenewOnlyPrinciple;
  bool? pIsRenewOnlyPrincipleandInterest;
  dynamic pValueORInterestratelabel;
  dynamic pMultiplesof;
  bool? pIsinterestDepositinBank;
  dynamic pReferralcommisiontype;
  dynamic pReferralCommsionvalue;
  dynamic pSquareyard;
  dynamic pCaltype;
  dynamic pRdname;
  dynamic pRdcode;
  dynamic pRdnameCode;
  dynamic pRdCalculationmode;
  dynamic pRdConfigId;
  dynamic pRdDetailsRecordid;

  RDInterestDetailsModel(
      {this.rdInteresttype,
        this.pRdAmount,
        this.pMinInstallmentAmount,
        this.pMaxInstallmentAmount,
        this.pInvestmentPeriodFrom,
        this.pInvestmentPeriodTo,
        this.pInterestType,
        this.pInterestRateFrom,
        this.pInterestRateTo,
        this.pInterestOrValueForHundred,
        this.pInterestTenureMode,
        this.pInterestTenure,
        this.pInterestAmount,
        this.pDepositAmount,
        this.pinstallmentAmount,
        this.pMaturityAmount,
        this.pPayinDenomination,
        this.pInterestPayOut,
        this.pCompoundInterestType,
        this.pInterestRate,
        this.pDepositDate,
        this.pMaturityDate,
        this.pIsinterestDepositinSaving,
        this.pIsAutoRenew,
        this.pIsRenewOnlyPrinciple,
        this.pIsRenewOnlyPrincipleandInterest,
        this.pValueORInterestratelabel,
        this.pMultiplesof,
        this.pIsinterestDepositinBank,
        this.pReferralcommisiontype,
        this.pReferralCommsionvalue,
        this.pSquareyard,
        this.pCaltype,
        this.pRdname,
        this.pRdcode,
        this.pRdnameCode,
        this.pRdCalculationmode,
        this.pRdConfigId,
        this.pRdDetailsRecordid});

  RDInterestDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['rdInteresttype'] != null) {
      rdInteresttype = <RdInteresttype>[];
      json['rdInteresttype'].forEach((v) {
        rdInteresttype!.add(new RdInteresttype.fromJson(v));
      });
    }
    pRdAmount = json['pRdAmount'];
    pMinInstallmentAmount = json['pMinInstallmentAmount'];
    pMaxInstallmentAmount = json['pMaxInstallmentAmount'];
    pInvestmentPeriodFrom = json['pInvestmentPeriodFrom'];
    pInvestmentPeriodTo = json['pInvestmentPeriodTo'];
    pInterestType = json['pInterestType'];
    pInterestRateFrom = json['pInterestRateFrom'];
    pInterestRateTo = json['pInterestRateTo'];
    pInterestOrValueForHundred = json['pInterestOrValueForHundred'];
    pInterestTenureMode = json['pInterestTenureMode'];
    pInterestTenure = json['pInterestTenure'];
    pInterestAmount = json['pInterestAmount'];
    pDepositAmount = json['pDepositAmount'];
    pinstallmentAmount = json['pinstallmentAmount'];
    pMaturityAmount = json['pMaturityAmount'];
    pPayinDenomination = json['pPayinDenomination'];
    pInterestPayOut = json['pInterestPayOut'];
    pCompoundInterestType = json['pCompoundInterestType'];
    pInterestRate = json['pInterestRate'];
    pDepositDate = json['pDepositDate'];
    pMaturityDate = json['pMaturityDate'];
    pIsinterestDepositinSaving = json['pIsinterestDepositinSaving'];
    pIsAutoRenew = json['pIsAutoRenew'];
    pIsRenewOnlyPrinciple = json['pIsRenewOnlyPrinciple'];
    pIsRenewOnlyPrincipleandInterest = json['pIsRenewOnlyPrincipleandInterest'];
    pValueORInterestratelabel = json['pValueORInterestratelabel'];
    pMultiplesof = json['pMultiplesof'];
    pIsinterestDepositinBank = json['pIsinterestDepositinBank'];
    pReferralcommisiontype = json['pReferralcommisiontype'];
    pReferralCommsionvalue = json['pReferralCommsionvalue'];
    pSquareyard = json['pSquareyard'];
    pCaltype = json['pCaltype'];
    pRdname = json['pRdname'];
    pRdcode = json['pRdcode'];
    pRdnameCode = json['pRdnameCode'];
    pRdCalculationmode = json['pRdCalculationmode'];
    pRdConfigId = json['pRdConfigId'];
    pRdDetailsRecordid = json['pRdDetailsRecordid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rdInteresttype != null) {
      data['rdInteresttype'] =
          this.rdInteresttype!.map((v) => v.toJson()).toList();
    }
    data['pRdAmount'] = this.pRdAmount;
    data['pMinInstallmentAmount'] = this.pMinInstallmentAmount;
    data['pMaxInstallmentAmount'] = this.pMaxInstallmentAmount;
    data['pInvestmentPeriodFrom'] = this.pInvestmentPeriodFrom;
    data['pInvestmentPeriodTo'] = this.pInvestmentPeriodTo;
    data['pInterestType'] = this.pInterestType;
    data['pInterestRateFrom'] = this.pInterestRateFrom;
    data['pInterestRateTo'] = this.pInterestRateTo;
    data['pInterestOrValueForHundred'] = this.pInterestOrValueForHundred;
    data['pInterestTenureMode'] = this.pInterestTenureMode;
    data['pInterestTenure'] = this.pInterestTenure;
    data['pInterestAmount'] = this.pInterestAmount;
    data['pDepositAmount'] = this.pDepositAmount;
    data['pinstallmentAmount'] = this.pinstallmentAmount;
    data['pMaturityAmount'] = this.pMaturityAmount;
    data['pPayinDenomination'] = this.pPayinDenomination;
    data['pInterestPayOut'] = this.pInterestPayOut;
    data['pCompoundInterestType'] = this.pCompoundInterestType;
    data['pInterestRate'] = this.pInterestRate;
    data['pDepositDate'] = this.pDepositDate;
    data['pMaturityDate'] = this.pMaturityDate;
    data['pIsinterestDepositinSaving'] = this.pIsinterestDepositinSaving;
    data['pIsAutoRenew'] = this.pIsAutoRenew;
    data['pIsRenewOnlyPrinciple'] = this.pIsRenewOnlyPrinciple;
    data['pIsRenewOnlyPrincipleandInterest'] =
        this.pIsRenewOnlyPrincipleandInterest;
    data['pValueORInterestratelabel'] = this.pValueORInterestratelabel;
    data['pMultiplesof'] = this.pMultiplesof;
    data['pIsinterestDepositinBank'] = this.pIsinterestDepositinBank;
    data['pReferralcommisiontype'] = this.pReferralcommisiontype;
    data['pReferralCommsionvalue'] = this.pReferralCommsionvalue;
    data['pSquareyard'] = this.pSquareyard;
    data['pCaltype'] = this.pCaltype;
    data['pRdname'] = this.pRdname;
    data['pRdcode'] = this.pRdcode;
    data['pRdnameCode'] = this.pRdnameCode;
    data['pRdCalculationmode'] = this.pRdCalculationmode;
    data['pRdConfigId'] = this.pRdConfigId;
    data['pRdDetailsRecordid'] = this.pRdDetailsRecordid;
    return data;
  }
}

class RdInteresttype {
  dynamic pInteresttype;
  dynamic fdInterestPayoutList;
  List<RdInterestPayoutList>? rdInterestPayoutList;

  RdInteresttype(
      {this.pInteresttype,
        this.fdInterestPayoutList,
        this.rdInterestPayoutList});

  RdInteresttype.fromJson(Map<String, dynamic> json) {
    pInteresttype = json['pInteresttype'];
    fdInterestPayoutList = json['fdInterestPayoutList'];
    if (json['rdInterestPayoutList'] != null) {
      rdInterestPayoutList = <RdInterestPayoutList>[];
      json['rdInterestPayoutList'].forEach((v) {
        rdInterestPayoutList!.add(new RdInterestPayoutList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pInteresttype'] = this.pInteresttype;
    data['fdInterestPayoutList'] = this.fdInterestPayoutList;
    if (this.rdInterestPayoutList != null) {
      data['rdInterestPayoutList'] =
          this.rdInterestPayoutList!.map((v) => v.toJson()).toList();
    }
    return data;
  }

 static List<KeyValueModel> keyValueList(List<RdInteresttype> list){
    return list.map((e) {
      return KeyValueModel(id: e.pInteresttype.toString(), name: e.pInteresttype.toString());
    }).toList();
 }
}

class RdInterestPayoutList {
  dynamic pInterestPayOut;
  dynamic pInterestamount;
  dynamic pDepositamount;
  dynamic pMaturityamount;

  RdInterestPayoutList(
      {this.pInterestPayOut,
        this.pInterestamount,
        this.pDepositamount,
        this.pMaturityamount});

  RdInterestPayoutList.fromJson(Map<String, dynamic> json) {
    pInterestPayOut = json['pInterestPayOut'];
    pInterestamount = json['pInterestamount'];
    pDepositamount = json['pDepositamount'];
    pMaturityamount = json['pMaturityamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pInterestPayOut'] = this.pInterestPayOut;
    data['pInterestamount'] = this.pInterestamount;
    data['pDepositamount'] = this.pDepositamount;
    data['pMaturityamount'] = this.pMaturityamount;
    return data;
  }

  static List<KeyValueModel> keyValueList(List<RdInterestPayoutList> list){
    return list.map((e) {
      return KeyValueModel(id: e.pInterestPayOut.toString(), name: e.pInterestPayOut.toString());
    }).toList();
  }
}