import '../../components/KeyValueModel.dart';

class FDInterestDetailsModel {
  dynamic fdInterestPayoutList;
  List<FdInteresttype>? fdInteresttype;
  dynamic pFdAmount;
  dynamic pMinDepositAmount;
  dynamic pMaxdepositAmount;
  dynamic pInvestmentPeriodFrom;
  dynamic pInvestmentPeriodTo;
  dynamic pInterestType;
  dynamic pInterestRateFrom;
  dynamic pInterestRateTo;
  dynamic pInterestOrValueForHundred;
  dynamic pInterestTenureMode;
  dynamic pTenure;
  dynamic pInterestTenure;
  dynamic pInterestAmount;
  dynamic pDepositAmount;
  dynamic pMaturityAmount;
  dynamic pPayinDenomination;
  dynamic pInterestPayOut;
  dynamic pINTERESTPAYABLE;
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
  dynamic pGroupID;
  dynamic pFdname;
  dynamic pFdcode;
  dynamic pFdnameCode;
  dynamic pFdCalculationmode;
  dynamic pFdConfigId;
  dynamic pFdDetailsRecordid;

  FDInterestDetailsModel(
      {this.fdInterestPayoutList,
        this.fdInteresttype,
        this.pFdAmount,
        this.pMinDepositAmount,
        this.pMaxdepositAmount,
        this.pInvestmentPeriodFrom,
        this.pInvestmentPeriodTo,
        this.pInterestType,
        this.pInterestRateFrom,
        this.pInterestRateTo,
        this.pInterestOrValueForHundred,
        this.pInterestTenureMode,
        this.pTenure,
        this.pInterestTenure,
        this.pInterestAmount,
        this.pDepositAmount,
        this.pMaturityAmount,
        this.pPayinDenomination,
        this.pInterestPayOut,
        this.pINTERESTPAYABLE,
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
        this.pGroupID,
        this.pFdname,
        this.pFdcode,
        this.pFdnameCode,
        this.pFdCalculationmode,
        this.pFdConfigId,
        this.pFdDetailsRecordid});

  FDInterestDetailsModel.fromJson(Map<String, dynamic> json) {
    fdInterestPayoutList = json['fdInterestPayoutList'];
    if (json['fdInteresttype'] != null) {
      fdInteresttype = <FdInteresttype>[];
      json['fdInteresttype'].forEach((v) {
        fdInteresttype!.add(new FdInteresttype.fromJson(v));
      });
    }
    pFdAmount = json['pFdAmount'];
    pMinDepositAmount = json['pMinDepositAmount'];
    pMaxdepositAmount = json['pMaxdepositAmount'];
    pInvestmentPeriodFrom = json['pInvestmentPeriodFrom'];
    pInvestmentPeriodTo = json['pInvestmentPeriodTo'];
    pInterestType = json['pInterestType'];
    pInterestRateFrom = json['pInterestRateFrom'];
    pInterestRateTo = json['pInterestRateTo'];
    pInterestOrValueForHundred = json['pInterestOrValueForHundred'];
    pInterestTenureMode = json['pInterestTenureMode'];
    pTenure = json['pTenure'];
    pInterestTenure = json['pInterestTenure'];
    pInterestAmount = json['pInterestAmount'];
    pDepositAmount = json['pDepositAmount'];
    pMaturityAmount = json['pMaturityAmount'];
    pPayinDenomination = json['pPayinDenomination'];
    pInterestPayOut = json['pInterestPayOut'];
    pINTERESTPAYABLE = json['pINTERESTPAYABLE'];
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
    pGroupID = json['pGroupID'];
    pFdname = json['pFdname'];
    pFdcode = json['pFdcode'];
    pFdnameCode = json['pFdnameCode'];
    pFdCalculationmode = json['pFdCalculationmode'];
    pFdConfigId = json['pFdConfigId'];
    pFdDetailsRecordid = json['pFdDetailsRecordid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fdInterestPayoutList'] = this.fdInterestPayoutList;
    if (this.fdInteresttype != null) {
      data['fdInteresttype'] =
          this.fdInteresttype!.map((v) => v.toJson()).toList();
    }
    data['pFdAmount'] = this.pFdAmount;
    data['pMinDepositAmount'] = this.pMinDepositAmount;
    data['pMaxdepositAmount'] = this.pMaxdepositAmount;
    data['pInvestmentPeriodFrom'] = this.pInvestmentPeriodFrom;
    data['pInvestmentPeriodTo'] = this.pInvestmentPeriodTo;
    data['pInterestType'] = this.pInterestType;
    data['pInterestRateFrom'] = this.pInterestRateFrom;
    data['pInterestRateTo'] = this.pInterestRateTo;
    data['pInterestOrValueForHundred'] = this.pInterestOrValueForHundred;
    data['pInterestTenureMode'] = this.pInterestTenureMode;
    data['pTenure'] = this.pTenure;
    data['pInterestTenure'] = this.pInterestTenure;
    data['pInterestAmount'] = this.pInterestAmount;
    data['pDepositAmount'] = this.pDepositAmount;
    data['pMaturityAmount'] = this.pMaturityAmount;
    data['pPayinDenomination'] = this.pPayinDenomination;
    data['pInterestPayOut'] = this.pInterestPayOut;
    data['pINTERESTPAYABLE'] = this.pINTERESTPAYABLE;
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
    data['pGroupID'] = this.pGroupID;
    data['pFdname'] = this.pFdname;
    data['pFdcode'] = this.pFdcode;
    data['pFdnameCode'] = this.pFdnameCode;
    data['pFdCalculationmode'] = this.pFdCalculationmode;
    data['pFdConfigId'] = this.pFdConfigId;
    data['pFdDetailsRecordid'] = this.pFdDetailsRecordid;
    return data;
  }
}

class FdInteresttype {
  dynamic pInteresttype;
  List<FdInterestPayoutList>? fdInterestPayoutList;
  dynamic rdInterestPayoutList;

  FdInteresttype(
      {this.pInteresttype,
        this.fdInterestPayoutList,
        this.rdInterestPayoutList});

  FdInteresttype.fromJson(Map<String, dynamic> json) {
    pInteresttype = json['pInteresttype'];
    if (json['fdInterestPayoutList'] != null) {
      fdInterestPayoutList = <FdInterestPayoutList>[];
      json['fdInterestPayoutList'].forEach((v) {
        fdInterestPayoutList!.add(new FdInterestPayoutList.fromJson(v));
      });
    }
    rdInterestPayoutList = json['rdInterestPayoutList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pInteresttype'] = this.pInteresttype;
    if (this.fdInterestPayoutList != null) {
      data['fdInterestPayoutList'] =
          this.fdInterestPayoutList!.map((v) => v.toJson()).toList();
    }
    data['rdInterestPayoutList'] = this.rdInterestPayoutList;
    return data;
  }

  static List<KeyValueModel> keyValueList(List<FdInteresttype> list) {
    return list.map((member) {
      return KeyValueModel(id: member.pInteresttype.toString(), name: member.pInteresttype.toString());
    }).toList();
  }
}

class FdInterestPayoutList {
  dynamic pInterestPayOut;
  dynamic pinterestamount;
  dynamic pmaturityamount;

  FdInterestPayoutList(
      {this.pInterestPayOut, this.pinterestamount, this.pmaturityamount});

  FdInterestPayoutList.fromJson(Map<String, dynamic> json) {
    pInterestPayOut = json['pInterestPayOut'];
    pinterestamount = json['pinterestamount'];
    pmaturityamount = json['pmaturityamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pInterestPayOut'] = this.pInterestPayOut;
    data['pinterestamount'] = this.pinterestamount;
    data['pmaturityamount'] = this.pmaturityamount;
    return data;
  }

  static List<KeyValueModel> keyValueList(List<FdInterestPayoutList> list) {
    return list.map((member) {
      return KeyValueModel(id: member.pInterestPayOut.toString(), name: member.pInterestPayOut.toString());
    }).toList();
  }
}