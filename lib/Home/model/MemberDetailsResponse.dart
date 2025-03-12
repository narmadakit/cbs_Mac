class MemberDetailsResponse {
  int? ploanscount;
  int? pContactdId;
  String? pContactType;
  String? pRefNo;
  dynamic ploanucic;
  String? pContactName;
  String? pFatherName;
  String? pFatherLastName;
  String? pContactNumber;
  String? pContactEmail;
  String? pImagePath;
  dynamic pImage;
  String? pAddresDetails;
  bool? pissupplier;
  bool? pisadvocate;
  bool? pisemployee;
  bool? pisreferral;
  dynamic subscribercount;
  String? pGender;
  dynamic pContactimagepath;
  String? pAadhar;
  String? pPan;
  String? pmembercode;
  dynamic pmembername;
  dynamic pReferralName;
  int? pmemberid;
  int? pmembertypeid;
  dynamic pmembertype;
  String? pbranchname;
  int? pbranchid;

  MemberDetailsResponse(
      {this.ploanscount,
        this.pContactdId,
        this.pContactType,
        this.pRefNo,
        this.ploanucic,
        this.pContactName,
        this.pFatherName,
        this.pFatherLastName,
        this.pContactNumber,
        this.pContactEmail,
        this.pImagePath,
        this.pImage,
        this.pAddresDetails,
        this.pissupplier,
        this.pisadvocate,
        this.pisemployee,
        this.pisreferral,
        this.subscribercount,
        this.pGender,
        this.pContactimagepath,
        this.pAadhar,
        this.pPan,
        this.pmembercode,
        this.pmembername,
        this.pReferralName,
        this.pmemberid,
        this.pmembertypeid,
        this.pmembertype,
        this.pbranchname,
        this.pbranchid});

  MemberDetailsResponse.fromJson(Map<String, dynamic> json) {
    ploanscount = json['ploanscount'];
    pContactdId = json['pContactdId'];
    pContactType = json['pContactType'];
    pRefNo = json['pRefNo'];
    ploanucic = json['ploanucic'];
    pContactName = json['pContactName'];
    pFatherName = json['pFatherName'];
    pFatherLastName = json['pFatherLastName'];
    pContactNumber = json['pContactNumber'];
    pContactEmail = json['pContactEmail'];
    pImagePath = json['pImagePath'];
    pImage = json['pImage'];
    pAddresDetails = json['pAddresDetails'];
    pissupplier = json['pissupplier'];
    pisadvocate = json['pisadvocate'];
    pisemployee = json['pisemployee'];
    pisreferral = json['pisreferral'];
    subscribercount = json['subscribercount'];
    pGender = json['pGender'];
    pContactimagepath = json['pContactimagepath'];
    pAadhar = json['pAadhar'];
    pPan = json['pPan'];
    pmembercode = json['pmembercode'];
    pmembername = json['pmembername'];
    pReferralName = json['pReferralName'];
    pmemberid = json['pmemberid'];
    pmembertypeid = json['pmembertypeid'];
    pmembertype = json['pmembertype'];
    pbranchname = json['pbranchname'];
    pbranchid = json['pbranchid'];
  }

  //API returns JSON array not json object so that is List not Map.
  static List<MemberDetailsResponse> fromJsonList(List list) {
    return list.map((item) => MemberDetailsResponse.fromJson(item)).toList();
  }
  // to use this
  // List<MemberDetailsResponse> listData=  MemberDetailsResponse.fromJsonList(data);

  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ploanscount'] = this.ploanscount;
    data['pContactdId'] = this.pContactdId;
    data['pContactType'] = this.pContactType;
    data['pRefNo'] = this.pRefNo;
    data['ploanucic'] = this.ploanucic;
    data['pContactName'] = this.pContactName;
    data['pFatherName'] = this.pFatherName;
    data['pFatherLastName'] = this.pFatherLastName;
    data['pContactNumber'] = this.pContactNumber;
    data['pContactEmail'] = this.pContactEmail;
    data['pImagePath'] = this.pImagePath;
    data['pImage'] = this.pImage;
    data['pAddresDetails'] = this.pAddresDetails;
    data['pissupplier'] = this.pissupplier;
    data['pisadvocate'] = this.pisadvocate;
    data['pisemployee'] = this.pisemployee;
    data['pisreferral'] = this.pisreferral;
    data['subscribercount'] = this.subscribercount;
    data['pGender'] = this.pGender;
    data['pContactimagepath'] = this.pContactimagepath;
    data['pAadhar'] = this.pAadhar;
    data['pPan'] = this.pPan;
    data['pmembercode'] = this.pmembercode;
    data['pmembername'] = this.pmembername;
    data['pReferralName'] = this.pReferralName;
    data['pmemberid'] = this.pmemberid;
    data['pmembertypeid'] = this.pmembertypeid;
    data['pmembertype'] = this.pmembertype;
    data['pbranchname'] = this.pbranchname;
    data['pbranchid'] = this.pbranchid;
    return data;
  }
}