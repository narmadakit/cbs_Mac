import 'dart:convert';
import 'dart:developer';
import 'package:finsta_mac/Calculator/model/FdTenureModel.dart';
import 'package:finsta_mac/Calculator/model/SchemaDetailsModel.dart';
import 'package:finsta_mac/Home/model/LoanDataResponse.dart';
import 'package:finsta_mac/Home/model/MemberDetailsResponse.dart';
import 'package:finsta_mac/Login/model/GetOtpModel.dart';
import 'package:finsta_mac/network/ApiURL.dart';
import 'package:finsta_mac/utils/AppText.dart';
import 'package:finsta_mac/utils/SharedPrefs.dart';
import 'package:http/http.dart' as http;
import '../Home/model/MembersAllDuesModel.dart';
import '../Login/model/CompanyDetailsModel.dart';

class Repository{
  static String TAG = "Repository";

  Map<String,String> loginHeader={
    'Content-Type': 'application/json',
    'schema-name': 'public'
  };

  Future<List<MemberDetailsResponse>> memberData() async {
    var data = await SharedPrefs.readData(SharedPrefs.memberDetails);
   List<MemberDetailsResponse> listData=MemberDetailsResponse.fromJsonList(data);
    return listData;
  }

  Future<List<SchemaDetailsModel>> getAllDepositSchema() async {
    var data = await SharedPrefs.readData(SharedPrefs.depositSchemaDetails);
    List<SchemaDetailsModel> listData=SchemaDetailsModel.fromJsonList(data);
    return listData;
  }

  Future<GetOtpModel> getOtpRepo(String mobile) async {
    TAG = 'getOtpRepo';
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
    TAG = 'validateOtpRepo';
    String url = ApiURL.validateLoginOtp(mobile,otp,date);
    Uri apiUrl=Uri.parse(url);
    print("URL $TAG --------$apiUrl");
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
    TAG = 'getMemberDetailsRepo';
    String url = ApiURL.getMemberDataByMobile(mobile);
    Uri apiUrl = Uri.parse(url);
    log("URL $TAG --------$apiUrl");
    try{
      var response = await http.get(apiUrl,headers: loginHeader);
      List<MemberDetailsResponse> listData=[];
      if(response.body.isNotEmpty) {
        print('$TAG -------${jsonDecode(response.body)}');
        List body = jsonDecode(response.body);
        listData = body.map((e) => MemberDetailsResponse.fromJson(e)).toList();
      }
      return listData;
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
    log("URL MemberAllDues --------$apiUrl");
    try{
      var response = await http.get(apiUrl,headers: loginHeader);
      log('getMemberAllDuesRepo-------${jsonEncode(jsonDecode(response.body))}');
      List body= json.decode(response.body);
      return body.map((e) => MembersAllDuesModel.fromJson(e)).toList();
    }
    catch(e){
      log("getMemberAllDuesRepo error $e");
      throw Exception(e);
    }
  }

  //DEPOSITS
  Future<List<SchemaDetailsModel>> getAllTransactionsSchemes(String formName) async{
    TAG = 'getAllTransactionsSchemes';
   String applicantType="";
   String memberType="";
   List<SchemaDetailsModel> listData=[];
    try{
      memberData().then((value) async {
        applicantType= value[0].papplicanttype;
        memberType = value[0].pmembertype;

        String url = ApiURL.getAllTransactionsSchemes(formName, applicantType, memberType);
        Uri apiUrl = Uri.parse(url);
        log("URL $TAG  --------$apiUrl");
        var response = await http.get(apiUrl,headers: loginHeader);
        List body = json.decode(response.body);
        listData= body.map((e) => SchemaDetailsModel.fromJson(e)).toList();
        log('==$TAG ${jsonEncode(listData)}');
        SharedPrefs.saveData(SharedPrefs.depositSchemaDetails, listData);
        return listData;
      });
    }
    catch(e){
      log("$TAG error $e");
      throw Exception(e);
    }
    return listData;
}

  // Future<List<FdTenureModel>> getFdTenureModesRepo(String fdName) async{
  //   TAG = 'getFdTenureModesRepo';
  //   String applicantType="";
  //   String memberType="";
  //   List<SchemaDetailsModel> listData=[];
  //   try{
  //     memberData().then((value) async {
  //       applicantType= value[0].papplicanttype;
  //       memberType = value[0].pmembertype;
  //
  //       String url = ApiURL.getFdTenureModes(fdName, applicantType, memberType);
  //       Uri apiUrl = Uri.parse(url);
  //       log("URL $TAG  --------$apiUrl");
  //       var response = await http.get(apiUrl,headers: loginHeader);
  //       List body = json.decode(response.body);
  //       listData= body.map((e) => SchemaDetailsModel.fromJson(e)).toList();
  //       log('==$TAG ${jsonEncode(listData)}');
  //       return listData;
  //     });
  //   }
  //   catch(e){
  //     log("$TAG error $e");
  //     throw Exception(e);
  //   }
  //   return listData;
  // }

}