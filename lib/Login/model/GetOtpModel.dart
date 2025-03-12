class GetOtpModel {
  bool? pIsSaved;
  int? otp;
  dynamic mobileNumber;
  dynamic bytesLogo;
  dynamic strUrl;

  GetOtpModel({this.pIsSaved, this.otp, this.mobileNumber,this.bytesLogo});

  GetOtpModel.fromJson(Map<String, dynamic> json) {
    pIsSaved = json['pIsSaved'];
    otp = json['otp'];
    mobileNumber = json['mobileNumber'];
    bytesLogo = json['bytesLogo'];
    strUrl = json['strUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pIsSaved'] = this.pIsSaved;
    data['otp'] = this.otp;
    data['mobileNumber'] = this.mobileNumber;
    data['bytesLogo'] = this.bytesLogo;
    data['strUrl'] = this.strUrl;
    return data;
  }
}