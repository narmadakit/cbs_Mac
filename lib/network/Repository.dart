import 'dart:convert';
import 'dart:developer';
import 'package:finsta_mac/Calculator/model/FDInterestDetailsModel.dart';
import 'package:finsta_mac/Calculator/model/FDDescriptionModel.dart';
import 'package:finsta_mac/Calculator/model/FDMaturityModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/DepositLoanPayInModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/FinalLoanViewModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanInstalmentModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanInterestRatesModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanNameModel.dart';
import 'package:finsta_mac/Calculator/model/Loans/LoanTypeModel.dart';
import 'package:finsta_mac/Calculator/model/RDDescriptionModel.dart';
import 'package:finsta_mac/Calculator/model/RDInterestDetailsModel.dart';
import 'package:finsta_mac/Calculator/model/SchemaDetailsModel.dart';
import 'package:finsta_mac/Home/model/BanneImageModel.dart';
import 'package:finsta_mac/Home/model/LoanDataResponse.dart';
import 'package:finsta_mac/Home/model/MemberDetailsResponse.dart';
import 'package:finsta_mac/Login/model/GetOtpModel.dart';
import 'package:finsta_mac/network/ApiURL.dart';
import 'package:finsta_mac/utils/SharedPrefs.dart';
import 'package:http/http.dart' as http;
import '../Calculator/model/DepositInterestRateModel.dart';
import '../Calculator/model/DepositTenureModel.dart';
import '../Home/model/MembersAllDuesModel.dart';
import '../Login/model/CompanyDetailsModel.dart';

class Repository{
  static String TAG = "Repository";

  Map<String,String> loginHeader={
    'Content-Type': 'application/json',
    'schema-name': 'public'
  };

  Future<MemberDetailsResponse> memberData() async {
    var data = await SharedPrefs.readData(SharedPrefs.memberDetails);
    MemberDetailsResponse listData=MemberDetailsResponse.fromJson(data);
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
      // log('RESPONSE getLoanDetailsRepo >>>> ${jsonEncode(responseData)}');
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

  Future<List<BannerImageModel>> getBannerImageRepo() async{
    TAG = 'getBannerImageRepo';
    try{
      String url = ApiURL.getBannerImages;
      Uri apiUrl = Uri.parse(url);
      log("URL $TAG  --------$apiUrl");
      var response = await http.get(apiUrl,headers: loginHeader);
      // log('RESPONSE $TAG >>>> ${jsonDecode(response.body)}');

      List body= json.decode(response.body);
      return body.map((e) => BannerImageModel.fromJson(e)).toList();
    }
    catch(e){
      log("$TAG error $e");
      throw Exception(e);
    }
  }

  //DEPOSITS
  Future<List<SchemaDetailsModel>> getAllTransactionsSchemesRepo(String formName) async{
    TAG = 'getAllTransactionsSchemes';
   String applicantType="";
   String memberType="";
   List<SchemaDetailsModel> listData=[];
   MemberDetailsResponse data = await memberData();
    applicantType= data.papplicanttype;
    memberType = data.pmembertype;
    try{
        String url = ApiURL.getAllTransactionsSchemes(formName, applicantType, memberType);
        Uri apiUrl = Uri.parse(url);
        log("URL $TAG  --------$apiUrl");
        var response = await http.get(apiUrl,headers: loginHeader);
        List body = json.decode(response.body);
        listData= body.map((e) => SchemaDetailsModel.fromJson(e)).toList();
        log('==$TAG ${listData.length}');
        SharedPrefs.saveData(SharedPrefs.depositSchemaDetails, listData);
        return listData;
    }
    catch(e){
      log("$TAG error $e");
      throw Exception(e);
    }
}

  Future<List<DepositeTenureModel>> getFDTenureTypeRepo(String fdName) async{
    TAG = 'getTenureTypeRepo';
    String applicantType="";
    String memberType="";
    MemberDetailsResponse data = await memberData();
    applicantType= data.papplicanttype;
    memberType = data.pmembertype;
    List<DepositeTenureModel> listData=[];
    try{
      String url = ApiURL.getFdTenureModesApi(fdName, applicantType, memberType);
      Uri apiUrl = Uri.parse(url);
      log("URL $TAG  --------$apiUrl");
      var response = await http.get(apiUrl,headers: loginHeader);
      List body = json.decode(response.body);
      listData= body.map((e) => DepositeTenureModel.fromJson(e)).toList();
      log('==$TAG ${listData.length}');
      return listData;
    }
    catch(e){
      log("$TAG error $e");
      throw Exception(e);
    }
  }

  Future<FDInterestDetailsModel> getFDInterestDetailsRepo(String fdConfigID,fdName,tenure,tenureMode,depositAmount) async{
    TAG = 'getFDInterestDetailsRepo';
    String applicantType="";
    String memberType="";
    MemberDetailsResponse data = await memberData();
    applicantType= data.papplicanttype;
    memberType = data.pmembertype;
    try{
      String url = ApiURL.getFdInterestDetailsApi(applicantType, memberType,fdConfigID,fdName,tenure,tenureMode,depositAmount);
      Uri apiUrl = Uri.parse(url);
      log("URL $TAG  --------$apiUrl");
      var response = await http.get(apiUrl,headers: loginHeader);

      final FDInterestDetailsModel responseData = FDInterestDetailsModel.fromJson(jsonDecode(response.body));
      log('RESPONSE $TAG >>>> ${jsonEncode(responseData)}');
      return responseData;
    }
    catch(e){
      log("$TAG error $e");
      throw Exception(e);
    }
  }

  Future<DepositInterestRateModel> getFDInterestTRateRepo(String fdName,depositAmount,tenure,tenureMode,interestPayout) async{
    TAG = 'getFDInterestDetailsRepo';
    String applicantType="";
    String memberType="";
    MemberDetailsResponse data = await memberData();
    applicantType= data.papplicanttype;
    memberType = data.pmembertype;
    try{
      String url = ApiURL.getFdInterestRateApi(fdName,depositAmount,tenure,tenureMode,interestPayout,memberType,applicantType);
      Uri apiUrl = Uri.parse(url);
      log("URL $TAG  --------$apiUrl");
      var response = await http.get(apiUrl,headers: loginHeader);

      final DepositInterestRateModel responseData = DepositInterestRateModel.fromJson(jsonDecode(response.body));
      log('RESPONSE $TAG >>>> ${jsonEncode(responseData)}');
      return responseData;
    }
    catch(e){
      log("$TAG error $e");
      throw Exception(e);
    }
  }

  Future<List<FDDescriptionModel>> getFDSchemeDescrRepo(String fdName) async{
    TAG = 'getFDSchemeDescrRepo';
    String applicantType="";
    String memberType="";
    MemberDetailsResponse data = await memberData();
    applicantType= data.papplicanttype;
    memberType = data.pmembertype;
    try{
      String url = ApiURL.getFdSchemeDescriptionApi(fdName,memberType,applicantType);
      Uri apiUrl = Uri.parse(url);
      log("URL $TAG  --------$apiUrl");
      var response = await http.get(apiUrl,headers: loginHeader);
      log('RESPONSE $TAG >>>> ${jsonDecode(response.body)}');

      List body= json.decode(response.body);
      return body.map((e) => FDDescriptionModel.fromJson(e)).toList();
    }
    catch(e){
      log("$TAG error $e");
      throw Exception(e);
    }
  }

  Future<List<DepositMaturityModel>> getFDMaturityAmountRepo(String interestMode,tenure,enterAmount,
      interestPayout,compoundSimpleInterestType,interestRate,calTyPe,compoundType) async{
    TAG = 'getFDMaturityAmountRepo';
    List<DepositMaturityModel> listData=[];
    try{
      String url = ApiURL.getFdMaturityAmountApi(
          interestMode: interestMode,
          tenure: tenure,
          enterAmount: enterAmount,
          interestPayOut: interestPayout,
          compoundSimpleInterestType: compoundSimpleInterestType,
          interestRate: interestRate,
          calType: calTyPe,
          compoundType: compoundType);
      Uri apiUrl = Uri.parse(url);
      log("URL $TAG  --------$apiUrl");
      var response = await http.get(apiUrl,headers: loginHeader);
      List body = json.decode(response.body);
      listData= body.map((e) => DepositMaturityModel.fromJson(e)).toList();

      log('RESPONSE $TAG >>>> ${jsonEncode(listData)}');
      return listData;
    }
    catch(e){
      log("$TAG error $e");
      throw Exception(e);
    }
  }

  Future<List<DepositeTenureModel>> getRDTenureTypeRepo(String rdName) async{
    TAG = 'getRDTenureTypeRepo';
    String applicantType="";
    String memberType="";
    MemberDetailsResponse data = await memberData();
    applicantType= data.papplicanttype;
    memberType = data.pmembertype;
    List<DepositeTenureModel> listData=[];
    try{
      String url = ApiURL.getRdTenureModesApi(rdName, applicantType, memberType);
      Uri apiUrl = Uri.parse(url);
      log("URL $TAG  --------$apiUrl");
      var response = await http.get(apiUrl,headers: loginHeader);
      List body = json.decode(response.body);
      listData= body.map((e) => DepositeTenureModel.fromJson(e)).toList();
      log('==$TAG ${listData.length}');
      return listData;
    }
    catch(e){
      log("$TAG error $e");
      throw Exception(e);
    }
  }

  Future<RDInterestDetailsModel> getRDInterestDetailsRepo(String configID,rdName,tenure,tenureMode,installmentAmount) async{
    TAG = 'getRDInterestDetailsRepo';
    String applicantType="";
    String memberType="";
    MemberDetailsResponse data = await memberData();
    applicantType= data.papplicanttype;
    memberType = data.pmembertype;
    try{
      String url = ApiURL.getRdInterestDetailsApi(applicantType, memberType,configID,rdName,tenure,tenureMode,installmentAmount);
      Uri apiUrl = Uri.parse(url);
      log("URL $TAG  --------$apiUrl");
      var response = await http.get(apiUrl,headers: loginHeader);

      final RDInterestDetailsModel responseData = RDInterestDetailsModel.fromJson(jsonDecode(response.body));
      log('RESPONSE $TAG >>>> ${jsonEncode(responseData)}');
      return responseData;
    }
    catch(e){
      log("$TAG error $e");
      throw Exception(e);
    }
  }

  Future<DepositInterestRateModel> getRDInterestTRateRepo(String rdName,instalmentAmount,tenure,tenureMode,interestPayout) async{
    TAG = 'getRDInterestTRateRepo';
    String applicantType="";
    String memberType="";
    MemberDetailsResponse data = await memberData();
    applicantType= data.papplicanttype;
    memberType = data.pmembertype;
    try{
      String url = ApiURL.getRdInterestRateApi(rdName,instalmentAmount,tenure,tenureMode,interestPayout,memberType,applicantType);
      Uri apiUrl = Uri.parse(url);
      log("URL $TAG  --------$apiUrl");
      var response = await http.get(apiUrl,headers: loginHeader);

      final DepositInterestRateModel responseData = DepositInterestRateModel.fromJson(jsonDecode(response.body));
      log('RESPONSE $TAG >>>> ${jsonEncode(responseData)}');
      return responseData;
    }
    catch(e){
      log("$TAG error $e");
      throw Exception(e);
    }
  }

  Future<List<RDDescriptionModel>> getRdDescriptionRepo(String rdName) async{
    TAG = 'getRdDescriptionRepo';
    String applicantType="";
    String memberType="";
    MemberDetailsResponse data = await memberData();
    applicantType= data.papplicanttype;
    memberType = data.pmembertype;
    try{
      String url = ApiURL.getRdDescriptionApi(rdName,memberType,applicantType);
      Uri apiUrl = Uri.parse(url);
      log("URL $TAG  --------$apiUrl");
      var response = await http.get(apiUrl,headers: loginHeader);
      log('RESPONSE $TAG >>>> ${jsonDecode(response.body)}');

      List body= json.decode(response.body);
      return body.map((e) => RDDescriptionModel.fromJson(e)).toList();
    }
    catch(e){
      log("$TAG error $e");
      throw Exception(e);
    }
  }

  Future<List<DepositMaturityModel>> getRDMaturityAmountRepo(String interestMode,tenure,enterAmount,
      interestPayout,compoundSimpleInterestType,interestRate,calTyPe,compoundType) async{
    TAG = 'getRDMaturityAmountRepo';
    List<DepositMaturityModel> listData=[];
    try{
      String url = ApiURL.getRdMaturityAmountApi(
          interestMode: interestMode,
          tenure: tenure,
          enterAmount: enterAmount,
          interestPayOut: interestPayout,
          compoundSimpleInterestType: compoundSimpleInterestType,
          interestRate: interestRate,
          calType: calTyPe,
          compoundType: compoundType);
      Uri apiUrl = Uri.parse(url);
      log("URL $TAG  --------$apiUrl");
      var response = await http.get(apiUrl,headers: loginHeader);
      List body = json.decode(response.body);
      listData= body.map((e) => DepositMaturityModel.fromJson(e)).toList();

      log('RESPONSE $TAG >>>> ${jsonEncode(listData)}');
      return listData;
    }
    catch(e){
      log("$TAG error $e");
      throw Exception(e);
    }
  }

 //LOAN EMI Calculator
  Future<List<LoanTypeModel>> getLoanTypeRepo() async{
    TAG = 'getLoanTypeRepo';
    try{
      String url = ApiURL.getLoanTypeApi;
      Uri apiUrl = Uri.parse(url);
      log("URL $TAG  --------$apiUrl");
      var response = await http.get(apiUrl,headers: loginHeader);
      log('RESPONSE $TAG >>>> ${jsonDecode(response.body)}');

      List body= json.decode(response.body);
      return body.map((e) => LoanTypeModel.fromJson(e)).toList();
    }
    catch(e){
      log("$TAG error $e");
      throw Exception(e);
    }
  }

  Future<List<LoanNameModel>> getLoanNameRepo(String loanTypeId) async{
    TAG = 'getLoanNameRepo';
    try{
      String url = ApiURL.getLoanNameApi(loanTypeId);
      Uri apiUrl = Uri.parse(url);
      log("URL $TAG  --------$apiUrl");
      var response = await http.get(apiUrl,headers: loginHeader);
      log('RESPONSE $TAG >>>> ${jsonDecode(response.body)}');

      List body= json.decode(response.body);
      return body.map((e) => LoanNameModel.fromJson(e)).toList();
    }
    catch(e){
      log("$TAG error $e");
      throw Exception(e);
    }
  }

  Future<List<DepositLoanPayInModel>> getEmiLoanPayInRepo(String loanId,schemeId) async{
    TAG = 'getEmiLoanPayInRepo';
    String applicantType="";
    MemberDetailsResponse data = await memberData();
    applicantType= data.papplicanttype;
    try{
      String url = ApiURL.getLoanPayInApi(loanId,applicantType,schemeId);
      Uri apiUrl = Uri.parse(url);
      log("URL $TAG  --------$apiUrl");
      var response = await http.get(apiUrl,headers: loginHeader);
      log('RESPONSE $TAG >>>> ${jsonDecode(response.body)}');

      List body= json.decode(response.body);
      return body.map((e) => DepositLoanPayInModel.fromJson(e)).toList();
    }
    catch(e){
      log("$TAG error $e");
      throw Exception(e);
    }
  }

  Future<List<LoanInterestRatesModel>> getLoanInterestTypeRepo(String loanId,schemeId,loanPayIn) async{
    TAG = 'getLoanInterestTypeRepo';
    String applicantType="";
    MemberDetailsResponse data = await memberData();
    applicantType= data.papplicanttype;
    try{
      String url = ApiURL.getLoanInterestTypeApi(loanId,schemeId,applicantType,loanPayIn);
      Uri apiUrl = Uri.parse(url);
      log("URL $TAG  --------$apiUrl");
      var response = await http.get(apiUrl,headers: loginHeader);
      log('RESPONSE $TAG >>>> ${jsonDecode(response.body)}');

      List body= json.decode(response.body);
      return body.map((e) => LoanInterestRatesModel.fromJson(e)).toList();
    }
    catch(e){
      log("$TAG error $e");
      throw Exception(e);
    }
  }

  Future<List<LoanInterestRatesModel>> getMinMaxLoanAmountRepo(String loanId,schemeId,loanPayIn,interestType) async{
    TAG = 'getMinMaxLoanAmountRepo';
    String applicantType="";
    MemberDetailsResponse data = await memberData();
    applicantType= data.papplicanttype;
    try{
      String url = ApiURL.getLoanMinMaxAmountApi(
        loanId: loanId,
        schemeId: schemeId,
        applicantType:applicantType,
        loanPayIn:  loanPayIn,
          interestType: interestType);
      Uri apiUrl = Uri.parse(url);
      log("URL $TAG  --------$apiUrl");
      var response = await http.get(apiUrl,headers: loginHeader);
      log('RESPONSE $TAG >>>> ${jsonDecode(response.body)}');

      List body= json.decode(response.body);
      return body.map((e) => LoanInterestRatesModel.fromJson(e)).toList();
    }
    catch(e){
      log("$TAG error $e");
      throw Exception(e);
    }
  }


  Future<List<LoanInterestRatesModel>> getLoanInterestRateRepo(String loanId,schemeId,loanPayIn,interestType,requestAmount,dateTimeNow) async {
    TAG = 'getLoanInterestRateRepo';
    String applicantType="";
    String memberType="";
    List<SchemaDetailsModel> listData=[];
    MemberDetailsResponse data = await memberData();
    applicantType= data.papplicanttype;
    memberType = data.pmembertype;

    String url = ApiURL.getLoanInterestRatePostApi;
    Uri apiUrl=Uri.parse(url);
    Map<String,dynamic> requestBody=
    {
      "pLoanid": loanId, //"1"
      "pContacttype": "INDIVIDUAL",
      "pApplicanttype": applicantType, //"Regular/General"
      "pschemeid": schemeId,
      "pLoanpayin": loanPayIn,
      "pInteresttype": interestType, //"Diminishing"
      "pAmountrequested": requestAmount,
      "pDateofapplication": dateTimeNow, //"2025-04-11T05:17:56.551Z
      "pTenureofloan": "0"
    };
    log("URL $TAG --------$apiUrl ${jsonEncode(requestBody)}");
    var response = await http.post(apiUrl,headers: loginHeader,body: jsonEncode(requestBody));
    log('RESPONSE $TAG >>>> ${response.body}');
    List body= json.decode(response.body);
    return body.map((e) => LoanInterestRatesModel.fromJson(e)).toList();
  }

  Future<List<LoanInstalmentModel>> getLoanInstalmentModeRepo(String loanId) async{
    TAG = 'getLoanInstalmentModeRepo';
    try{
      String url = ApiURL.getLoaninstalmentModeApi(loanId);
      Uri apiUrl = Uri.parse(url);
      log("URL $TAG  --------$apiUrl");
      var response = await http.get(apiUrl,headers: loginHeader);
      log('RESPONSE $TAG >>>> ${jsonDecode(response.body)}');

      List body= json.decode(response.body);
      return body.map((e) => LoanInstalmentModel.fromJson(e)).toList();
    }
    catch(e){
      log("$TAG error $e");
      throw Exception(e);
    }
  }

  Future<FinalLoanViewModel> getFinalLoanViewRepo( String loanamount,interesttype,loanpayin,interestrate,tenureofloan,loaninstalmentmode,loanId) async{
    TAG = 'getFinalLoanViewRepo';
    try{
      String url = ApiURL.getEmiLoanViewApi(
        loanamount: loanamount,
        interesttype: interesttype,
        loanpayin: loanpayin,
        interestrate: interestrate,
        tenureofloan: tenureofloan,
        loaninstalmentmode: loaninstalmentmode,
        loanId: loanId

      );
      Uri apiUrl = Uri.parse(url);
      log("URL $TAG  --------$apiUrl");
      var response = await http.get(apiUrl,headers: loginHeader);

      final FinalLoanViewModel responseData = FinalLoanViewModel.fromJson(jsonDecode(response.body));
      log('RESPONSE $TAG >>>> ${jsonEncode(responseData)}');
      return responseData;
    }
    catch(e){
      log("$TAG error $e");
      throw Exception(e);
    }
  }

}