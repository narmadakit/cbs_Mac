import 'package:finsta_mac/Home/model/LoanDataResponse.dart';
import 'package:finsta_mac/components/CustomMainBackground.dart';
import 'package:finsta_mac/utils/AppStyles.dart';
import 'package:finsta_mac/utils/AppText.dart';
import 'package:flutter/material.dart';

import '../components/AppWidgets.dart';
import '../utils/GlobalFunctions.dart';
import 'TotalDuesScreen.dart';

class MyDepositsScreen extends StatefulWidget {
  final List<Rdlist>? rdList;
  final List<Fdslist>? fdList;
  const MyDepositsScreen(this.rdList, this.fdList, {super.key});

  @override
  State<MyDepositsScreen> createState() => _MyDepositsScreenState();
}

class _MyDepositsScreenState extends State<MyDepositsScreen> {
 bool isVisiblePayBtn = true;

 getBayButton(){
   if(widget.rdList!.isNotEmpty) {
     if (widget.rdList!.length < 2) {
       for (int i = 0; i < widget.rdList!.length; i++) {
         if (widget.rdList![i].paccountdue == null || widget.rdList![i].paccountdue == 0) {
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
    return DefaultTabController(
      length: 2,
      child: CustomMainBackground(
          title: myDeposits,
          tabBar: TabBar(
            splashBorderRadius: BorderRadius.circular(
              25.0,
            ),
            dividerColor: Colors.transparent,
            indicator:colorButtonDecoration(AppStyles.cardColor),
            automaticIndicatorColorAdjustment: true,
            unselectedLabelStyle: TextStyle(fontSize: 12,color: AppStyles.btnColor),
            labelStyle: const TextStyle(fontSize: 12,color: Colors.white),
            indicatorPadding: const EdgeInsets.all(0),
            tabs: [
              Container(
                width: double.infinity,
                  decoration: borderButtonDecoration(AppStyles.cardColor),
                  child: Tab(text: "RD")),
              Container(
                  width: double.infinity,
                  decoration: borderButtonDecoration(AppStyles.cardColor),
                  child: Tab( text: "FD")),
            ],
          ),
          body:TabBarView(
            children: [
              rdTab(),
              fdTab(),
            ],
          ),

          )
    );
  }

  Widget fdTab() {
    setState(() {
      isVisiblePayBtn = false;
    });
    return Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.builder(
                itemCount: widget.fdList?.length,
                itemBuilder: (context, index) {
                  Fdslist listData=widget.fdList![index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: buildCaruselCard(listData),
                  );
                },
              ),
            );
  }

  Widget rdTab() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.rdList?.length,
              itemBuilder: (context, index) {
                Rdlist listData=widget.rdList![index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: buildRdCard(listData),
                );
              },
            ),
          ),

          payButton(
            () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TotalDuesScreen(
                       accountType: "RD DUES",
                      )));
            }
          , 'Pay Now')
        ],
      ),
    );
  }

  Container buildCaruselCard(Fdslist listData) {
    int flex=2;
    int flex3=2;
    double gapHeight=8.0;
    return Container(
      decoration:  borderContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(listData.pFdAccountNo.toString(),style: const TextStyle(color: Colors.black,letterSpacing: 6, fontWeight: FontWeight.bold),),
            // const SizedBox(height: 2,),
            // Text('₹${listData.pDepositAmount}',style: const TextStyle(fontSize: 14,color: Colors.black)),
            SizedBox(height: gapHeight,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: flex3,
                    child: Text('Deposit Amount',style: AppStyles.smallLabelTextBlack,)),
                Expanded(
                    flex: flex,
                    child:getRowText(
                        rupeeSymbol: "₹",
                        text:  (listData.pDepositAmount == "" || listData.pDepositAmount == null)?"0":
                        convertToCurrencyFormat(listData.pDepositAmount)
                    )
                ),
              ],
            ),
            SizedBox(height: gapHeight,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: flex3,
                    child: Text('Maturity Amount',style: AppStyles.smallLabelTextBlack,)),
                Expanded(
                    flex: flex,
                    child:getRowText(
                        rupeeSymbol: "₹",
                        text:(listData.pMaturityAmount == "" || listData.pMaturityAmount == null)?"0":
                        convertToCurrencyFormat(listData.pMaturityAmount)
                    )
                ),
              ],
            ),
            SizedBox(height: gapHeight,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: flex3,
                    child: Text('Tenure',style: AppStyles.smallLabelTextBlack,)),
                Expanded(
                    flex: flex,
                    child:getRowText(
                        rupeeSymbol: "",
                        text: listData.pTenure.toString()
                    )
                ),
              ],
            ),
            SizedBox(height: gapHeight,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: flex3,
                    child: Text('Deposit Date',style: AppStyles.smallLabelTextBlack,)),
                Expanded(
                    flex: flex,
                    child:getRowText(
                        rupeeSymbol: "",
                        text: (listData.pDepositDate == "" || listData.pDepositDate == null)?"N/A":
                        convertDateFormatDisplay(listData.pDepositDate.toString())
                    )
                ),
              ],
            ),
            SizedBox(height: gapHeight,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: flex3,
                    child: Text('Maturity Date',style: AppStyles.smallLabelTextBlack,)),
                Expanded(
                    flex: flex,
                    child:getRowText(
                        rupeeSymbol: "",
                        text: (listData.pMaturityDate == "" || listData.pMaturityDate == null)?"N/A":
                        convertDateFormatDisplay(listData.pMaturityDate.toString())
                    )
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Container buildRdCard(Rdlist listData) {
    double gapHeight=8.0;
    int flex3=3;
    int flex=2;
    return Container(
      decoration: borderContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(listData.paccountno.toString(),style: const TextStyle(color: Colors.black,letterSpacing: 6, fontWeight: FontWeight.bold),),
            // const SizedBox(height: 2,),
            // Text(listData.pbranchname.toString(),style: const TextStyle(fontSize: 14,color: Colors.black)),
            SizedBox(height: gapHeight,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: flex3,
                    child: Text('Due Amount',style: AppStyles.smallLabelTextBlack,)),
                Expanded(
                    flex: flex,
                    child:getRowText(
                        rupeeSymbol: "₹",
                        text:(listData.paccountdue == "" || listData.paccountdue == null)?"0":
                        convertToCurrencyFormat(listData.paccountdue)
                    )),
              ],
            ),
            SizedBox(height: gapHeight,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: flex3,
                    child: Text('Paid Amount',style: AppStyles.smallLabelTextBlack,)),
                Expanded(
                    flex: flex,
                    child:getRowText(
                        rupeeSymbol: "₹",
                        text:(listData.paccountdue == "" || listData.paccountdue == null)?"0":
                        convertToCurrencyFormat(listData.paccountdue)
                    )),
              ],
            ),
            SizedBox(height: gapHeight,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: flex3,
                    child: Text('Deposit Amount',style: AppStyles.smallLabelTextBlack,)),
                Expanded(
                    flex: flex,
                    child:getRowText(
                        rupeeSymbol: "₹",
                        text: (listData.pDepositamount == "" || listData.pDepositamount == null)?"0":
                        convertToCurrencyFormat(listData.pDepositamount??0)
                    )),
              ],
            ),
            SizedBox(height: gapHeight,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: flex3,
                    child: Text('Maturity Amount',style: AppStyles.smallLabelTextBlack,)),
                Expanded(
                    flex: flex,
                    child:getRowText(
                        rupeeSymbol: "₹",
                        text:(listData.pMaturityamount == "" || listData.pMaturityamount == null)?"0":
                        convertToCurrencyFormat(listData.pMaturityamount??0)
                    )),
              ],
            ),
            SizedBox(height: gapHeight,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: flex3,
                    child: Text('Installment Amount',style: AppStyles.smallLabelTextBlack,)),

                Expanded(
                    flex: flex,
                    child:
                    getRowText(
                        rupeeSymbol: "₹",
                        text: (listData.pInstalmentamount == "" || listData.pInstalmentamount == null)?"0":
                        convertToCurrencyFormat(listData.pInstalmentamount)
                    )),
              ],
            ),
            SizedBox(height: gapHeight,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: flex3,
                    child: Text('Tenure',style: AppStyles.smallLabelTextBlack,)),
                Expanded(
                    flex: flex,
                    child:getRowText(
                        rupeeSymbol: "",
                        text: listData.pTenure
                    )),
              ],
            ),
            SizedBox(height: gapHeight,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: flex3,
                    child: Text('Deposit Date',style: AppStyles.smallLabelTextBlack,)),
                Expanded(
                    flex: flex,
                    child:getRowText(
                        rupeeSymbol: "",
                        text:  (listData.pDepositdate == "" || listData.pDepositdate == null)?"N/A":
                        convertDateFormatDisplay(listData.pDepositdate.toString())
                    )),
              ],
            ),
            SizedBox(height: gapHeight,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: flex3,
                    child: Text('Maturity Date',style: AppStyles.smallLabelTextBlack,)),
                Expanded(
                    flex: flex,
                    child:getRowText(
                        rupeeSymbol: "",
                        text: (listData.pMaturitydate == "" || listData.pMaturitydate == null)?"N/A":
                        convertDateFormatDisplay(listData.pMaturitydate.toString())
                    )),
              ],
            ),

          ],
        ),
      ),
    );
  }

}
