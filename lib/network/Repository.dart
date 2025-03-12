import 'dart:convert';
import 'dart:developer';
import 'package:finsta_mac/Home/model/LoanDataResponse.dart';
import 'package:finsta_mac/Home/model/MemberDetailsResponse.dart';
import 'package:finsta_mac/Login/model/GetOtpModel.dart';
import 'package:finsta_mac/network/ApiURL.dart';
import 'package:http/http.dart' as http;
import '../Home/model/MembersAllDuesModel.dart';
import '../Login/model/CompanyDetailsModel.dart';

class Repository{
  static final String TAG = "Repository";

  Map<String,String> loginHeader={
    'Content-Type': 'application/json',
    'schema-name': 'public'
  };

  Future<GetOtpModel> getOtpRepo(String mobile) async {
    String url = ApiURL.getLoginOtp;
    Uri apiUrl=Uri.parse(url);
    Map<String,dynamic> requestBody={
      "recordId": 0,
      "pMobileno": mobile,
      "pcreateddate": "string",
      "potpstatus": true,
      "pCreatedby": 14,
      "pIsSaved": true,
      "pOtp": 0,
      "formName": "LOGIN",
      "strUrl": "string"
    };
    print("URL getOtpRepo --------$apiUrl ${jsonEncode(requestBody)}");
    var response = await http.post(apiUrl,headers: loginHeader,body: jsonEncode(requestBody));
    log('RESPONSE getOtpRepo >>>> ${response.body}');
    final GetOtpModel responseData = GetOtpModel.fromJson(jsonDecode(response.body));
    return responseData;
  }

  Future<String> validateOtpRepo(String mobile,otp,date) async {
    String url = ApiURL.validateLoginOtp(mobile,otp,date);
    Uri apiUrl=Uri.parse(url);
    print("URL validateOtpRepo --------$apiUrl");
    var response = await http.get(apiUrl,headers: loginHeader);
    log('RESPONSE validateOtpRepo >>>> ${response.body}');
    if(response.body == true){
      print("Sucessss--------");
    }
    else{
      print('=======failed');
    }
    return response.body;
  }

  Future<CompanyDetailsModel> getCompanyDetailsRepo() async {
    String url = ApiURL.getCompanyDetails;
    Uri apiUrl=Uri.parse(url);
    var response = await http.get(apiUrl,headers: loginHeader);
    final CompanyDetailsModel responseData = CompanyDetailsModel.fromJson(jsonDecode(response.body));
    return responseData;
  }

  Future<List<MemberDetailsResponse>> getMemberDetailsRepo(String mobile) async {
    String url = ApiURL.getMemberDataByMobile(mobile);
    Uri apiUrl = Uri.parse(url);
    print("URL getMemberDataByMobile --------$apiUrl");
    try{
      var response = await http.get(apiUrl,headers: loginHeader);

      print('getMemberDetailsRepo-------${jsonDecode(response.body)}');
      List body= jsonDecode(response.body);
      return body.map((e) => MemberDetailsResponse.fromJson(e)).toList();
    }
    catch(e){
      print("$TAG, getMemberDetailsRepo - exceptipon : ${e.toString()}");
      throw Exception(e);
    }

  }

  Future<LoanDataResponse> getLoanDetailsRepo(String memberId) async {
    String url = ApiURL.getMembersSummaryByMemberId(memberId);
    Uri apiUrl=Uri.parse(url);
    print("URL getLoanDetailsRepo --------$apiUrl");
    try{
      var response = await http.get(apiUrl,headers: loginHeader);
      final LoanDataResponse responseData = LoanDataResponse.fromJson(jsonDecode(response.body));
      log('RESPONSE getLoanDetailsRepo >>>> ${jsonEncode(responseData)}');
      return responseData;
    }
    catch(e){
      print("getMemberAllDuesRepo error $e");
      throw Exception(e);
    }
  }

  Future<List<MembersAllDuesModel>> getMemberAllDuesRepo(String memberId, String date) async {
    String url = ApiURL.getMemberAllDues(memberId,date);
    Uri apiUrl=Uri.parse(url);
    print("URL MemberAllDues --------$apiUrl");
    try{
      var response = await http.get(apiUrl,headers: loginHeader);
      log('getMemberAllDuesRepo-------${jsonEncode(jsonDecode(response.body))}');
      List body= json.decode(response.body);
      return body.map((e) => MembersAllDuesModel.fromJson(e)).toList();
    }
    catch(e){
      print("getMemberAllDuesRepo error $e");
      throw Exception(e);
    }
  }


}