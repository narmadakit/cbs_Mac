class RDDescriptionModel {
  String? pRdCalculationmode;
  dynamic pMinInstallmentAmount;
  dynamic pMaxInstallmentAmount;
  String? pInvestmentPeriodFrom;
  String? pInvestmentPeriodTo;
  String? pInterestPayOut;
  String? pInterestType;
  dynamic pCompoundType;
  dynamic pInterestRateFrom;
  dynamic pInterestRateTo;
  dynamic pMultiplesof;
  dynamic pValuefor100;
  String? pCaltype;
  List<PTenureModesList>? pTenureModesList;
  dynamic pRdtabletenure;
  dynamic pRdtablematurityamount;
  dynamic pRdtabledepositamount;
  dynamic pRdtableinterestamount;
  dynamic pRdtablepayindenomination;
  String? pRdtabletenuremode;
  String? pinstallmentpayin;
  String? papplicanttype;

  RDDescriptionModel(
      {this.pRdCalculationmode,
        this.pMinInstallmentAmount,
        this.pMaxInstallmentAmount,
        this.pInvestmentPeriodFrom,
        this.pInvestmentPeriodTo,
        this.pInterestPayOut,
        this.pInterestType,
        this.pCompoundType,
        this.pInterestRateFrom,
        this.pInterestRateTo,
        this.pMultiplesof,
        this.pValuefor100,
        this.pCaltype,
        this.pTenureModesList,
        this.pRdtabletenure,
        this.pRdtablematurityamount,
        this.pRdtabledepositamount,
        this.pRdtableinterestamount,
        this.pRdtablepayindenomination,
        this.pRdtabletenuremode,
        this.pinstallmentpayin,
        this.papplicanttype});

  RDDescriptionModel.fromJson(Map<String, dynamic> json) {
    pRdCalculationmode = json['pRdCalculationmode'];
    pMinInstallmentAmount = json['pMinInstallmentAmount'];
    pMaxInstallmentAmount = json['pMaxInstallmentAmount'];
    pInvestmentPeriodFrom = json['pInvestmentPeriodFrom'];
    pInvestmentPeriodTo = json['pInvestmentPeriodTo'];
    pInterestPayOut = json['pInterestPayOut'];
    pInterestType = json['pInterestType'];
    pCompoundType = json['pCompoundType'];
    pInterestRateFrom = json['pInterestRateFrom'];
    pInterestRateTo = json['pInterestRateTo'];
    pMultiplesof = json['pMultiplesof'];
    pValuefor100 = json['pValuefor100'];
    pCaltype = json['pCaltype'];
    if (json['pTenureModesList'] != null) {
      pTenureModesList = <PTenureModesList>[];
      json['pTenureModesList'].forEach((v) {
        pTenureModesList!.add(new PTenureModesList.fromJson(v));
      });
    }
    pRdtabletenure = json['pRdtabletenure'];
    pRdtablematurityamount = json['pRdtablematurityamount'];
    pRdtabledepositamount = json['pRdtabledepositamount'];
    pRdtableinterestamount = json['pRdtableinterestamount'];
    pRdtablepayindenomination = json['pRdtablepayindenomination'];
    pRdtabletenuremode = json['pRdtabletenuremode'];
    pinstallmentpayin = json['pinstallmentpayin'];
    papplicanttype = json['papplicanttype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pRdCalculationmode'] = this.pRdCalculationmode;
    data['pMinInstallmentAmount'] = this.pMinInstallmentAmount;
    data['pMaxInstallmentAmount'] = this.pMaxInstallmentAmount;
    data['pInvestmentPeriodFrom'] = this.pInvestmentPeriodFrom;
    data['pInvestmentPeriodTo'] = this.pInvestmentPeriodTo;
    data['pInterestPayOut'] = this.pInterestPayOut;
    data['pInterestType'] = this.pInterestType;
    data['pCompoundType'] = this.pCompoundType;
    data['pInterestRateFrom'] = this.pInterestRateFrom;
    data['pInterestRateTo'] = this.pInterestRateTo;
    data['pMultiplesof'] = this.pMultiplesof;
    data['pValuefor100'] = this.pValuefor100;
    data['pCaltype'] = this.pCaltype;
    if (this.pTenureModesList != null) {
      data['pTenureModesList'] =
          this.pTenureModesList!.map((v) => v.toJson()).toList();
    }
    data['pRdtabletenure'] = this.pRdtabletenure;
    data['pRdtablematurityamount'] = this.pRdtablematurityamount;
    data['pRdtabledepositamount'] = this.pRdtabledepositamount;
    data['pRdtableinterestamount'] = this.pRdtableinterestamount;
    data['pRdtablepayindenomination'] = this.pRdtablepayindenomination;
    data['pRdtabletenuremode'] = this.pRdtabletenuremode;
    data['pinstallmentpayin'] = this.pinstallmentpayin;
    data['papplicanttype'] = this.papplicanttype;
    return data;
  }
}

class PTenureModesList {
  String? pTenurename;
  dynamic pSortorder;
  dynamic pTenurenature;
  dynamic pPayinduration;

  PTenureModesList(
      {this.pTenurename,
        this.pSortorder,
        this.pTenurenature,
        this.pPayinduration});

  PTenureModesList.fromJson(Map<String, dynamic> json) {
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
}