class FinalLoanViewModel {
  dynamic pemitype;
  dynamic pstatementstatus;
  dynamic preceiptid;
  String? sectionName;
  dynamic psubsectionname;
  bool? isfilenoexits;
  dynamic pVerificationoperation;
  dynamic isVerified;
  dynamic lstCreditscoreDetailsDTO;
  dynamic lstKYCDcumentsDetailsDTO;
  dynamic lstsurityapplicantsDTO;
  List<LstInstalmentsgenerationDTO>? lstInstalmentsgenerationDTO;
  dynamic fiTabFdRdDetailsDTO;
  dynamic papplicationid;
  dynamic pVchapplicationid;
  dynamic pDateofapplication;
  dynamic pDateofDisbursement;
  dynamic pApplicantid;
  dynamic pContactreferenceid;
  dynamic ploanucic;
  dynamic pApplicantname;
  dynamic pContacttype;
  dynamic pLoantypeid;
  dynamic pLoantype;
  dynamic pLoanid;
  dynamic pLoanname;
  dynamic pLoanType;
  dynamic pApplicanttype;
  bool? pIsschemesapplicable;
  dynamic pSchemename;
  dynamic pSchemecode;
  dynamic pAmountrequested;
  dynamic papprovedloanamount;
  dynamic papprovedinstamamt;
  dynamic pappROI;
  dynamic pappTenure;
  dynamic pPurposeofloan;
  dynamic pLoanpayin;
  dynamic pInteresttype;
  dynamic pRateofinterest;
  dynamic pTenureofloan;
  dynamic pTenuretype;
  dynamic pLoaninstalmentpaymentmode;
  dynamic pPartprinciplepaidinterval;
  dynamic pInstalmentamount;
  dynamic pVchapplicantstatus;
  bool? pIssurietypersonsapplicable;
  bool? pIsKYCapplicable;
  bool? pIspersonaldetailsapplicable;
  bool? pIssecurityandcolletralapplicable;
  bool? pIsexistingloansapplicable;
  bool? pIsreferencesapplicable;
  bool? pIsreferralapplicable;
  dynamic pReferralname;
  dynamic preferralcontactrefid;
  dynamic pSalespersonname;
  dynamic psalespersoncontactrefid;
  dynamic pschemeid;
  dynamic pFIVerifierscomments;
  dynamic pFIVerifiersrating;
  dynamic pverificationdate;
  dynamic pverificationtime;
  dynamic pVerifierName;
  dynamic papprovaldate;
  dynamic pfirstdisbursementdate;
  dynamic ploancloseddate;
  dynamic pstatusname;
  dynamic pNextEmiDate;
  dynamic pOverdueAmount;
  dynamic plastdisbursementdate;
  dynamic ptotaldisburseamount;
  dynamic ploanstartddate;
  dynamic pinstalmentprinciple;
  dynamic pinstalmentinterest;
  dynamic pactualpenalty;
  dynamic ppaidprinciple;
  dynamic ppaidinterest;
  dynamic ppaidpenalty;
  dynamic pwaiveofpenalty;
  dynamic pprincipledue;
  dynamic pinterestdue;
  dynamic ppenaltydue;
  dynamic pfutureprincipledue;
  dynamic pfutureinterestdue;
  dynamic ptotaldueamount;
  dynamic ptotalpaidamount;
  dynamic leadid;
  dynamic paccountid;
  dynamic paccountno;
  dynamic pconfigid;
  dynamic pconfigname;
  dynamic ptransdate;
  dynamic pmemberid;
  dynamic pmembername;
  dynamic pdepositamount;
  dynamic pmaturityamount;
  dynamic pdepositdate;
  dynamic pmaturitydate;
  dynamic ploanpercentage;
  dynamic peligibleamount;
  dynamic pstatus;
  dynamic pStatusid;
  dynamic pcreatedby;
  dynamic pcreateddate;
  dynamic pGroupId;
  dynamic pGroupName;
  dynamic pbranchName;
  dynamic pBranchId;
  dynamic modifiedby;
  dynamic pCreatedby;
  dynamic pModifiedby;
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

  FinalLoanViewModel(
      {this.pemitype,
        this.pstatementstatus,
        this.preceiptid,
        this.sectionName,
        this.psubsectionname,
        this.isfilenoexits,
        this.pVerificationoperation,
        this.isVerified,
        this.lstCreditscoreDetailsDTO,
        this.lstKYCDcumentsDetailsDTO,
        this.lstsurityapplicantsDTO,
        this.lstInstalmentsgenerationDTO,
        this.fiTabFdRdDetailsDTO,
        this.papplicationid,
        this.pVchapplicationid,
        this.pDateofapplication,
        this.pDateofDisbursement,
        this.pApplicantid,
        this.pContactreferenceid,
        this.ploanucic,
        this.pApplicantname,
        this.pContacttype,
        this.pLoantypeid,
        this.pLoantype,
        this.pLoanid,
        this.pLoanname,
        this.pLoanType,
        this.pApplicanttype,
        this.pIsschemesapplicable,
        this.pSchemename,
        this.pSchemecode,
        this.pAmountrequested,
        this.papprovedloanamount,
        this.papprovedinstamamt,
        this.pappROI,
        this.pappTenure,
        this.pPurposeofloan,
        this.pLoanpayin,
        this.pInteresttype,
        this.pRateofinterest,
        this.pTenureofloan,
        this.pTenuretype,
        this.pLoaninstalmentpaymentmode,
        this.pPartprinciplepaidinterval,
        this.pInstalmentamount,
        this.pVchapplicantstatus,
        this.pIssurietypersonsapplicable,
        this.pIsKYCapplicable,
        this.pIspersonaldetailsapplicable,
        this.pIssecurityandcolletralapplicable,
        this.pIsexistingloansapplicable,
        this.pIsreferencesapplicable,
        this.pIsreferralapplicable,
        this.pReferralname,
        this.preferralcontactrefid,
        this.pSalespersonname,
        this.psalespersoncontactrefid,
        this.pschemeid,
        this.pFIVerifierscomments,
        this.pFIVerifiersrating,
        this.pverificationdate,
        this.pverificationtime,
        this.pVerifierName,
        this.papprovaldate,
        this.pfirstdisbursementdate,
        this.ploancloseddate,
        this.pstatusname,
        this.pNextEmiDate,
        this.pOverdueAmount,
        this.plastdisbursementdate,
        this.ptotaldisburseamount,
        this.ploanstartddate,
        this.pinstalmentprinciple,
        this.pinstalmentinterest,
        this.pactualpenalty,
        this.ppaidprinciple,
        this.ppaidinterest,
        this.ppaidpenalty,
        this.pwaiveofpenalty,
        this.pprincipledue,
        this.pinterestdue,
        this.ppenaltydue,
        this.pfutureprincipledue,
        this.pfutureinterestdue,
        this.ptotaldueamount,
        this.ptotalpaidamount,
        this.leadid,
        this.paccountid,
        this.paccountno,
        this.pconfigid,
        this.pconfigname,
        this.ptransdate,
        this.pmemberid,
        this.pmembername,
        this.pdepositamount,
        this.pmaturityamount,
        this.pdepositdate,
        this.pmaturitydate,
        this.ploanpercentage,
        this.peligibleamount,
        this.pstatus,
        this.pStatusid,
        this.pcreatedby,
        this.pcreateddate,
        this.pGroupId,
        this.pGroupName,
        this.pbranchName,
        this.pBranchId,
        this.modifiedby,
        this.pCreatedby,
        this.pModifiedby,
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
        this.pbranchid});

  FinalLoanViewModel.fromJson(Map<String, dynamic> json) {
    pemitype = json['pemitype'];
    pstatementstatus = json['pstatementstatus'];
    preceiptid = json['preceiptid'];
    sectionName = json['sectionName'];
    psubsectionname = json['psubsectionname'];
    isfilenoexits = json['isfilenoexits'];
    pVerificationoperation = json['pVerificationoperation'];
    isVerified = json['isVerified'];
    lstCreditscoreDetailsDTO = json['lstCreditscoreDetailsDTO'];
    lstKYCDcumentsDetailsDTO = json['lstKYCDcumentsDetailsDTO'];
    lstsurityapplicantsDTO = json['lstsurityapplicantsDTO'];
    if (json['lstInstalmentsgenerationDTO'] != null) {
      lstInstalmentsgenerationDTO = <LstInstalmentsgenerationDTO>[];
      json['lstInstalmentsgenerationDTO'].forEach((v) {
        lstInstalmentsgenerationDTO!
            .add(new LstInstalmentsgenerationDTO.fromJson(v));
      });
    }
    fiTabFdRdDetailsDTO = json['fiTabFdRdDetailsDTO'];
    papplicationid = json['papplicationid'];
    pVchapplicationid = json['pVchapplicationid'];
    pDateofapplication = json['pDateofapplication'];
    pDateofDisbursement = json['pDateofDisbursement'];
    pApplicantid = json['pApplicantid'];
    pContactreferenceid = json['pContactreferenceid'];
    ploanucic = json['ploanucic'];
    pApplicantname = json['pApplicantname'];
    pContacttype = json['pContacttype'];
    pLoantypeid = json['pLoantypeid'];
    pLoantype = json['pLoantype'];
    pLoanid = json['pLoanid'];
    pLoanname = json['pLoanname'];
    pLoanType = json['pLoanType'];
    pApplicanttype = json['pApplicanttype'];
    pIsschemesapplicable = json['pIsschemesapplicable'];
    pSchemename = json['pSchemename'];
    pSchemecode = json['pSchemecode'];
    pAmountrequested = json['pAmountrequested'];
    papprovedloanamount = json['papprovedloanamount'];
    papprovedinstamamt = json['papprovedinstamamt'];
    pappROI = json['pappROI'];
    pappTenure = json['pappTenure'];
    pPurposeofloan = json['pPurposeofloan'];
    pLoanpayin = json['pLoanpayin'];
    pInteresttype = json['pInteresttype'];
    pRateofinterest = json['pRateofinterest'];
    pTenureofloan = json['pTenureofloan'];
    pTenuretype = json['pTenuretype'];
    pLoaninstalmentpaymentmode = json['pLoaninstalmentpaymentmode'];
    pPartprinciplepaidinterval = json['pPartprinciplepaidinterval'];
    pInstalmentamount = json['pInstalmentamount'];
    pVchapplicantstatus = json['pVchapplicantstatus'];
    pIssurietypersonsapplicable = json['pIssurietypersonsapplicable'];
    pIsKYCapplicable = json['pIsKYCapplicable'];
    pIspersonaldetailsapplicable = json['pIspersonaldetailsapplicable'];
    pIssecurityandcolletralapplicable =
    json['pIssecurityandcolletralapplicable'];
    pIsexistingloansapplicable = json['pIsexistingloansapplicable'];
    pIsreferencesapplicable = json['pIsreferencesapplicable'];
    pIsreferralapplicable = json['pIsreferralapplicable'];
    pReferralname = json['pReferralname'];
    preferralcontactrefid = json['preferralcontactrefid'];
    pSalespersonname = json['pSalespersonname'];
    psalespersoncontactrefid = json['psalespersoncontactrefid'];
    pschemeid = json['pschemeid'];
    pFIVerifierscomments = json['pFIVerifierscomments'];
    pFIVerifiersrating = json['pFIVerifiersrating'];
    pverificationdate = json['pverificationdate'];
    pverificationtime = json['pverificationtime'];
    pVerifierName = json['pVerifierName'];
    papprovaldate = json['papprovaldate'];
    pfirstdisbursementdate = json['pfirstdisbursementdate'];
    ploancloseddate = json['ploancloseddate'];
    pstatusname = json['pstatusname'];
    pNextEmiDate = json['pNextEmiDate'];
    pOverdueAmount = json['pOverdueAmount'];
    plastdisbursementdate = json['plastdisbursementdate'];
    ptotaldisburseamount = json['ptotaldisburseamount'];
    ploanstartddate = json['ploanstartddate'];
    pinstalmentprinciple = json['pinstalmentprinciple'];
    pinstalmentinterest = json['pinstalmentinterest'];
    pactualpenalty = json['pactualpenalty'];
    ppaidprinciple = json['ppaidprinciple'];
    ppaidinterest = json['ppaidinterest'];
    ppaidpenalty = json['ppaidpenalty'];
    pwaiveofpenalty = json['pwaiveofpenalty'];
    pprincipledue = json['pprincipledue'];
    pinterestdue = json['pinterestdue'];
    ppenaltydue = json['ppenaltydue'];
    pfutureprincipledue = json['pfutureprincipledue'];
    pfutureinterestdue = json['pfutureinterestdue'];
    ptotaldueamount = json['ptotaldueamount'];
    ptotalpaidamount = json['ptotalpaidamount'];
    leadid = json['leadid'];
    paccountid = json['paccountid'];
    paccountno = json['paccountno'];
    pconfigid = json['pconfigid'];
    pconfigname = json['pconfigname'];
    ptransdate = json['ptransdate'];
    pmemberid = json['pmemberid'];
    pmembername = json['pmembername'];
    pdepositamount = json['pdepositamount'];
    pmaturityamount = json['pmaturityamount'];
    pdepositdate = json['pdepositdate'];
    pmaturitydate = json['pmaturitydate'];
    ploanpercentage = json['ploanpercentage'];
    peligibleamount = json['peligibleamount'];
    pstatus = json['pstatus'];
    pStatusid = json['pStatusid'];
    pcreatedby = json['pcreatedby'];
    pcreateddate = json['pcreateddate'];
    pGroupId = json['pGroupId'];
    pGroupName = json['pGroupName'];
    pbranchName = json['pbranchName'];
    pBranchId = json['pBranchId'];
    modifiedby = json['modifiedby'];
    pCreatedby = json['pCreatedby'];
    pModifiedby = json['pModifiedby'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pemitype'] = this.pemitype;
    data['pstatementstatus'] = this.pstatementstatus;
    data['preceiptid'] = this.preceiptid;
    data['sectionName'] = this.sectionName;
    data['psubsectionname'] = this.psubsectionname;
    data['isfilenoexits'] = this.isfilenoexits;
    data['pVerificationoperation'] = this.pVerificationoperation;
    data['isVerified'] = this.isVerified;
    data['lstCreditscoreDetailsDTO'] = this.lstCreditscoreDetailsDTO;
    data['lstKYCDcumentsDetailsDTO'] = this.lstKYCDcumentsDetailsDTO;
    data['lstsurityapplicantsDTO'] = this.lstsurityapplicantsDTO;
    if (this.lstInstalmentsgenerationDTO != null) {
      data['lstInstalmentsgenerationDTO'] =
          this.lstInstalmentsgenerationDTO!.map((v) => v.toJson()).toList();
    }
    data['fiTabFdRdDetailsDTO'] = this.fiTabFdRdDetailsDTO;
    data['papplicationid'] = this.papplicationid;
    data['pVchapplicationid'] = this.pVchapplicationid;
    data['pDateofapplication'] = this.pDateofapplication;
    data['pDateofDisbursement'] = this.pDateofDisbursement;
    data['pApplicantid'] = this.pApplicantid;
    data['pContactreferenceid'] = this.pContactreferenceid;
    data['ploanucic'] = this.ploanucic;
    data['pApplicantname'] = this.pApplicantname;
    data['pContacttype'] = this.pContacttype;
    data['pLoantypeid'] = this.pLoantypeid;
    data['pLoantype'] = this.pLoantype;
    data['pLoanid'] = this.pLoanid;
    data['pLoanname'] = this.pLoanname;
    data['pLoanType'] = this.pLoanType;
    data['pApplicanttype'] = this.pApplicanttype;
    data['pIsschemesapplicable'] = this.pIsschemesapplicable;
    data['pSchemename'] = this.pSchemename;
    data['pSchemecode'] = this.pSchemecode;
    data['pAmountrequested'] = this.pAmountrequested;
    data['papprovedloanamount'] = this.papprovedloanamount;
    data['papprovedinstamamt'] = this.papprovedinstamamt;
    data['pappROI'] = this.pappROI;
    data['pappTenure'] = this.pappTenure;
    data['pPurposeofloan'] = this.pPurposeofloan;
    data['pLoanpayin'] = this.pLoanpayin;
    data['pInteresttype'] = this.pInteresttype;
    data['pRateofinterest'] = this.pRateofinterest;
    data['pTenureofloan'] = this.pTenureofloan;
    data['pTenuretype'] = this.pTenuretype;
    data['pLoaninstalmentpaymentmode'] = this.pLoaninstalmentpaymentmode;
    data['pPartprinciplepaidinterval'] = this.pPartprinciplepaidinterval;
    data['pInstalmentamount'] = this.pInstalmentamount;
    data['pVchapplicantstatus'] = this.pVchapplicantstatus;
    data['pIssurietypersonsapplicable'] = this.pIssurietypersonsapplicable;
    data['pIsKYCapplicable'] = this.pIsKYCapplicable;
    data['pIspersonaldetailsapplicable'] = this.pIspersonaldetailsapplicable;
    data['pIssecurityandcolletralapplicable'] =
        this.pIssecurityandcolletralapplicable;
    data['pIsexistingloansapplicable'] = this.pIsexistingloansapplicable;
    data['pIsreferencesapplicable'] = this.pIsreferencesapplicable;
    data['pIsreferralapplicable'] = this.pIsreferralapplicable;
    data['pReferralname'] = this.pReferralname;
    data['preferralcontactrefid'] = this.preferralcontactrefid;
    data['pSalespersonname'] = this.pSalespersonname;
    data['psalespersoncontactrefid'] = this.psalespersoncontactrefid;
    data['pschemeid'] = this.pschemeid;
    data['pFIVerifierscomments'] = this.pFIVerifierscomments;
    data['pFIVerifiersrating'] = this.pFIVerifiersrating;
    data['pverificationdate'] = this.pverificationdate;
    data['pverificationtime'] = this.pverificationtime;
    data['pVerifierName'] = this.pVerifierName;
    data['papprovaldate'] = this.papprovaldate;
    data['pfirstdisbursementdate'] = this.pfirstdisbursementdate;
    data['ploancloseddate'] = this.ploancloseddate;
    data['pstatusname'] = this.pstatusname;
    data['pNextEmiDate'] = this.pNextEmiDate;
    data['pOverdueAmount'] = this.pOverdueAmount;
    data['plastdisbursementdate'] = this.plastdisbursementdate;
    data['ptotaldisburseamount'] = this.ptotaldisburseamount;
    data['ploanstartddate'] = this.ploanstartddate;
    data['pinstalmentprinciple'] = this.pinstalmentprinciple;
    data['pinstalmentinterest'] = this.pinstalmentinterest;
    data['pactualpenalty'] = this.pactualpenalty;
    data['ppaidprinciple'] = this.ppaidprinciple;
    data['ppaidinterest'] = this.ppaidinterest;
    data['ppaidpenalty'] = this.ppaidpenalty;
    data['pwaiveofpenalty'] = this.pwaiveofpenalty;
    data['pprincipledue'] = this.pprincipledue;
    data['pinterestdue'] = this.pinterestdue;
    data['ppenaltydue'] = this.ppenaltydue;
    data['pfutureprincipledue'] = this.pfutureprincipledue;
    data['pfutureinterestdue'] = this.pfutureinterestdue;
    data['ptotaldueamount'] = this.ptotaldueamount;
    data['ptotalpaidamount'] = this.ptotalpaidamount;
    data['leadid'] = this.leadid;
    data['paccountid'] = this.paccountid;
    data['paccountno'] = this.paccountno;
    data['pconfigid'] = this.pconfigid;
    data['pconfigname'] = this.pconfigname;
    data['ptransdate'] = this.ptransdate;
    data['pmemberid'] = this.pmemberid;
    data['pmembername'] = this.pmembername;
    data['pdepositamount'] = this.pdepositamount;
    data['pmaturityamount'] = this.pmaturityamount;
    data['pdepositdate'] = this.pdepositdate;
    data['pmaturitydate'] = this.pmaturitydate;
    data['ploanpercentage'] = this.ploanpercentage;
    data['peligibleamount'] = this.peligibleamount;
    data['pstatus'] = this.pstatus;
    data['pStatusid'] = this.pStatusid;
    data['pcreatedby'] = this.pcreatedby;
    data['pcreateddate'] = this.pcreateddate;
    data['pGroupId'] = this.pGroupId;
    data['pGroupName'] = this.pGroupName;
    data['pbranchName'] = this.pbranchName;
    data['pBranchId'] = this.pBranchId;
    data['modifiedby'] = this.modifiedby;
    data['pCreatedby'] = this.pCreatedby;
    data['pModifiedby'] = this.pModifiedby;
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
    return data;
  }
}

class LstInstalmentsgenerationDTO {
  dynamic pInstalmentno;
  dynamic pInstalmentdate;
  dynamic pInstalmentprinciple;
  dynamic pInstalmentinterest;
  dynamic pInstalmentamount;

  LstInstalmentsgenerationDTO(
      {this.pInstalmentno,
        this.pInstalmentdate,
        this.pInstalmentprinciple,
        this.pInstalmentinterest,
        this.pInstalmentamount});

  LstInstalmentsgenerationDTO.fromJson(Map<String, dynamic> json) {
    pInstalmentno = json['pInstalmentno'];
    pInstalmentdate = json['pInstalmentdate'];
    pInstalmentprinciple = json['pInstalmentprinciple'];
    pInstalmentinterest = json['pInstalmentinterest'];
    pInstalmentamount = json['pInstalmentamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pInstalmentno'] = this.pInstalmentno;
    data['pInstalmentdate'] = this.pInstalmentdate;
    data['pInstalmentprinciple'] = this.pInstalmentprinciple;
    data['pInstalmentinterest'] = this.pInstalmentinterest;
    data['pInstalmentamount'] = this.pInstalmentamount;
    return data;
  }
}