import 'package:finsta_mac/Home/model/LoanDataResponse.dart';
import 'package:finsta_mac/components/AppWidgets.dart';
import 'package:finsta_mac/components/CustomMainBackground.dart';
import 'package:finsta_mac/utils/AppStyles.dart';
import 'package:flutter/material.dart';

import '../utils/AppText.dart';
import '../utils/GlobalFunctions.dart';
import 'TotalDuesScreen.dart';

class MyLoansScreen extends StatefulWidget {
  final List<Loanslist>? loansList;
  const MyLoansScreen(this.loansList, {super.key});

  @override
  State<MyLoansScreen> createState() => _MyLoansScreenState();
}

class _MyLoansScreenState extends State<MyLoansScreen> {
  List<bool>? isVisibleDetails=[false];
  final TextEditingController _amtController = TextEditingController();
  bool isVisiblePayBtn=false;

  getBayButton(){
    if(widget.loansList!.isNotEmpty){
      if(widget.loansList!.length < 2){
        for(int i=0;i<widget.loansList!.length;i++){
          if(widget.loansList![i].paccountdue == null || widget.loansList![i].paccountdue == 0){
            isVisiblePayBtn = false;
          }
        }

      }
    }

  }
@override
  void initState() {
    getBayButton();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CustomMainBackground(
        title: myLoans,
        bottomNavBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: (isVisiblePayBtn == false)?null:
          payButton((){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TotalDuesScreen(
                       accountType: "LOANS DUES",
                    )));
          }, payNowText),
        ),
        body: (widget.loansList!.isEmpty)?Center(child: Text('No Data',style: AppStyles.headerTextBlack,)):
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView.builder(
            itemCount: widget.loansList?.length,
            itemBuilder: (context, index) {
              Loanslist listData=widget.loansList![index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: buildCaruselCard(listData,index),
              );
            },
          ),
        )
    );
  }

  Widget buildCaruselCard(Loanslist listData, int i) {
    double gapHeight=12.0;
    double rowWidth=0.0;
    int flex=2;
    return Container(
      decoration:  borderContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                if(widget.loansList![i].isVisibleDetails == false) {
                  widget.loansList![i].isVisibleDetails = true;
                } else{
                  widget.loansList![i].isVisibleDetails = false;
                }
              });
            },
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppStyles.shadowColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(11.0), // Top left corner radius
                    topRight: Radius.circular(11.0), // Top right corner radius
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(listData.pLoantype.toString(),style: AppStyles.customTextStyle(fontSize: 13),),
                      Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon((widget.loansList![i].isVisibleDetails == false)? Icons.keyboard_arrow_down:Icons.keyboard_arrow_up),
                    )
                    ],
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(listData.pVchapplicationID.toString(),style: const TextStyle(color: Colors.black,letterSpacing: 6, fontWeight: FontWeight.bold),),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(18))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 3),
                        child: Text('(${listData.ploanstatus.toString().toUpperCase()})',style: AppStyles.statusTextStyle(fontSize: 14),),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2,),
                // Text(listData.pLoanname.toString(),style: AppStyles.highLightText),
                SizedBox(height: gapHeight,),
                Row(
                  children: [
                    Expanded(
                        flex: flex,
                        child: Text('Due',style: AppStyles.smallLabelTextBlack,)),
                    SizedBox(width: rowWidth),
                    Expanded(
                        flex: flex,
                        child:getRowText(
                            rupeeSymbol: "₹",
                            text: convertToCurrencyFormat(listData.paccountdue)
                        )
                    ),
                  ],
                ),

                Visibility(
                  visible:widget.loansList![i].isVisibleDetails!,
                  child: Column(
                    children: [
                      SizedBox(height: gapHeight,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: flex,
                              child: Text('Loan Start Date',style: AppStyles.smallLabelTextBlack,)),
                          SizedBox(width: rowWidth),
                          Expanded(
                              flex: flex,
                              child: getRowText(
                                  rupeeSymbol: "",
                                  text:(listData.pdateofapplication == "" || listData.pdateofapplication == null)?"N/A":
                                  convertDateFormatDisplay(listData.pdateofapplication.toString())
                              )),
                        ],
                      ),
                      SizedBox(height: gapHeight,),
                      Row(
                        children: [
                          Expanded(
                              flex: flex,
                              child: Text('Loan End Date',style: AppStyles.smallLabelTextBlack,)),
                          SizedBox(width: rowWidth),
                          Expanded(
                              flex: flex,
                              child: getRowText(
                                rupeeSymbol: "",
                                text:(listData.ploancloseddate == "" || listData.ploancloseddate == null)?"N/A":
                                convertDateFormatDisplay(listData.ploancloseddate.toString()),
                              )),
                        ],
                      ),
                      ( listData.pLoanname == "OVER DRAFT")?Container():
                      Column(
                        children: [
                          SizedBox(height: gapHeight,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: flex,
                                  child: Text('Next Due Date',style: AppStyles.smallLabelTextBlack,)),
                              SizedBox(width: rowWidth),
                              Expanded(
                                  flex: flex,
                                  child: getRowText(
                                      rupeeSymbol: "",
                                      text:(listData.pnextduedate == "" || listData.pnextduedate == null)?"N/A":
                                      convertDateFormatDisplay(listData.pnextduedate.toString())
                                  )),
                            ],
                          ),
                          SizedBox(height: gapHeight,),
                          Row(
                            children: [
                              Expanded(
                                  flex: flex,
                                  child: Text('Tenure',style: AppStyles.smallLabelTextBlack,)),
                              SizedBox(width: rowWidth),
                              Expanded(
                                  flex: flex,
                                  child:getRowText(
                                      rupeeSymbol: "",
                                      text:(listData.ptenure == "")?"0": listData.ptenure.toString()
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: gapHeight,),
                      Row(
                        children: [
                          Expanded(
                              flex: flex,
                              child: Text('Interest Rate',style: AppStyles.smallLabelTextBlack,)),
                          SizedBox(width: rowWidth),
                          Expanded(
                              flex: flex,
                              child: getRowText(
                                  rupeeSymbol: (listData.pInterestRate == "" || listData.pInterestRate == null)?"0":
                                  convertToCurrencyFormat(listData.pInterestRate),
                                  text:"%"
                              )),
                        ],
                      ),
                      SizedBox(height: gapHeight,),
                      Row(
                        children: [
                          Expanded(
                              flex: flex,
                              child: Text('Loan Amount',style: AppStyles.smallLabelTextBlack,)),
                          SizedBox(width: rowWidth),
                          Expanded(
                              flex: flex,
                              child: getRowText(
                                rupeeSymbol: "₹",
                                text:(listData.pTotalDisbursalamount == "" || listData.pTotalDisbursalamount == null)?"0":
                                convertToCurrencyFormat(listData.pTotalDisbursalamount),
                              )),
                        ],
                      ),
                      SizedBox(height: gapHeight,),
                      Row(
                        children: [
                          Expanded(
                              flex: flex,
                              child: Text('Installment Amount',style: AppStyles.smallLabelTextBlack,)),
                          SizedBox(width: rowWidth),
                          Expanded(
                              flex: flex,
                              child: getRowText(
                                rupeeSymbol: "₹",
                                text:(listData.pInstallmentamount == "" || listData.pInstallmentamount == null)?"0":
                                convertToCurrencyFormat(listData.pInstallmentamount),
                              )),
                        ],
                      ),
                      SizedBox(height: gapHeight,),
                      Row(
                        children: [
                          Expanded(
                              flex: flex,
                              child: Text('Sanction Amount',style: AppStyles.smallLabelTextBlack,)),
                          SizedBox(width: rowWidth),
                          Expanded(
                              flex: flex,
                              child: getRowText(
                                  rupeeSymbol: "₹",
                                  text:(listData.ploansanctionamount == "" || listData.ploansanctionamount == null)?"0":
                                  convertToCurrencyFormat(listData.ploansanctionamount)
                              )),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          // SizedBox(height: gapHeight,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Expanded(
          //         flex: flex,
          //         child: Text('$enterAmount :',style: AppStyles.smallLabelTextBlack,)),
          //     SizedBox(width: rowWidth),
          //     Expanded(
          //       flex: flex,
          //       child: Container(
          //         height: 40,
          //         child: TextFormField(
          //           controller: _amtController,
          //           maxLength: 10,
          //           keyboardType: TextInputType.number,
          //           decoration: InputDecoration(
          //             fillColor: AppStyles.gridColor,
          //             filled: true,
          //             hintText: 'Enter amount',
          //             counterText: '',
          //             hintStyle: AppStyles.smallLabelTextBlack,
          //             border: OutlineInputBorder(
          //                 borderSide: BorderSide(color: AppStyles.bgColor3,)
          //             ),
          //            focusedBorder: OutlineInputBorder(
          //                borderSide: BorderSide(color: AppStyles.bgColor3,)
          //            ),
          //             disabledBorder:  OutlineInputBorder(
          //                 borderSide: BorderSide(color: AppStyles.bgColor3,)
          //             ),
          //             enabledBorder:  OutlineInputBorder(
          //                 borderSide: BorderSide(color: AppStyles.bgColor3,)
          //             ),
          //           ),
          //           validator: (value) {
          //             if (value == null || value.isEmpty) {
          //               return 'Please enter amount';
          //             }
          //             return null;
          //           },
          //         ),
          //       ),
          //     ),
          //   ],
          // ),


        ],
      ),
    );
  }

}
