class ApiURL{
  static String BASE_URL ="http://13.201.200.0:8386/";
  static String getMemberDataByMobile(String mobile) => "${BASE_URL}api/MobileAPP/Getmemberdatabymobileno?pmobileno=$mobile";
  static String getMembersSummaryByMemberId(String memberId) => "${BASE_URL}api/MobileAPP/GetMembersummarybymemberid?pmemberid=$memberId";
  static String getLoginOtp ="${BASE_URL}api/MobileAPP/SaveLoginOTPDetails";
  static String validateLoginOtp(String mobile,String otp,String date) => "${BASE_URL}api/MobileAPP/ValidateLoginOTP?pMobileno=$mobile&potp=$otp&pdate=$date";
  static String getMemberAllDues(String memberId,String date) => "${BASE_URL}api/MobileAPP/GetMemberaganist_allDues?pmemberid=$memberId&ptransdate=$date";
  static String getCompanyDetails= "${BASE_URL}api/Settings/GetcompanyNameandaddressDetails";
  static String getBannerImages= "${BASE_URL}api/MobileAPP/GetClientSchemes?prequestfrom=mobile";


  //Emi calculator
  //FD
  static String getAllTransactionsSchemes(String formName,applicantType,memberType) => "${BASE_URL}api/Banking/GetAllTransactionsSchemes?FormName=$formName&ApplicantType=$applicantType&MemberType=$memberType";
  static String getFdTenureModesApi(String fdName,applicantType,memberType) => "${BASE_URL}api/Banking/GetFdSchemeTenureModes?Fdname=$fdName&ApplicantType=$applicantType&MemberType=$memberType";
  static String getFdInterestDetailsApi(String applicantType,memberType,fdConfigID,fdName,tenure,tenureMode,depositAmount) => "${BASE_URL}api/Banking/GetFdSchemeDetails?ApplicantType=$applicantType&MemberType=$memberType&FdconfigID=$fdConfigID&Fdname=$fdName&Tenure=$tenure&Tenuremode=$tenureMode&Depositamount=$depositAmount";
  static String getFdInterestRateApi(String fdName,depositAmount,tenure,tenureMode,interestPayout,memberType,applicantType) => "${BASE_URL}api/Banking/GetTenureandMininterestRateofInterestRate?Fdname=$fdName&Depositamount=$depositAmount&Tenure=$tenure&TenureMode=$tenureMode&InterestPayout=$interestPayout&MemberType=$memberType&papplicanttype=$applicantType";
  static String getFdSchemeDescriptionApi(String fdName,memberType,applicantType) => "${BASE_URL}api/Banking/GetFdSchemeDetailsforGrid?Fdname=$fdName&ApplicantType=$applicantType&MemberType=$memberType";

  static String getFdMaturityAmountApi({required String interestMode, tenure, enterAmount, interestPayOut, compoundSimpleInterestType, interestRate, calType, compoundType}) =>
      "${BASE_URL}api/Banking/GetFDMaturityamount?pInterestMode=$interestMode&pInterestTenure=$tenure&pDepositAmount=$enterAmount&pInterestPayOut=$interestPayOut&pCompoundorSimpleInterestType=$compoundSimpleInterestType&pInterestRate=$interestRate&pCalType=$calType&pcompoundtype=$compoundType";

  //RD
  static String getRdTenureModesApi(String rdName,applicantType,memberType) => "${BASE_URL}api/Banking/GetRdSchemeTenureModes?Rdname=$rdName&ApplicantType=$applicantType&MemberType=$memberType";
  static String getRdInterestDetailsApi(String applicantType,memberType,configID,rdName,tenure,tenureMode,instalmentAmount) => "${BASE_URL}api/Banking/GetRdSchemeDetails?ApplicantType=$applicantType&MemberType=$memberType&RdconfigID=$configID&Rdname=$rdName&Tenure=$tenure&Tenuremode=$tenureMode&instalmentamount=$instalmentAmount";
  static String getRdInterestRateApi(String rdName,installmentAmount,tenure,tenureMode,interestPayout,memberType,applicantType) => "${BASE_URL}api/Banking/GetRDTenureandMininterestRateofInterestRate?Rdname=$rdName&instalmentamount=$installmentAmount&Tenure=$tenure&TenureMode=$tenureMode&InterestPayout=$interestPayout&MemberType=$memberType&papplicanttype=$applicantType";
  static String getRdMaturityAmountApi({required String interestMode, tenure, enterAmount, interestPayOut, compoundSimpleInterestType, compoundType, interestRate, calType}) =>
      "${BASE_URL}api/Banking/GetRDMaturityamount?pInterestMode=$interestMode&pInterestTenure=$tenure&instalmentamount=$enterAmount&pInterestPayOut=$interestPayOut&pCompoundorSimpleInterestType=$compoundSimpleInterestType&pCompoundType=$compoundType&pInterestRate=$interestRate&pCalType=$calType";
  static String getRdDescriptionApi(String rdName,memberType,applicantType) => "${BASE_URL}api/Banking/GetRdSchemeDetailsforGrid?Rdname=$rdName&ApplicantType=$applicantType&MemberType=$memberType";

  //LOANs
  static String getLoanTypeApi = "${BASE_URL}api/loans/masters/loanmaster/getfiLoanTypes";
  static String getLoanNameApi(String loanTypeId) => "${BASE_URL}api/loans/masters/loanmaster/getLoanNames?loanTypeId=$loanTypeId";
  static String getLoanPayInApi(String loanId,applicantType,schemeId) => "${BASE_URL}api/loans/Transactions/Firstinformation/GetLoanpayin?Loanid=$loanId&Contacttype=Individual&Applicanttype=$applicantType&schemeid=$schemeId";
  static String getLoanMinMaxAmountApi(String loanId,applicantType,loanPayIn,schemeId,interestType) => "${BASE_URL}api/loans/Transactions/Firstinformation/GetLoanMinandmaxAmounts?Loanid=$loanId&Contacttype=Individual&Applicanttype=$applicantType&Loanpayin=$loanPayIn&schemeid=$schemeId&interesttype=$interestType";
  static String getLoanInterestRatePostApi  = "${BASE_URL}api/loans/Transactions/Firstinformation/GetInterestRates";
  static String getLoanInterestTypeApi(String loanId,schemeId,applicantType,loanPayIn) => "${BASE_URL}api/loans/Transactions/Firstinformation/GetLoanInterestTypes?Loanid=$loanId&schemeid=$schemeId&Contacttype=Individual&Applicanttype=$applicantType&Loanpayin=$loanPayIn";
  static String getLoaninstalmentModeApi(String loanId) => "${BASE_URL}api/loans/Transactions/Firstinformation/getLoaninstalmentmodesbyloanid?ploanid=$loanId";
  static String getEmiLoanViewApi({required String loanamount, interesttype, loanpayin, interestrate, tenureofloan, loaninstalmentmode, loanId}) => "${BASE_URL}api/loans/Transactions/Firstinformation/GetFiEmiSchesuleview?loanamount=$loanamount&interesttype=$interesttype&loanpayin=$loanpayin&interestrate=$interestrate&tenureofloan=$tenureofloan&Loaninstalmentmode=$loaninstalmentmode&emiprincipalpayinterval=0&emitype=REGULAR&loanid=$loanId";
}