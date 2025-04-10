import 'package:finsta_mac/components/KeyValueModel.dart';

class LoanTypeModel {
  dynamic getidentificationdocumentsList;
  dynamic instalmentdatedetailslist;
  dynamic loanconfigurationlist;
  dynamic identificationdocumentsList;
  dynamic  referralCommissioLoanList;
  dynamic penaltyConfigurationList;
  dynamic ltvConfiguration;
  dynamic rbtConfiguration;
  dynamic intrestConfiguration;
  dynamic rebateconfig;
  dynamic loaninterestchanges;
  dynamic pLoanid;
  dynamic pLoanNmae;
  dynamic pLoantypeid;
  String? pLoantype;
  dynamic pLoanname;
  dynamic pLoancode;
  dynamic pCompanycode;
  dynamic pBranchcode;
  dynamic pSeries;
  dynamic pSerieslength;
  dynamic pLoanidcode;
  dynamic pCount;
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

  LoanTypeModel(
      {this.getidentificationdocumentsList,
        this.instalmentdatedetailslist,
        this.loanconfigurationlist,
        this.identificationdocumentsList,
        this.referralCommissioLoanList,
        this.penaltyConfigurationList,
        this.ltvConfiguration,
        this.rbtConfiguration,
        this.intrestConfiguration,
        this.rebateconfig,
        this.loaninterestchanges,
        this.pLoanid,
        this.pLoanNmae,
        this.pLoantypeid,
        this.pLoantype,
        this.pLoanname,
        this.pLoancode,
        this.pCompanycode,
        this.pBranchcode,
        this.pSeries,
        this.pSerieslength,
        this.pLoanidcode,
        this.pCount,
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
        this.pbranchid});

  LoanTypeModel.fromJson(Map<String, dynamic> json) {
    getidentificationdocumentsList = json['getidentificationdocumentsList'];
    instalmentdatedetailslist = json['instalmentdatedetailslist'];
    loanconfigurationlist = json['loanconfigurationlist'];
    identificationdocumentsList = json['identificationdocumentsList'];
    referralCommissioLoanList = json['referralCommissioLoanList'];
    penaltyConfigurationList = json['penaltyConfigurationList'];
    ltvConfiguration = json['ltvConfiguration'];
    rbtConfiguration = json['rbtConfiguration'];
    intrestConfiguration = json['intrestConfiguration'];
    rebateconfig = json['rebateconfig'];
    loaninterestchanges = json['loaninterestchanges'];
    pLoanid = json['pLoanid'];
    pLoanNmae = json['pLoanNmae'];
    pLoantypeid = json['pLoantypeid'];
    pLoantype = json['pLoantype'];
    pLoanname = json['pLoanname'];
    pLoancode = json['pLoancode'];
    pCompanycode = json['pCompanycode'];
    pBranchcode = json['pBranchcode'];
    pSeries = json['pSeries'];
    pSerieslength = json['pSerieslength'];
    pLoanidcode = json['pLoanidcode'];
    pCount = json['pCount'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getidentificationdocumentsList'] =
        this.getidentificationdocumentsList;
    data['instalmentdatedetailslist'] = this.instalmentdatedetailslist;
    data['loanconfigurationlist'] = this.loanconfigurationlist;
    data['identificationdocumentsList'] = this.identificationdocumentsList;
    data['referralCommissioLoanList'] = this.referralCommissioLoanList;
    data['penaltyConfigurationList'] = this.penaltyConfigurationList;
    data['ltvConfiguration'] = this.ltvConfiguration;
    data['rbtConfiguration'] = this.rbtConfiguration;
    data['intrestConfiguration'] = this.intrestConfiguration;
    data['rebateconfig'] = this.rebateconfig;
    data['loaninterestchanges'] = this.loaninterestchanges;
    data['pLoanid'] = this.pLoanid;
    data['pLoanNmae'] = this.pLoanNmae;
    data['pLoantypeid'] = this.pLoantypeid;
    data['pLoantype'] = this.pLoantype;
    data['pLoanname'] = this.pLoanname;
    data['pLoancode'] = this.pLoancode;
    data['pCompanycode'] = this.pCompanycode;
    data['pBranchcode'] = this.pBranchcode;
    data['pSeries'] = this.pSeries;
    data['pSerieslength'] = this.pSerieslength;
    data['pLoanidcode'] = this.pLoanidcode;
    data['pCount'] = this.pCount;
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
    return data;
  }

  static List<KeyValueModel> keyValueList(List<LoanTypeModel> list){
    return list.map((e) {
      return KeyValueModel(id: e.pLoantypeid.toString(), name: e.pLoantype.toString());
    }).toList();
  }
}