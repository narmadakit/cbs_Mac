class LoanDataResponse {
  List<Shareslist>? shareslist;
  List<Fdslist>? fdslist;
  List<Rdlist>? rdlist;
  List<Savingslist>? savingslist;
  List<Loanslist>? loanslist;

  LoanDataResponse(
      {this.shareslist,
        this.fdslist,
        this.rdlist,
        this.savingslist,
        this.loanslist});

  LoanDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['shareslist'] != null) {
      shareslist = <Shareslist>[];
      json['shareslist'].forEach((v) {
        shareslist!.add(new Shareslist.fromJson(v));
      });
    }
    if (json['fdslist'] != null) {
      fdslist = <Fdslist>[];
      json['fdslist'].forEach((v) {
        fdslist!.add(new Fdslist.fromJson(v));
      });
    }
    if (json['rdlist'] != null) {
      rdlist = <Rdlist>[];
      json['rdlist'].forEach((v) {
        rdlist!.add(new Rdlist.fromJson(v));
      });
    }
    if (json['savingslist'] != null) {
      savingslist = <Savingslist>[];
      json['savingslist'].forEach((v) {
        savingslist!.add(new Savingslist.fromJson(v));
      });
    }
    if (json['loanslist'] != null) {
      loanslist = <Loanslist>[];
      json['loanslist'].forEach((v) {
        loanslist!.add(new Loanslist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shareslist != null) {
      data['shareslist'] = this.shareslist!.map((v) => v.toJson()).toList();
    }
    if (this.fdslist != null) {
      data['fdslist'] = this.fdslist!.map((v) => v.toJson()).toList();
    }
    if (this.rdlist != null) {
      data['rdlist'] = this.rdlist!.map((v) => v.toJson()).toList();
    }
    if (this.savingslist != null) {
      data['savingslist'] = this.savingslist!.map((v) => v.toJson()).toList();
    }
    if (this.loanslist != null) {
      data['loanslist'] = this.loanslist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shareslist {
  dynamic paccountid;
  String? paccountno;
  dynamic pMemberid;
  dynamic pMembername;
  dynamic pSchemeid;
  dynamic pSchemename;
  dynamic pNoofshares;
  dynamic pSharevalue;
  dynamic pDistictiveNumbers;
  dynamic pTotalAmount;
  String? pShareDate;
  dynamic preferenceNo;
  dynamic papplicantType;
  String? pbranchname;
  dynamic psharesIssueDate;
  dynamic pDISTINCTIVEFROM;
  dynamic pDISTINCTIVETo;
  dynamic accountid;
  dynamic paccountdue;

  Shareslist(
      {this.paccountid,
        this.paccountno,
        this.pMemberid,
        this.pMembername,
        this.pSchemeid,
        this.pSchemename,
        this.pNoofshares,
        this.pSharevalue,
        this.pDistictiveNumbers,
        this.pTotalAmount,
        this.pShareDate,
        this.preferenceNo,
        this.papplicantType,
        this.pbranchname,
        this.psharesIssueDate,
        this.pDISTINCTIVEFROM,
        this.pDISTINCTIVETo,
        this.accountid,
        this.paccountdue
      });

  Shareslist.fromJson(Map<String, dynamic> json) {
    paccountid = json['paccountid'];
    paccountno = json['paccountno'];
    pMemberid = json['pMemberid'];
    pMembername = json['pMembername'];
    pSchemeid = json['pSchemeid'];
    pSchemename = json['pSchemename'];
    pNoofshares = json['pNoofshares'];
    pSharevalue = json['pSharevalue'];
    pDistictiveNumbers = json['pDistictiveNumbers'];
    pTotalAmount = json['pTotalAmount'];
    pShareDate = json['pShareDate'];
    preferenceNo = json['preference_no'];
    papplicantType = json['papplicant_type'];
    pbranchname = json['pbranchname'];
    psharesIssueDate = json['pshares_issue_date'];
    pDISTINCTIVEFROM = json['pDISTINCTIVE_FROM'];
    pDISTINCTIVETo = json['pDISTINCTIVE_to'];
    accountid = json['accountid'];
    paccountdue = json['paccountdue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paccountid'] = this.paccountid;
    data['paccountno'] = this.paccountno;
    data['pMemberid'] = this.pMemberid;
    data['pMembername'] = this.pMembername;
    data['pSchemeid'] = this.pSchemeid;
    data['pSchemename'] = this.pSchemename;
    data['pNoofshares'] = this.pNoofshares;
    data['pSharevalue'] = this.pSharevalue;
    data['pDistictiveNumbers'] = this.pDistictiveNumbers;
    data['pTotalAmount'] = this.pTotalAmount;
    data['pShareDate'] = this.pShareDate;
    data['preference_no'] = this.preferenceNo;
    data['papplicant_type'] = this.papplicantType;
    data['pbranchname'] = this.pbranchname;
    data['pshares_issue_date'] = this.psharesIssueDate;
    data['pDISTINCTIVE_FROM'] = this.pDISTINCTIVEFROM;
    data['pDISTINCTIVE_to'] = this.pDISTINCTIVETo;
    data['accountid'] = this.accountid;
    data['paccountdue'] = this.paccountdue;
    return data;
  }
}

class Fdslist {
  String? pTransDate;
  dynamic pMemberName;
  dynamic pMemberCode;
  dynamic pMemberId;
  dynamic pContactid;
  dynamic pContactrefid;
  dynamic pContacttype;
  dynamic pCreatedby;
  String? pFdAccountNo;
  bool? pBondPrintStatus;
  String? pAccountStatus;
  String? pbranchname;
  dynamic pTokenNo;
  bool? pIsJointMembersapplicable;
  bool? pIsReferralsapplicable;
  bool? pIsNomineesapplicable;
  dynamic pTypeofOperation;
  dynamic pFdAccountId;
  dynamic pChitbranchId;
  dynamic pChitbranchname;
  dynamic pRecceiptNo;
  dynamic pGoldrate;
  dynamic pGramsPerUnit;
  dynamic pMaturitytype;
  dynamic pTotalAvailableUnits;
  dynamic pBondRenewal;
  String? pBondNumber;
  dynamic pMembertypeId;
  dynamic pMemberType;
  dynamic pMemberTypeCode;
  dynamic pApplicantType;
  dynamic fdInterestPayoutList;
  dynamic fdInteresttype;
  dynamic pFdAmount;
  dynamic pMinDepositAmount;
  dynamic pMaxdepositAmount;
  dynamic pInvestmentPeriodFrom;
  dynamic pInvestmentPeriodTo;
  String? pInterestType;
  dynamic pInterestRateFrom;
  dynamic pInterestRateTo;
  dynamic pInterestOrValueForHundred;
  dynamic pInterestTenureMode;
  String? pTenure;
  dynamic pInterestTenure;
  dynamic pInterestAmount;
  dynamic pDepositAmount;
  dynamic pMaturityAmount;
  dynamic pPayinDenomination;
  String? pInterestPayOut;
  dynamic pINTERESTPAYABLE;
  dynamic pCompoundInterestType;
  dynamic pInterestRate;
  String? pDepositDate;
  String? pMaturityDate;
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

  Fdslist(
      {this.pTransDate,
        this.pMemberName,
        this.pMemberCode,
        this.pMemberId,
        this.pContactid,
        this.pContactrefid,
        this.pContacttype,
        this.pCreatedby,
        this.pFdAccountNo,
        this.pBondPrintStatus,
        this.pAccountStatus,
        this.pbranchname,
        this.pTokenNo,
        this.pIsJointMembersapplicable,
        this.pIsReferralsapplicable,
        this.pIsNomineesapplicable,
        this.pTypeofOperation,
        this.pFdAccountId,
        this.pChitbranchId,
        this.pChitbranchname,
        this.pRecceiptNo,
        this.pGoldrate,
        this.pGramsPerUnit,
        this.pMaturitytype,
        this.pTotalAvailableUnits,
        this.pBondRenewal,
        this.pBondNumber,
        this.pMembertypeId,
        this.pMemberType,
        this.pMemberTypeCode,
        this.pApplicantType,
        this.fdInterestPayoutList,
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

  Fdslist.fromJson(Map<String, dynamic> json) {
    pTransDate = json['pTransDate'];
    pMemberName = json['pMemberName'];
    pMemberCode = json['pMemberCode'];
    pMemberId = json['pMemberId'];
    pContactid = json['pContactid'];
    pContactrefid = json['pContactrefid'];
    pContacttype = json['pContacttype'];
    pCreatedby = json['pCreatedby'];
    pFdAccountNo = json['pFdAccountNo'];
    pBondPrintStatus = json['pBondPrintStatus'];
    pAccountStatus = json['pAccountStatus'];
    pbranchname = json['pbranchname'];
    pTokenNo = json['pTokenNo'];
    pIsJointMembersapplicable = json['pIsJointMembersapplicable'];
    pIsReferralsapplicable = json['pIsReferralsapplicable'];
    pIsNomineesapplicable = json['pIsNomineesapplicable'];
    pTypeofOperation = json['pTypeofOperation'];
    pFdAccountId = json['pFdAccountId'];
    pChitbranchId = json['pChitbranchId'];
    pChitbranchname = json['pChitbranchname'];
    pRecceiptNo = json['pRecceiptNo'];
    pGoldrate = json['pGoldrate'];
    pGramsPerUnit = json['pGramsPerUnit'];
    pMaturitytype = json['pMaturitytype'];
    pTotalAvailableUnits = json['pTotalAvailableUnits'];
    pBondRenewal = json['pBondRenewal'];
    pBondNumber = json['pBondNumber'];
    pMembertypeId = json['pMembertypeId'];
    pMemberType = json['pMemberType'];
    pMemberTypeCode = json['pMemberTypeCode'];
    pApplicantType = json['pApplicantType'];
    fdInterestPayoutList = json['fdInterestPayoutList'];
    fdInteresttype = json['fdInteresttype'];
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
    data['pTransDate'] = this.pTransDate;
    data['pMemberName'] = this.pMemberName;
    data['pMemberCode'] = this.pMemberCode;
    data['pMemberId'] = this.pMemberId;
    data['pContactid'] = this.pContactid;
    data['pContactrefid'] = this.pContactrefid;
    data['pContacttype'] = this.pContacttype;
    data['pCreatedby'] = this.pCreatedby;
    data['pFdAccountNo'] = this.pFdAccountNo;
    data['pBondPrintStatus'] = this.pBondPrintStatus;
    data['pAccountStatus'] = this.pAccountStatus;
    data['pbranchname'] = this.pbranchname;
    data['pTokenNo'] = this.pTokenNo;
    data['pIsJointMembersapplicable'] = this.pIsJointMembersapplicable;
    data['pIsReferralsapplicable'] = this.pIsReferralsapplicable;
    data['pIsNomineesapplicable'] = this.pIsNomineesapplicable;
    data['pTypeofOperation'] = this.pTypeofOperation;
    data['pFdAccountId'] = this.pFdAccountId;
    data['pChitbranchId'] = this.pChitbranchId;
    data['pChitbranchname'] = this.pChitbranchname;
    data['pRecceiptNo'] = this.pRecceiptNo;
    data['pGoldrate'] = this.pGoldrate;
    data['pGramsPerUnit'] = this.pGramsPerUnit;
    data['pMaturitytype'] = this.pMaturitytype;
    data['pTotalAvailableUnits'] = this.pTotalAvailableUnits;
    data['pBondRenewal'] = this.pBondRenewal;
    data['pBondNumber'] = this.pBondNumber;
    data['pMembertypeId'] = this.pMembertypeId;
    data['pMemberType'] = this.pMemberType;
    data['pMemberTypeCode'] = this.pMemberTypeCode;
    data['pApplicantType'] = this.pApplicantType;
    data['fdInterestPayoutList'] = this.fdInterestPayoutList;
    data['fdInteresttype'] = this.fdInteresttype;
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

class Rdlist {
  dynamic paccountid;
  String? paccountno;
  dynamic pMemberid;
  dynamic pMembername;
  String? ptransdate;
  String? pcompoundtype;
  dynamic pSchemeid;
  dynamic pSchemename;
  String? pTenure;
  dynamic pTenureType;
  dynamic pInteresttype;
  dynamic pInterestrate;
  dynamic pInstalmentpayin;
  dynamic pInstalmentamount;
  dynamic pDepositamount;
  dynamic pMaturityamount;
  String? pInterestpayable;
  String? pDepositdate;
  String? pMaturitydate;
  String? pInterestpayout;
  String? pAccountstatus;
  String? pbranchname;
  dynamic pinstalmentRatio;
  dynamic pOutstandingAmount;
  dynamic pvirtualaccno;
  dynamic rdReceiptsDTOs;
  dynamic paccountdue;

  Rdlist(
      {this.paccountid,
        this.paccountno,
        this.pMemberid,
        this.pMembername,
        this.ptransdate,
        this.pcompoundtype,
        this.pSchemeid,
        this.pSchemename,
        this.pTenure,
        this.pTenureType,
        this.pInteresttype,
        this.pInterestrate,
        this.pInstalmentpayin,
        this.pInstalmentamount,
        this.pDepositamount,
        this.pMaturityamount,
        this.pInterestpayable,
        this.pDepositdate,
        this.pMaturitydate,
        this.pInterestpayout,
        this.pAccountstatus,
        this.pbranchname,
        this.pinstalmentRatio,
        this.pOutstandingAmount,
        this.pvirtualaccno,
        this.rdReceiptsDTOs,
        this.paccountdue
      });

  Rdlist.fromJson(Map<String, dynamic> json) {
    paccountid = json['paccountid'];
    paccountno = json['paccountno'];
    pMemberid = json['pMemberid'];
    pMembername = json['pMembername'];
    ptransdate = json['ptransdate'];
    pcompoundtype = json['pcompoundtype'];
    pSchemeid = json['pSchemeid'];
    pSchemename = json['pSchemename'];
    pTenure = json['pTenure'];
    pTenureType = json['pTenureType'];
    pInteresttype = json['pInteresttype'];
    pInterestrate = json['pInterestrate'];
    pInstalmentpayin = json['pInstalmentpayin'];
    pInstalmentamount = json['pInstalmentamount'];
    pDepositamount = json['pDepositamount'];
    pMaturityamount = json['pMaturityamount'];
    pInterestpayable = json['pInterestpayable'];
    pDepositdate = json['pDepositdate'];
    pMaturitydate = json['pMaturitydate'];
    pInterestpayout = json['pInterestpayout'];
    pAccountstatus = json['pAccountstatus'];
    pbranchname = json['pbranchname'];
    pinstalmentRatio = json['pinstalment_ratio'];
    pOutstandingAmount = json['pOutstandingAmount'];
    pvirtualaccno = json['pvirtualaccno'];
    rdReceiptsDTOs = json['rdReceiptsDTOs'];
    paccountdue = json['paccountdue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paccountid'] = this.paccountid;
    data['paccountno'] = this.paccountno;
    data['pMemberid'] = this.pMemberid;
    data['pMembername'] = this.pMembername;
    data['ptransdate'] = this.ptransdate;
    data['pcompoundtype'] = this.pcompoundtype;
    data['pSchemeid'] = this.pSchemeid;
    data['pSchemename'] = this.pSchemename;
    data['pTenure'] = this.pTenure;
    data['pTenureType'] = this.pTenureType;
    data['pInteresttype'] = this.pInteresttype;
    data['pInterestrate'] = this.pInterestrate;
    data['pInstalmentpayin'] = this.pInstalmentpayin;
    data['pInstalmentamount'] = this.pInstalmentamount;
    data['pDepositamount'] = this.pDepositamount;
    data['pMaturityamount'] = this.pMaturityamount;
    data['pInterestpayable'] = this.pInterestpayable;
    data['pDepositdate'] = this.pDepositdate;
    data['pMaturitydate'] = this.pMaturitydate;
    data['pInterestpayout'] = this.pInterestpayout;
    data['pAccountstatus'] = this.pAccountstatus;
    data['pbranchname'] = this.pbranchname;
    data['pinstalment_ratio'] = this.pinstalmentRatio;
    data['pOutstandingAmount'] = this.pOutstandingAmount;
    data['pvirtualaccno'] = this.pvirtualaccno;
    data['rdReceiptsDTOs'] = this.rdReceiptsDTOs;
    data['paccountdue'] = this.paccountdue;
    return data;
  }
}

class Savingslist {
  dynamic pSavingaccountid;
  String? pSavingaccountno;
  dynamic pMembertype;
  dynamic pApplicanttype;
  String? pTransdate;
  dynamic pContacttype;
  dynamic pMembername;
  dynamic pSavingaccname;
  dynamic pAccountid;
  dynamic pMemberid;
  dynamic pcontactid;
  dynamic pcontactrefId;
  dynamic pMembercode;
  dynamic ptypeofaccount;
  dynamic paccountbalance;
  dynamic poverdraftlimit;
  dynamic pinterestrate;
  dynamic pContactNo;
  String? poatype;
  String? pinterestpayout;
  String? pAccountstatus;
  String? branchname;
  dynamic paccountdue;

  Savingslist(
      {this.pSavingaccountid,
        this.pSavingaccountno,
        this.pMembertype,
        this.pApplicanttype,
        this.pTransdate,
        this.pContacttype,
        this.pMembername,
        this.pSavingaccname,
        this.pAccountid,
        this.pMemberid,
        this.pcontactid,
        this.pcontactrefId,
        this.pMembercode,
        this.ptypeofaccount,
        this.paccountbalance,
        this.poverdraftlimit,
        this.pinterestrate,
        this.pContactNo,
        this.poatype,
        this.pinterestpayout,
        this.pAccountstatus,
        this.branchname,
        this.paccountdue
      });

  Savingslist.fromJson(Map<String, dynamic> json) {
    pSavingaccountid = json['pSavingaccountid'];
    pSavingaccountno = json['pSavingaccountno'];
    pMembertype = json['pMembertype'];
    pApplicanttype = json['pApplicanttype'];
    pTransdate = json['pTransdate'];
    pContacttype = json['pContacttype'];
    pMembername = json['pMembername'];
    pSavingaccname = json['pSavingaccname'];
    pAccountid = json['pAccountid'];
    pMemberid = json['pMemberid'];
    pcontactid = json['pcontactid'];
    pcontactrefId = json['pcontactref_id'];
    pMembercode = json['pMembercode'];
    ptypeofaccount = json['ptypeofaccount'];
    paccountbalance = json['paccountbalance'];
    poverdraftlimit = json['poverdraftlimit'];
    pinterestrate = json['pinterestrate'];
    pContactNo = json['pContactNo'];
    poatype = json['poatype'];
    pinterestpayout = json['pinterestpayout'];
    pAccountstatus = json['pAccountstatus'];
    branchname = json['branchname'];
    paccountdue = json['paccountdue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pSavingaccountid'] = this.pSavingaccountid;
    data['pSavingaccountno'] = this.pSavingaccountno;
    data['pMembertype'] = this.pMembertype;
    data['pApplicanttype'] = this.pApplicanttype;
    data['pTransdate'] = this.pTransdate;
    data['pContacttype'] = this.pContacttype;
    data['pMembername'] = this.pMembername;
    data['pSavingaccname'] = this.pSavingaccname;
    data['pAccountid'] = this.pAccountid;
    data['pMemberid'] = this.pMemberid;
    data['pcontactid'] = this.pcontactid;
    data['pcontactref_id'] = this.pcontactrefId;
    data['pMembercode'] = this.pMembercode;
    data['ptypeofaccount'] = this.ptypeofaccount;
    data['paccountbalance'] = this.paccountbalance;
    data['poverdraftlimit'] = this.poverdraftlimit;
    data['pinterestrate'] = this.pinterestrate;
    data['pContactNo'] = this.pContactNo;
    data['poatype'] = this.poatype;
    data['pinterestpayout'] = this.pinterestpayout;
    data['pAccountstatus'] = this.pAccountstatus;
    data['branchname'] = this.branchname;
    data['paccountdue'] = this.paccountdue;
    return data;
  }
}

class Loanslist {
  dynamic disburseChargeDTO;
  dynamic pafterdeductadisburseamt;
  dynamic ploansanctionamount;
  dynamic pbrokeninterestamount;
  dynamic padvanceemiamount;
  dynamic pprocessingfees;
  dynamic pbalancetransfortoexitingloan;
  dynamic pdisbursementpayinmode;
  dynamic pmoratoriumcount;
  dynamic pinstalmentinterest;
  dynamic pinterestmode;
  dynamic pmoratoriumstartdate;
  dynamic pmoratoriumenddate;
  dynamic pbusinessentityemailid;
  dynamic pdisbursementtype;
  dynamic pBeneficiaryBank;
  dynamic pBeneficiaryBranch;
  dynamic pBeneficiaryAccountno;
  dynamic pBeneficiaryAccountName;
  dynamic pBeneficiaryIFSCcode;
  bool? pBeneficiaryisprimary;
  dynamic ppaymentdate;
  dynamic ptotalpaidamount;
  dynamic ppreviousdisburse;
  dynamic ppendingdisburse;
  dynamic pbankname;
  String? pbranchname;
  String? ploanstatus;
  dynamic ptypeofpayment;
  dynamic pchequenumber;
  dynamic pInstallmentstartdate;
  dynamic pInstallmentenddate;
  String? pVchapplicationID;
  dynamic pApplicantname;
  dynamic pApplicantState;
  dynamic pApplicantdistrict;
  dynamic pApplicantcity;
  dynamic pApplicantpincode;
  String? pApprovedDate;
  dynamic pLoantypeandCode;
  String? pLoanname;
  dynamic pApplicationdate;
  dynamic pApprovedloanamount;
  dynamic pRequestedamount;
  dynamic pDisbursalamount;
  dynamic pTotalDisbursalamount;
  dynamic pModeofpayment;
  dynamic pTenureofloan;
  String? pLoanpayin;
  String? pInteresttype;
  dynamic pInstallmentamount;
  String? pLoantype;
  dynamic pApplicantMobileNo;
  dynamic pApplicationId;
  dynamic pInterestRate;
  dynamic pApplicantEmail;
  dynamic pDownpayment;
  dynamic pVoucherno;
  dynamic pApplicantId;
  dynamic pDisbursedDate;
  dynamic pDisbursedby;
  dynamic pdateofapplication;
  dynamic pnextduedate;
  dynamic ploancloseddate;
  dynamic pApplicantaddress1;
  dynamic pTitlename;
  dynamic prequestid;
  dynamic pcountry;
  dynamic pApplicantaddress2;
  dynamic vchapplicationId;
  dynamic ptenure;
  dynamic lstDisbursementCharge;
  dynamic tbltranstopuploandata;
  dynamic disbursementsummarydetails;
  dynamic modifiedby;
  dynamic pCreatedby;
  dynamic pModifiedby;
  dynamic pStatusid;
  dynamic pformaccess;
  dynamic pStatusname;
  dynamic pEffectfromdate;
  dynamic pEffecttodate;
  dynamic ptypeofoperation;
  dynamic pipaddress;
  dynamic pactivitytype;
  dynamic currencyformat;
  dynamic dateformat;
  dynamic schemaname;
  dynamic preleasetype;
  dynamic pbranchid;
  dynamic paccountdue;
  bool? isVisibleDetails = false;

  Loanslist(
      {this.disburseChargeDTO,
        this.pafterdeductadisburseamt,
        this.ploansanctionamount,
        this.pbrokeninterestamount,
        this.padvanceemiamount,
        this.pprocessingfees,
        this.pbalancetransfortoexitingloan,
        this.pdisbursementpayinmode,
        this.pmoratoriumcount,
        this.pinstalmentinterest,
        this.pinterestmode,
        this.pmoratoriumstartdate,
        this.pmoratoriumenddate,
        this.pbusinessentityemailid,
        this.pdisbursementtype,
        this.pBeneficiaryBank,
        this.pBeneficiaryBranch,
        this.pBeneficiaryAccountno,
        this.pBeneficiaryAccountName,
        this.pBeneficiaryIFSCcode,
        this.pBeneficiaryisprimary,
        this.ppaymentdate,
        this.ptotalpaidamount,
        this.ppreviousdisburse,
        this.ppendingdisburse,
        this.pbankname,
        this.pbranchname,
        this.ploanstatus,
        this.ptypeofpayment,
        this.pchequenumber,
        this.pInstallmentstartdate,
        this.pInstallmentenddate,
        this.pVchapplicationID,
        this.pApplicantname,
        this.pApplicantState,
        this.pApplicantdistrict,
        this.pApplicantcity,
        this.pApplicantpincode,
        this.pApprovedDate,
        this.pLoantypeandCode,
        this.pLoanname,
        this.pApplicationdate,
        this.pApprovedloanamount,
        this.pRequestedamount,
        this.pDisbursalamount,
        this.pTotalDisbursalamount,
        this.pModeofpayment,
        this.pTenureofloan,
        this.pLoanpayin,
        this.pInteresttype,
        this.pInstallmentamount,
        this.pLoantype,
        this.pApplicantMobileNo,
        this.pApplicationId,
        this.pInterestRate,
        this.pApplicantEmail,
        this.pDownpayment,
        this.pVoucherno,
        this.pApplicantId,
        this.pDisbursedDate,
        this.pDisbursedby,
        this.pdateofapplication,
        this.pnextduedate,
        this.ploancloseddate,
        this.pApplicantaddress1,
        this.pTitlename,
        this.prequestid,
        this.pcountry,
        this.pApplicantaddress2,
        this.vchapplicationId,
        this.ptenure,
        this.lstDisbursementCharge,
        this.tbltranstopuploandata,
        this.disbursementsummarydetails,
        this.modifiedby,
        this.pCreatedby,
        this.pModifiedby,
        this.pStatusid,
        this.pformaccess,
        this.pStatusname,
        this.pEffectfromdate,
        this.pEffecttodate,
        this.ptypeofoperation,
        this.pipaddress,
        this.pactivitytype,
        this.currencyformat,
        this.dateformat,
        this.schemaname,
        this.preleasetype,
        this.pbranchid,
        this.paccountdue,
        this.isVisibleDetails

      });

  Loanslist.fromJson(Map<String, dynamic> json) {
    disburseChargeDTO = json['disburseChargeDTO'];
    pafterdeductadisburseamt = json['pafterdeductadisburseamt'];
    ploansanctionamount = json['ploansanctionamount'];
    pbrokeninterestamount = json['pbrokeninterestamount'];
    padvanceemiamount = json['padvanceemiamount'];
    pprocessingfees = json['pprocessingfees'];
    pbalancetransfortoexitingloan = json['pbalancetransfortoexitingloan'];
    pdisbursementpayinmode = json['pdisbursementpayinmode'];
    pmoratoriumcount = json['pmoratoriumcount'];
    pinstalmentinterest = json['pinstalmentinterest'];
    pinterestmode = json['pinterestmode'];
    pmoratoriumstartdate = json['pmoratoriumstartdate'];
    pmoratoriumenddate = json['pmoratoriumenddate'];
    pbusinessentityemailid = json['pbusinessentityemailid'];
    pdisbursementtype = json['pdisbursementtype'];
    pBeneficiaryBank = json['pBeneficiaryBank'];
    pBeneficiaryBranch = json['pBeneficiaryBranch'];
    pBeneficiaryAccountno = json['pBeneficiaryAccountno'];
    pBeneficiaryAccountName = json['pBeneficiaryAccountName'];
    pBeneficiaryIFSCcode = json['pBeneficiaryIFSCcode'];
    pBeneficiaryisprimary = json['pBeneficiaryisprimary'];
    ppaymentdate = json['ppaymentdate'];
    ptotalpaidamount = json['ptotalpaidamount'];
    ppreviousdisburse = json['ppreviousdisburse'];
    ppendingdisburse = json['ppendingdisburse'];
    pbankname = json['pbankname'];
    pbranchname = json['pbranchname'];
    ploanstatus = json['ploanstatus'];
    ptypeofpayment = json['ptypeofpayment'];
    pchequenumber = json['pchequenumber'];
    pInstallmentstartdate = json['pInstallmentstartdate'];
    pInstallmentenddate = json['pInstallmentenddate'];
    pVchapplicationID = json['pVchapplicationID'];
    pApplicantname = json['pApplicantname'];
    pApplicantState = json['pApplicantState'];
    pApplicantdistrict = json['pApplicantdistrict'];
    pApplicantcity = json['pApplicantcity'];
    pApplicantpincode = json['pApplicantpincode'];
    pApprovedDate = json['pApprovedDate'];
    pLoantypeandCode = json['pLoantypeandCode'];
    pLoanname = json['pLoanname'];
    pApplicationdate = json['pApplicationdate'];
    pApprovedloanamount = json['pApprovedloanamount'];
    pRequestedamount = json['pRequestedamount'];
    pDisbursalamount = json['pDisbursalamount'];
    pTotalDisbursalamount = json['pTotalDisbursalamount'];
    pModeofpayment = json['pModeofpayment'];
    pTenureofloan = json['pTenureofloan'];
    pLoanpayin = json['pLoanpayin'];
    pInteresttype = json['pInteresttype'];
    pInstallmentamount = json['pInstallmentamount'];
    pLoantype = json['pLoantype'];
    pApplicantMobileNo = json['pApplicantMobileNo'];
    pApplicationId = json['pApplicationId'];
    pInterestRate = json['pInterestRate'];
    pApplicantEmail = json['pApplicantEmail'];
    pDownpayment = json['pDownpayment'];
    pVoucherno = json['pVoucherno'];
    pApplicantId = json['pApplicantId'];
    pDisbursedDate = json['pDisbursedDate'];
    pDisbursedby = json['pDisbursedby'];
    pdateofapplication = json['pdateofapplication'];
    pnextduedate = json['pnextduedate'];
    ploancloseddate = json['ploancloseddate'];
    pApplicantaddress1 = json['pApplicantaddress1'];
    pTitlename = json['pTitlename'];
    prequestid = json['prequestid'];
    pcountry = json['pcountry'];
    pApplicantaddress2 = json['pApplicantaddress2'];
    vchapplicationId = json['vchapplicationId'];
    ptenure = json['ptenure'];
    lstDisbursementCharge = json['lstDisbursementCharge'];
    tbltranstopuploandata = json['tbltranstopuploandata'];
    disbursementsummarydetails = json['disbursementsummarydetails'];
    modifiedby = json['modifiedby'];
    pCreatedby = json['pCreatedby'];
    pModifiedby = json['pModifiedby'];
    pStatusid = json['pStatusid'];
    pformaccess = json['pformaccess'];
    pStatusname = json['pStatusname'];
    pEffectfromdate = json['pEffectfromdate'];
    pEffecttodate = json['pEffecttodate'];
    ptypeofoperation = json['ptypeofoperation'];
    pipaddress = json['pipaddress'];
    pactivitytype = json['pactivitytype'];
    currencyformat = json['currencyformat'];
    dateformat = json['dateformat'];
    schemaname = json['schemaname'];
    preleasetype = json['preleasetype'];
    pbranchid = json['pbranchid'];
    paccountdue = json['paccountdue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disburseChargeDTO'] = this.disburseChargeDTO;
    data['pafterdeductadisburseamt'] = this.pafterdeductadisburseamt;
    data['ploansanctionamount'] = this.ploansanctionamount;
    data['pbrokeninterestamount'] = this.pbrokeninterestamount;
    data['padvanceemiamount'] = this.padvanceemiamount;
    data['pprocessingfees'] = this.pprocessingfees;
    data['pbalancetransfortoexitingloan'] = this.pbalancetransfortoexitingloan;
    data['pdisbursementpayinmode'] = this.pdisbursementpayinmode;
    data['pmoratoriumcount'] = this.pmoratoriumcount;
    data['pinstalmentinterest'] = this.pinstalmentinterest;
    data['pinterestmode'] = this.pinterestmode;
    data['pmoratoriumstartdate'] = this.pmoratoriumstartdate;
    data['pmoratoriumenddate'] = this.pmoratoriumenddate;
    data['pbusinessentityemailid'] = this.pbusinessentityemailid;
    data['pdisbursementtype'] = this.pdisbursementtype;
    data['pBeneficiaryBank'] = this.pBeneficiaryBank;
    data['pBeneficiaryBranch'] = this.pBeneficiaryBranch;
    data['pBeneficiaryAccountno'] = this.pBeneficiaryAccountno;
    data['pBeneficiaryAccountName'] = this.pBeneficiaryAccountName;
    data['pBeneficiaryIFSCcode'] = this.pBeneficiaryIFSCcode;
    data['pBeneficiaryisprimary'] = this.pBeneficiaryisprimary;
    data['ppaymentdate'] = this.ppaymentdate;
    data['ptotalpaidamount'] = this.ptotalpaidamount;
    data['ppreviousdisburse'] = this.ppreviousdisburse;
    data['ppendingdisburse'] = this.ppendingdisburse;
    data['pbankname'] = this.pbankname;
    data['pbranchname'] = this.pbranchname;
    data['ploanstatus'] = this.ploanstatus;
    data['ptypeofpayment'] = this.ptypeofpayment;
    data['pchequenumber'] = this.pchequenumber;
    data['pInstallmentstartdate'] = this.pInstallmentstartdate;
    data['pInstallmentenddate'] = this.pInstallmentenddate;
    data['pVchapplicationID'] = this.pVchapplicationID;
    data['pApplicantname'] = this.pApplicantname;
    data['pApplicantState'] = this.pApplicantState;
    data['pApplicantdistrict'] = this.pApplicantdistrict;
    data['pApplicantcity'] = this.pApplicantcity;
    data['pApplicantpincode'] = this.pApplicantpincode;
    data['pApprovedDate'] = this.pApprovedDate;
    data['pLoantypeandCode'] = this.pLoantypeandCode;
    data['pLoanname'] = this.pLoanname;
    data['pApplicationdate'] = this.pApplicationdate;
    data['pApprovedloanamount'] = this.pApprovedloanamount;
    data['pRequestedamount'] = this.pRequestedamount;
    data['pDisbursalamount'] = this.pDisbursalamount;
    data['pTotalDisbursalamount'] = this.pTotalDisbursalamount;
    data['pModeofpayment'] = this.pModeofpayment;
    data['pTenureofloan'] = this.pTenureofloan;
    data['pLoanpayin'] = this.pLoanpayin;
    data['pInteresttype'] = this.pInteresttype;
    data['pInstallmentamount'] = this.pInstallmentamount;
    data['pLoantype'] = this.pLoantype;
    data['pApplicantMobileNo'] = this.pApplicantMobileNo;
    data['pApplicationId'] = this.pApplicationId;
    data['pInterestRate'] = this.pInterestRate;
    data['pApplicantEmail'] = this.pApplicantEmail;
    data['pDownpayment'] = this.pDownpayment;
    data['pVoucherno'] = this.pVoucherno;
    data['pApplicantId'] = this.pApplicantId;
    data['pDisbursedDate'] = this.pDisbursedDate;
    data['pDisbursedby'] = this.pDisbursedby;
    data['pdateofapplication'] = this.pdateofapplication;
    data['pnextduedate'] = this.pnextduedate;
    data['ploancloseddate'] = this.ploancloseddate;
    data['pApplicantaddress1'] = this.pApplicantaddress1;
    data['pTitlename'] = this.pTitlename;
    data['prequestid'] = this.prequestid;
    data['pcountry'] = this.pcountry;
    data['pApplicantaddress2'] = this.pApplicantaddress2;
    data['vchapplicationId'] = this.vchapplicationId;
    data['ptenure'] = this.ptenure;
    data['lstDisbursementCharge'] = this.lstDisbursementCharge;
    data['tbltranstopuploandata'] = this.tbltranstopuploandata;
    data['disbursementsummarydetails'] = this.disbursementsummarydetails;
    data['modifiedby'] = this.modifiedby;
    data['pCreatedby'] = this.pCreatedby;
    data['pModifiedby'] = this.pModifiedby;
    data['pStatusid'] = this.pStatusid;
    data['pformaccess'] = this.pformaccess;
    data['pStatusname'] = this.pStatusname;
    data['pEffectfromdate'] = this.pEffectfromdate;
    data['pEffecttodate'] = this.pEffecttodate;
    data['ptypeofoperation'] = this.ptypeofoperation;
    data['pipaddress'] = this.pipaddress;
    data['pactivitytype'] = this.pactivitytype;
    data['currencyformat'] = this.currencyformat;
    data['dateformat'] = this.dateformat;
    data['schemaname'] = this.schemaname;
    data['preleasetype'] = this.preleasetype;
    data['pbranchid'] = this.pbranchid;
    data['paccountdue'] = this.paccountdue;
    return data;
  }
}