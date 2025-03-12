class MembersAllDuesModel {
  dynamic paccounttype;
  dynamic paccountname;
  dynamic pdueamount;
  dynamic pprincipleamount;
  dynamic pinterestamount;
  dynamic paccountid;
  dynamic pTotalOutstandingAmount;
  dynamic poldrdaccountno;
  dynamic pbranchname;

  MembersAllDuesModel(
      {this.paccounttype,
        this.paccountname,
        this.pdueamount,
        this.pprincipleamount,
        this.pinterestamount,
        this.paccountid,
        this.pTotalOutstandingAmount,
        this.poldrdaccountno,
        this.pbranchname});

  MembersAllDuesModel.fromJson(Map<String, dynamic> json) {
    paccounttype = json['paccounttype'];
    paccountname = json['paccountname'];
    pdueamount = json['pdueamount'];
    pprincipleamount = json['pprincipleamount'];
    pinterestamount = json['pinterestamount'];
    paccountid = json['paccountid'];
    pTotalOutstandingAmount = json['pTotalOutstandingAmount'];
    poldrdaccountno = json['poldrdaccountno'];
    pbranchname = json['pbranchname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paccounttype'] = this.paccounttype;
    data['paccountname'] = this.paccountname;
    data['pdueamount'] = this.pdueamount;
    data['pprincipleamount'] = this.pprincipleamount;
    data['pinterestamount'] = this.pinterestamount;
    data['paccountid'] = this.paccountid;
    data['pTotalOutstandingAmount'] = this.pTotalOutstandingAmount;
    data['poldrdaccountno'] = this.poldrdaccountno;
    data['pbranchname'] = this.pbranchname;
    return data;
  }
}