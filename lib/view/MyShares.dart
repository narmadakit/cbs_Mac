import 'package:finsta_mac/Home/model/LoanDataResponse.dart';
import 'package:finsta_mac/components/AppWidgets.dart';
import 'package:finsta_mac/components/CustomMainBackground.dart';
import 'package:finsta_mac/utils/AppStyles.dart';
import 'package:finsta_mac/utils/GlobalFunctions.dart';
import 'package:flutter/material.dart';

import '../utils/AppText.dart';
import 'TotalDuesScreen.dart';

class MySharesScreen extends StatefulWidget {
  final List<Shareslist>? loansList;
  const MySharesScreen(this.loansList, {super.key});

  @override
  State<MySharesScreen> createState() => _MySharesScreenState();
}

class _MySharesScreenState extends State<MySharesScreen> {
  bool isVisibleDetails=false;
  bool isVisiblePayBtn=false;
  // final TextEditingController _amtController = TextEditingController();

  getBayButton(){
    if(widget.loansList!.isNotEmpty) {
      if (widget.loansList!.length < 2) {
        for (int i = 0; i < widget.loansList!.length; i++) {
          if (widget.loansList![i].paccountdue == null || widget.loansList![i].paccountdue == 0) {
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
        title: myShares,
        bottomNavBar: (isVisiblePayBtn== false)?null:
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: payButton((){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TotalDuesScreen(
                      accountType: "SHARE DUES",
                    )));
          }, payNowText),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView.builder(
            itemCount: widget.loansList?.length,
            itemBuilder: (context, index) {
              Shareslist listData=widget.loansList![index];
              return buildCaruselCard(listData);
            },
          ),
        )
    );
  }

  Container buildCaruselCard(Shareslist listData) {
    double gapHeight=12.0;
    double rowWidth=0.0;
    int flex=2;
    int flex3=3;
    return Container(
      decoration:  borderContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(listData.paccountno.toString(),style: const TextStyle(color: Colors.black,letterSpacing: 6, fontWeight: FontWeight.bold),),
                // GestureDetector(
                //   onTap: () {
                //     setState(() {
                //       if(isVisibleDetails == false) {
                //         isVisibleDetails = true;
                //       } else{
                //         isVisibleDetails = false;
                //       }
                //     });
                //   },
                //   child: Row(
                //     children: [
                //       Text('Details',style: TextStyle(color: AppStyles.btnColor),),
                //       Icon(Icons.arrow_right,color: AppStyles.btnColor)
                //     ],
                //   ),
                // )
              ],
            ),

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
                        convertToCurrencyFormat(listData.paccountdue??0)
                    )),
              ],
            ),
            SizedBox(height: gapHeight,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: flex3,
                    child: Text('Branch',style: AppStyles.smallLabelTextBlack,)),
                Expanded(
                    flex: flex,
                    child:getRowText(
                        rupeeSymbol: "",
                        text:listData.pbranchname
                    )),
              ],
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
            //           controller: _amtController, // Attach controller
            //           decoration: InputDecoration(
            //             fillColor: AppStyles.gridColor,
            //             filled: true,
            //             hintText: 'Enter amount',
            //             hintStyle: AppStyles.smallLabelTextBlack,
            //             border: OutlineInputBorder(
            //                 borderSide: BorderSide(color: AppStyles.bgColor3,)
            //             ),
            //             focusedBorder: OutlineInputBorder(
            //                 borderSide: BorderSide(color: AppStyles.bgColor3,)
            //             ),
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

            Visibility(
              // visible: isVisibleDetails,
              visible: true,
              child: Column(
                children: [
                  SizedBox(height: gapHeight,),
                  Row(
                    children: [
                      Expanded(
                          flex: flex3,
                          child: Text('Face Value',style: AppStyles.smallLabelTextBlack,)),
                      Expanded(
                          flex: flex,
                          child:getRowText(
                              rupeeSymbol: "₹",
                              text: (listData.pTotalAmount == "" || listData.pTotalAmount == null)?"0":
                              convertToCurrencyFormat(listData.pTotalAmount??0)
                          )),
                    ],
                  ),
                  SizedBox(height: gapHeight,),
                  Row(
                    children: [
                      Expanded(
                          flex: flex3,
                          child: Text('No. of Shares',style: AppStyles.smallLabelTextBlack,)),
                      Expanded(
                          flex: flex,
                          child:Row(
                            children: [
                              getRowText(
                                  rupeeSymbol: "",
                                  text: listData.pNoofshares.toString()
                              ),
                              // const SizedBox(width: 20,),
                              // GestureDetector(
                              //   onTap: () {
                              //     sharesBottomSheet(context);
                              //   },
                              //   child: Container(
                              //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                              //       border: Border.all(color: AppStyles.shadowColor)),
                              //       child: const Padding(
                              //         padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 1),
                              //         child: Row(
                              //           children: [
                              //             Text('View',style: TextStyle(fontSize: 11),),
                              //             Icon(Icons.arrow_downward, size: 12,)
                              //           ],
                              //         ),
                              //       )),
                              // )
                            ],
                          )),
                    ],
                  ),
                  SizedBox(height: gapHeight,),
                  Row(
                    children: [
                      Expanded(
                          flex: flex3,
                          child: Text('Share Date',style: AppStyles.smallLabelTextBlack,)),
                      Expanded(
                          flex: flex,
                          child:getRowText(
                              rupeeSymbol: "",
                              text:(listData.pShareDate == "" || listData.pShareDate == null)?"N/A":
                              convertDateFormatDisplay(listData.pShareDate.toString())
                          )),
                    ],
                  ),
                  // SizedBox(height: gapHeight,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Expanded(
                  //         flex: flex,
                  //         child: Text('Loan Start Date :',style: AppStyles.smallLabelTextBlack,)),
                  //     SizedBox(width: rowWidth),
                  //     Expanded(
                  //         flex: flex,
                  //         child: Text('${listData.pDistictiveNumbers.toString()}',style: AppStyles.boldTextBlack,)),
                  //   ],
                  // ),
                  // SizedBox(height: gapHeight,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Expanded(
                  //         flex: flex,
                  //         child: Text('Next Due Date :',style: AppStyles.smallLabelTextBlack,)),
                  //     SizedBox(width: rowWidth),
                  //     Expanded(
                  //         flex: flex,
                  //         child: Text('${listData.pDistictiveNumbers.toString()}',style: AppStyles.boldTextBlack,)),
                  //   ],
                  // ),
                  // SizedBox(height: gapHeight,),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //         flex: flex,
                  //         child: Text('EMI Amount :',style: AppStyles.smallLabelTextBlack,)),
                  //     SizedBox(width: rowWidth),
                  //     Expanded(
                  //         flex: flex,
                  //         child: Text('₹${listData.pDistictiveNumbers.toString()}',style: AppStyles.highLightText,)),
                  //   ],
                  // ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

   sharesBottomSheet(BuildContext context) {
    return showModalBottomSheet(
                                  context: context,
                                  backgroundColor: AppStyles.shadowColor,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                  ),
                                  builder: (context) {
                                    return Container(
                                      padding: const EdgeInsets.all(16),
                                      // height: 200,
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Shares',style: AppStyles.headerMediumText,),
                                          SizedBox(height: 10,),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex:1,
                                                  child: Text("1 . ",
                                                      style: AppStyles.headerTextBlack),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text('14717',style: AppStyles.customTextStyle(fontSize: 15,color: Colors.black),)
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex:1,
                                                  child: Text("2 . ",
                                                      style: AppStyles.headerTextBlack),
                                                ),
                                                Expanded(
                                                    flex: 2,
                                                    child: Text('14718',style: AppStyles.customTextStyle(fontSize: 15,color: Colors.black),)
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 70),
                                          // ElevatedButton(
                                          //   onPressed: () => Navigator.pop(context),
                                          //   child: const Text("Close"),
                                          // ),
                                        ],
                                      ),
                                    );
                                  },
                                );
  }

}
