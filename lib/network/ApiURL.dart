class ApiURL{
  static String BASE_URL ="http://13.201.200.0:8386/";
  static String getMemberDataByMobile(String mobile) => "${BASE_URL}api/MobileAPP/Getmemberdatabymobileno?pmobileno=$mobile";
  static String getMembersSummaryByMemberId(String memberId) => "${BASE_URL}api/MobileAPP/GetMembersummarybymemberid?pmemberid=$memberId";
  static String getLoginOtp ="${BASE_URL}api/MobileAPP/SaveLoginOTPDetails";
  static String validateLoginOtp(String mobile,String otp,String date) => "${BASE_URL}api/MobileAPP/ValidateLoginOTP?pMobileno=$mobile&potp=$otp&pdate=$date";
  static String getMemberAllDues(String memberId,String date) => "${BASE_URL}api/MobileAPP/GetMemberaganist_allDues?pmemberid=$memberId&ptransdate=$date";
  static String getCompanyDetails= "${BASE_URL}api/Settings/GetcompanyNameandaddressDetails";

  //Emi calculator
  static String getAllTransactionsSchemes(String formName,applicantType,memberType) => "${BASE_URL}api/Banking/GetAllTransactionsSchemes?FormName=$formName&ApplicantType=$applicantType&MemberType=$memberType";
  static String getFdTenureModesApi(String fdName,applicantType,memberType) => "${BASE_URL}api/Banking/GetFdSchemeTenureModes?Fdname=$fdName&ApplicantType=$applicantType&MemberType=$memberType";
  static String getFdInterestDetailsApi(String applicantType,memberType,fdConfigID,fdName,tenure,tenureMode,depositAmount) => "${BASE_URL}api/Banking/GetFdSchemeDetails?ApplicantType=$applicantType&MemberType=$memberType&FdconfigID=$fdConfigID&Fdname=$fdName&Tenure=$tenure&Tenuremode=$tenureMode&Depositamount=$depositAmount";
  static String getFdInterestRateApi(String fdName,depositAmount,tenure,tenureMode,interestPayout,memberType,applicantType) => "${BASE_URL}api/Banking/GetTenureandMininterestRateofInterestRate?Fdname=$fdName&Depositamount=$depositAmount&Tenure=$tenure&TenureMode=$tenureMode&InterestPayout=$interestPayout&MemberType=$memberType&papplicanttype=$applicantType";
  static String getFdSchemeDescriptionApi(String fdName,memberType,applicantType) => "${BASE_URL}api/Banking/GetFdSchemeDetailsforGrid?Fdname=$fdName&ApplicantType=$applicantType&MemberType=$memberType";

  static String getFdMaturityAmountApi({required String interestMode, tenure, enterAmount, interestPayOut, compoundSimpleInterestType, interestRate, calType, compoundType}) =>
      "${BASE_URL}api/Banking/GetFDMaturityamount?pInterestMode=$interestMode&pInterestTenure=$tenure&pDepositAmount=$enterAmount&pInterestPayOut=$interestPayOut&pCompoundorSimpleInterestType=$compoundSimpleInterestType&pInterestRate=$interestRate&pCalType=$calType&pcompoundtype=$compoundType";

  static String getRdTenureModesApi(String rdName,applicantType,memberType) => "${BASE_URL}api/Banking/GetRdSchemeTenureModes?Rdname=$rdName&ApplicantType=$applicantType&MemberType=$memberType";
  static String getRdInterestDetailsApi(String applicantType,memberType,configID,rdName,tenure,tenureMode,instalmentAmount) => "${BASE_URL}api/Banking/GetRdSchemeDetails?ApplicantType=$applicantType&MemberType=$memberType&RdconfigID=$configID&Rdname=$rdName&Tenure=$tenure&Tenuremode=$tenureMode&instalmentamount=$instalmentAmount";
  static String getRdInterestRateApi(String rdName,installmentAmount,tenure,tenureMode,interestPayout,memberType,applicantType) => "${BASE_URL}api/Banking/GetRDTenureandMininterestRateofInterestRate?Rdname=$rdName&instalmentamount=$installmentAmount&Tenure=$tenure&TenureMode=$tenureMode&InterestPayout=$interestPayout&MemberType=$memberType&papplicanttype=$applicantType";
  static String getRdMaturityAmountApi(String interestMode,tenure,instalmentAmount,interestPayOut,compoundSimpleInterestType,compoundType,interestRate,calType) => "${BASE_URL}api/Banking/getRdMaturityAmountApi?pInterestMode=$interestMode&pInterestTenure=$tenure&instalmentamount=$instalmentAmount&pInterestPayOut=$interestPayOut&pCompoundorSimpleInterestType=$compoundSimpleInterestType&pCompoundType=$compoundType&pInterestRate=$interestRate&pCalType=$calType";
  static String getRdDescriptionApi(String rdName,memberType,applicantType) => "${BASE_URL}api/Banking/GetRdSchemeDetailsforGrid?Rdname=$rdName&ApplicantType=$applicantType&MemberType=$memberType";

}