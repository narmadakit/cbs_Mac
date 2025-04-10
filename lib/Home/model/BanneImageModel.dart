class BannerImageModel {
  dynamic ptypeofoperation;
  bool? pdisplaystatus;
  String? pschemedescription;
  String? pschemepath;
  String? pschemeimagepath;
  String? pcreateddate;
  dynamic pcreatedby;
  dynamic pschemeid;

  BannerImageModel(
      {this.ptypeofoperation,
        this.pdisplaystatus,
        this.pschemedescription,
        this.pschemepath,
        this.pschemeimagepath,
        this.pcreateddate,
        this.pcreatedby,
        this.pschemeid});

  BannerImageModel.fromJson(Map<String, dynamic> json) {
    ptypeofoperation = json['ptypeofoperation'];
    pdisplaystatus = json['pdisplaystatus'];
    pschemedescription = json['pschemedescription'];
    pschemepath = json['pschemepath'];
    pschemeimagepath = json['pschemeimagepath'];
    pcreateddate = json['pcreateddate'];
    pcreatedby = json['pcreatedby'];
    pschemeid = json['pschemeid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ptypeofoperation'] = this.ptypeofoperation;
    data['pdisplaystatus'] = this.pdisplaystatus;
    data['pschemedescription'] = this.pschemedescription;
    data['pschemepath'] = this.pschemepath;
    data['pschemeimagepath'] = this.pschemeimagepath;
    data['pcreateddate'] = this.pcreateddate;
    data['pcreatedby'] = this.pcreatedby;
    data['pschemeid'] = this.pschemeid;
    return data;
  }
}