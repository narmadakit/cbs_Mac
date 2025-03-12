class CompanyDetailsModel {
  dynamic pPhoto;
  String? imagestring;
  String? emailid;
  String? pCompanyName;
  String? pAddress1;
  String? pAddress2;
  int? pbranchid;
  String? pcity;
  dynamic pCountry;
  String? pState;
  String? pDistrict;
  String? pPincode;
  String? pCinNo;
  String? pGstinNo;
  String? pBranchname;
  int? pStateid;
  int? pDistrictid;
  dynamic pmainschemaname;
  dynamic pSchemaName;
  String? pShareCapitalJv;
  bool? pdatepickerenablestatus;
  String? paccountscreationtype;
  bool? palltransactionbysavingaccountid;
  bool? pismultipulepaymentsavailable;
  bool? pNrdstatus;
  bool? pallowcontactsBranchwise;
  bool? pPOCustomerReceipt;
  String? puserrightstype;
  bool? pisgoldschemeexist;
  dynamic pbranchcode;
  List<Shortkeyslist>? lShortkeyslist;

  CompanyDetailsModel(
      {this.pPhoto,
        this.imagestring,
        this.emailid,
        this.pCompanyName,
        this.pAddress1,
        this.pAddress2,
        this.pbranchid,
        this.pcity,
        this.pCountry,
        this.pState,
        this.pDistrict,
        this.pPincode,
        this.pCinNo,
        this.pGstinNo,
        this.pBranchname,
        this.pStateid,
        this.pDistrictid,
        this.pmainschemaname,
        this.pSchemaName,
        this.pShareCapitalJv,
        this.pdatepickerenablestatus,
        this.paccountscreationtype,
        this.palltransactionbysavingaccountid,
        this.pismultipulepaymentsavailable,
        this.pNrdstatus,
        this.pallowcontactsBranchwise,
        this.pPOCustomerReceipt,
        this.puserrightstype,
        this.pisgoldschemeexist,
        this.pbranchcode,
        this.lShortkeyslist});

  CompanyDetailsModel.fromJson(Map<String, dynamic> json) {
    pPhoto = json['pPhoto'];
    imagestring = json['imagestring'];
    emailid = json['emailid'];
    pCompanyName = json['pCompanyName'];
    pAddress1 = json['pAddress1'];
    pAddress2 = json['pAddress2'];
    pbranchid = json['pbranchid'];
    pcity = json['pcity'];
    pCountry = json['pCountry'];
    pState = json['pState'];
    pDistrict = json['pDistrict'];
    pPincode = json['pPincode'];
    pCinNo = json['pCinNo'];
    pGstinNo = json['pGstinNo'];
    pBranchname = json['pBranchname'];
    pStateid = json['pStateid'];
    pDistrictid = json['pDistrictid'];
    pmainschemaname = json['pmainschemaname'];
    pSchemaName = json['pSchema_name'];
    pShareCapitalJv = json['pShareCapital_jv'];
    pdatepickerenablestatus = json['pdatepickerenablestatus'];
    paccountscreationtype = json['paccountscreationtype'];
    palltransactionbysavingaccountid = json['palltransactionbysavingaccountid'];
    pismultipulepaymentsavailable = json['pismultipulepaymentsavailable'];
    pNrdstatus = json['pNrdstatus'];
    pallowcontactsBranchwise = json['pallowcontacts_branchwise'];
    pPOCustomerReceipt = json['pPOCustomerReceipt'];
    puserrightstype = json['puserrightstype'];
    pisgoldschemeexist = json['pisgoldschemeexist'];
    pbranchcode = json['pbranchcode'];
    if (json['_shortkeyslist'] != null) {
      lShortkeyslist = <Shortkeyslist>[];
      json['_shortkeyslist'].forEach((v) {
        lShortkeyslist!.add(new Shortkeyslist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pPhoto'] = this.pPhoto;
    data['imagestring'] = this.imagestring;
    data['emailid'] = this.emailid;
    data['pCompanyName'] = this.pCompanyName;
    data['pAddress1'] = this.pAddress1;
    data['pAddress2'] = this.pAddress2;
    data['pbranchid'] = this.pbranchid;
    data['pcity'] = this.pcity;
    data['pCountry'] = this.pCountry;
    data['pState'] = this.pState;
    data['pDistrict'] = this.pDistrict;
    data['pPincode'] = this.pPincode;
    data['pCinNo'] = this.pCinNo;
    data['pGstinNo'] = this.pGstinNo;
    data['pBranchname'] = this.pBranchname;
    data['pStateid'] = this.pStateid;
    data['pDistrictid'] = this.pDistrictid;
    data['pmainschemaname'] = this.pmainschemaname;
    data['pSchema_name'] = this.pSchemaName;
    data['pShareCapital_jv'] = this.pShareCapitalJv;
    data['pdatepickerenablestatus'] = this.pdatepickerenablestatus;
    data['paccountscreationtype'] = this.paccountscreationtype;
    data['palltransactionbysavingaccountid'] =
        this.palltransactionbysavingaccountid;
    data['pismultipulepaymentsavailable'] = this.pismultipulepaymentsavailable;
    data['pNrdstatus'] = this.pNrdstatus;
    data['pallowcontacts_branchwise'] = this.pallowcontactsBranchwise;
    data['pPOCustomerReceipt'] = this.pPOCustomerReceipt;
    data['puserrightstype'] = this.puserrightstype;
    data['pisgoldschemeexist'] = this.pisgoldschemeexist;
    data['pbranchcode'] = this.pbranchcode;
    if (this.lShortkeyslist != null) {
      data['_shortkeyslist'] =
          this.lShortkeyslist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shortkeyslist {
  int? pRecordid;
  String? pFormname;
  String? pFormUrl;
  String? pCapsonoroff;
  bool? pCtrl;
  bool? pShift;
  bool? pTab;
  bool? pAlt;
  String? pletter;
  int? pStatusid;
  int? pCreatedby;
  String? pcreateddate;
  dynamic ptypeofoperation;
  int? pModifiedby;
  dynamic pModifieddate;

  Shortkeyslist(
      {this.pRecordid,
        this.pFormname,
        this.pFormUrl,
        this.pCapsonoroff,
        this.pCtrl,
        this.pShift,
        this.pTab,
        this.pAlt,
        this.pletter,
        this.pStatusid,
        this.pCreatedby,
        this.pcreateddate,
        this.ptypeofoperation,
        this.pModifiedby,
        this.pModifieddate});

  Shortkeyslist.fromJson(Map<String, dynamic> json) {
    pRecordid = json['pRecordid'];
    pFormname = json['pFormname'];
    pFormUrl = json['pFormUrl'];
    pCapsonoroff = json['pCapsonoroff'];
    pCtrl = json['pCtrl'];
    pShift = json['pShift'];
    pTab = json['pTab'];
    pAlt = json['pAlt'];
    pletter = json['pletter'];
    pStatusid = json['pStatusid'];
    pCreatedby = json['pCreatedby'];
    pcreateddate = json['pcreateddate'];
    ptypeofoperation = json['ptypeofoperation'];
    pModifiedby = json['pModifiedby'];
    pModifieddate = json['pModifieddate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pRecordid'] = this.pRecordid;
    data['pFormname'] = this.pFormname;
    data['pFormUrl'] = this.pFormUrl;
    data['pCapsonoroff'] = this.pCapsonoroff;
    data['pCtrl'] = this.pCtrl;
    data['pShift'] = this.pShift;
    data['pTab'] = this.pTab;
    data['pAlt'] = this.pAlt;
    data['pletter'] = this.pletter;
    data['pStatusid'] = this.pStatusid;
    data['pCreatedby'] = this.pCreatedby;
    data['pcreateddate'] = this.pcreateddate;
    data['ptypeofoperation'] = this.ptypeofoperation;
    data['pModifiedby'] = this.pModifiedby;
    data['pModifieddate'] = this.pModifieddate;
    return data;
  }
}