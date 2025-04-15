import '../../../components/KeyValueModel.dart';

class LoanInstalmentModel {
  dynamic pschemeid;
  dynamic pSchemename;
  dynamic pLoanpayin;
  dynamic pSchemecode;
  dynamic pInteresttype;
  dynamic pRateofinterest;
  dynamic pMinInterest;
  dynamic pMinloanamount;
  dynamic pMaxloanamount;
  dynamic pTenorfrom;
  dynamic ptenurefrom;
  dynamic ptenureto;
  dynamic pminintrate;
  dynamic pmaxrate;
  dynamic pTenorto;
  dynamic pfrrtype;
  dynamic pfrrrate;
  String? pLoaninstalmentpaymentmode;
  String? pLoaninstalmentpaymentmodecode;

  LoanInstalmentModel(
      {this.pschemeid,
        this.pSchemename,
        this.pLoanpayin,
        this.pSchemecode,
        this.pInteresttype,
        this.pRateofinterest,
        this.pMinInterest,
        this.pMinloanamount,
        this.pMaxloanamount,
        this.pTenorfrom,
        this.ptenurefrom,
        this.ptenureto,
        this.pminintrate,
        this.pmaxrate,
        this.pTenorto,
        this.pfrrtype,
        this.pfrrrate,
        this.pLoaninstalmentpaymentmode,
        this.pLoaninstalmentpaymentmodecode});

  LoanInstalmentModel.fromJson(Map<String, dynamic> json) {
    pschemeid = json['pschemeid'];
    pSchemename = json['pSchemename'];
    pLoanpayin = json['pLoanpayin'];
    pSchemecode = json['pSchemecode'];
    pInteresttype = json['pInteresttype'];
    pRateofinterest = json['pRateofinterest'];
    pMinInterest = json['pMinInterest'];
    pMinloanamount = json['pMinloanamount'];
    pMaxloanamount = json['pMaxloanamount'];
    pTenorfrom = json['pTenorfrom'];
    ptenurefrom = json['ptenurefrom'];
    ptenureto = json['ptenureto'];
    pminintrate = json['pminintrate'];
    pmaxrate = json['pmaxrate'];
    pTenorto = json['pTenorto'];
    pfrrtype = json['pfrrtype'];
    pfrrrate = json['pfrrrate'];
    pLoaninstalmentpaymentmode = json['pLoaninstalmentpaymentmode'];
    pLoaninstalmentpaymentmodecode = json['pLoaninstalmentpaymentmodecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pschemeid'] = this.pschemeid;
    data['pSchemename'] = this.pSchemename;
    data['pLoanpayin'] = this.pLoanpayin;
    data['pSchemecode'] = this.pSchemecode;
    data['pInteresttype'] = this.pInteresttype;
    data['pRateofinterest'] = this.pRateofinterest;
    data['pMinInterest'] = this.pMinInterest;
    data['pMinloanamount'] = this.pMinloanamount;
    data['pMaxloanamount'] = this.pMaxloanamount;
    data['pTenorfrom'] = this.pTenorfrom;
    data['ptenurefrom'] = this.ptenurefrom;
    data['ptenureto'] = this.ptenureto;
    data['pminintrate'] = this.pminintrate;
    data['pmaxrate'] = this.pmaxrate;
    data['pTenorto'] = this.pTenorto;
    data['pfrrtype'] = this.pfrrtype;
    data['pfrrrate'] = this.pfrrrate;
    data['pLoaninstalmentpaymentmode'] = this.pLoaninstalmentpaymentmode;
    data['pLoaninstalmentpaymentmodecode'] =
        this.pLoaninstalmentpaymentmodecode;
    return data;
  }

  static List<KeyValueModel> kVInstalmentModeList(List<LoanInstalmentModel> list){
    return list.map((e) {
      return KeyValueModel(id: e.pschemeid.toString(), name: e.pLoaninstalmentpaymentmode.toString());
    }).toList();
  }
}