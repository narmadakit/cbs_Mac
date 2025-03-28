class ApiURL{
  static String BASE_URL ="http://13.201.200.0:8390/";
  static String getMemberDataByMobile(String mobile) => "${BASE_URL}api/MobileAPP/Getmemberdatabymobileno?pmobileno=$mobile";
  static String getMembersSummaryByMemberId(String memberId) => "${BASE_URL}api/MobileAPP/GetMembersummarybymemberid?pmemberid=$memberId";
  static String getLoginOtp ="${BASE_URL}api/MobileAPP/SaveLoginOTPDetails";
  static String validateLoginOtp(String mobile,String otp,String date) => "${BASE_URL}api/MobileAPP/ValidateLoginOTP?pMobileno=$mobile&potp=$otp&pdate=$date";
  static String getMemberAllDues(String memberId,String date) => "${BASE_URL}api/MobileAPP/GetMemberaganist_allDues?pmemberid=$memberId&ptransdate=$date";
  static String getCompanyDetails= "${BASE_URL}api/Settings/GetcompanyNameandaddressDetails";

  //Emi calculator
  static String getAllTransactionsSchemes(String formName,applicantType,memberType) => "${BASE_URL}api/Banking/GetAllTransactionsSchemes?FormName=$formName&ApplicantType=$applicantType&MemberType=$memberType";
  static String getFdTenureModes(String fdName,applicantType,memberType) => "${BASE_URL}api/Banking/GetFdSchemeTenureModes?Fdname=$fdName&ApplicantType=$applicantType&MemberType=$memberType";

}