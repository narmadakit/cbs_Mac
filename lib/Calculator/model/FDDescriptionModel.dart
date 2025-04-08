class FDDescriptionModel {
  String? pFdCalculationmode;
  String? pcompoundinteresttype;
  dynamic pMinDepositAmount;
  dynamic pMaxdepositAmount;
  String? pInvestmentPeriodFrom;
  String? pInvestmentPeriodTo;
  String? pInterestPayOut;
  String? pInterestType;
  dynamic pInterestRateFrom;
  dynamic pInterestRateTo;
  dynamic pMultiplesof;
  dynamic pValuefor100;
  String? pCaltype;
  String? pschemeMaturiytype;
  String? papplicanttype;
  dynamic pschemeunit;
  List<PTenureModesList>? pTenureModesList;
  dynamic pFdtabletenure;
  dynamic pFdtablematurityamount;
  dynamic pFdtabledepositamount;
  dynamic pFdtableinterestamount;
  dynamic pFdtablepayindenomination;
  dynamic pFdtabletenuremode;
  dynamic pstaffcommisionvalue;
  dynamic pstaffmincommisionvalue;
  dynamic pstaffmaxcommisionvalue;
  String? pstaffcommisiontype;
  String? preferralcommissiontype;
  dynamic pcommissionvalue;
  dynamic pmincommissionvalue;
  dynamic pmaxcommissionvalue;

  FDDescriptionModel(
      {this.pFdCalculationmode,
        this.pcompoundinteresttype,
        this.pMinDepositAmount,
        this.pMaxdepositAmount,
        this.pInvestmentPeriodFrom,
        this.pInvestmentPeriodTo,
        this.pInterestPayOut,
        this.pInterestType,
        this.pInterestRateFrom,
        this.pInterestRateTo,
        this.pMultiplesof,
        this.pValuefor100,
        this.pCaltype,
        this.pschemeMaturiytype,
        this.papplicanttype,
        this.pschemeunit,
        this.pTenureModesList,
        this.pFdtabletenure,
        this.pFdtablematurityamount,
        this.pFdtabledepositamount,
        this.pFdtableinterestamount,
        this.pFdtablepayindenomination,
        this.pFdtabletenuremode,
        this.pstaffcommisionvalue,
        this.pstaffmincommisionvalue,
        this.pstaffmaxcommisionvalue,
        this.pstaffcommisiontype,
        this.preferralcommissiontype,
        this.pcommissionvalue,
        this.pmincommissionvalue,
        this.pmaxcommissionvalue});

  FDDescriptionModel.fromJson(Map<String, dynamic> json) {
    pFdCalculationmode = json['pFdCalculationmode'];
    pcompoundinteresttype = json['pcompoundinteresttype'];
    pMinDepositAmount = json['pMinDepositAmount'];
    pMaxdepositAmount = json['pMaxdepositAmount'];
    pInvestmentPeriodFrom = json['pInvestmentPeriodFrom'];
    pInvestmentPeriodTo = json['pInvestmentPeriodTo'];
    pInterestPayOut = json['pInterestPayOut'];
    pInterestType = json['pInterestType'];
    pInterestRateFrom = json['pInterestRateFrom'];
    pInterestRateTo = json['pInterestRateTo'];
    pMultiplesof = json['pMultiplesof'];
    pValuefor100 = json['pValuefor100'];
    pCaltype = json['pCaltype'];
    pschemeMaturiytype = json['pschemeMaturiytype'];
    papplicanttype = json['papplicanttype'];
    pschemeunit = json['pschemeunit'];
    if (json['pTenureModesList'] != null) {
      pTenureModesList = <PTenureModesList>[];
      json['pTenureModesList'].forEach((v) {
        pTenureModesList!.add(new PTenureModesList.fromJson(v));
      });
    }
    pFdtabletenure = json['pFdtabletenure'];
    pFdtablematurityamount = json['pFdtablematurityamount'];
    pFdtabledepositamount = json['pFdtabledepositamount'];
    pFdtableinterestamount = json['pFdtableinterestamount'];
    pFdtablepayindenomination = json['pFdtablepayindenomination'];
    pFdtabletenuremode = json['pFdtabletenuremode'];
    pstaffcommisionvalue = json['pstaffcommisionvalue'];
    pstaffmincommisionvalue = json['pstaffmincommisionvalue'];
    pstaffmaxcommisionvalue = json['pstaffmaxcommisionvalue'];
    pstaffcommisiontype = json['pstaffcommisiontype'];
    preferralcommissiontype = json['preferralcommissiontype'];
    pcommissionvalue = json['pcommissionvalue'];
    pmincommissionvalue = json['pmincommissionvalue'];
    pmaxcommissionvalue = json['pmaxcommissionvalue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pFdCalculationmode'] = this.pFdCalculationmode;
    data['pcompoundinteresttype'] = this.pcompoundinteresttype;
    data['pMinDepositAmount'] = this.pMinDepositAmount;
    data['pMaxdepositAmount'] = this.pMaxdepositAmount;
    data['pInvestmentPeriodFrom'] = this.pInvestmentPeriodFrom;
    data['pInvestmentPeriodTo'] = this.pInvestmentPeriodTo;
    data['pInterestPayOut'] = this.pInterestPayOut;
    data['pInterestType'] = this.pInterestType;
    data['pInterestRateFrom'] = this.pInterestRateFrom;
    data['pInterestRateTo'] = this.pInterestRateTo;
    data['pMultiplesof'] = this.pMultiplesof;
    data['pValuefor100'] = this.pValuefor100;
    data['pCaltype'] = this.pCaltype;
    data['pschemeMaturiytype'] = this.pschemeMaturiytype;
    data['papplicanttype'] = this.papplicanttype;
    data['pschemeunit'] = this.pschemeunit;
    if (this.pTenureModesList != null) {
      data['pTenureModesList'] =
          this.pTenureModesList!.map((v) => v.toJson()).toList();
    }
    data['pFdtabletenure'] = this.pFdtabletenure;
    data['pFdtablematurityamount'] = this.pFdtablematurityamount;
    data['pFdtabledepositamount'] = this.pFdtabledepositamount;
    data['pFdtableinterestamount'] = this.pFdtableinterestamount;
    data['pFdtablepayindenomination'] = this.pFdtablepayindenomination;
    data['pFdtabletenuremode'] = this.pFdtabletenuremode;
    data['pstaffcommisionvalue'] = this.pstaffcommisionvalue;
    data['pstaffmincommisionvalue'] = this.pstaffmincommisionvalue;
    data['pstaffmaxcommisionvalue'] = this.pstaffmaxcommisionvalue;
    data['pstaffcommisiontype'] = this.pstaffcommisiontype;
    data['preferralcommissiontype'] = this.preferralcommissiontype;
    data['pcommissionvalue'] = this.pcommissionvalue;
    data['pmincommissionvalue'] = this.pmincommissionvalue;
    data['pmaxcommissionvalue'] = this.pmaxcommissionvalue;
    return data;
  }
}

class PTenureModesList {
  String? pTenurename;
  int? pSortorder;

  PTenureModesList({this.pTenurename, this.pSortorder});

  PTenureModesList.fromJson(Map<String, dynamic> json) {
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