import 'package:finsta_mac/Home/bloc/HomeEvent.dart';
import 'package:finsta_mac/Home/bloc/HomeState.dart';
import 'package:finsta_mac/Home/model/LoanDataResponse.dart';
import 'package:finsta_mac/Home/model/MembersAllDuesModel.dart';
import 'package:finsta_mac/components/AppWidgets.dart';
import 'package:finsta_mac/components/CustomMainBackground.dart';
import 'package:finsta_mac/utils/AppStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Home/bloc/HomeBloc.dart';
import '../network/Repository.dart';
import '../utils/AppText.dart';
import '../utils/CurrencyFormatText.dart';
import '../utils/GlobalFunctions.dart';

class TotalDuesScreen extends StatefulWidget {
  final List? loansList;
  final String? accountType;
  const TotalDuesScreen({super.key,this.loansList,this.accountType});

  @override
  State<TotalDuesScreen> createState() => _TotalDuesScreenState();
}

class _TotalDuesScreenState extends State<TotalDuesScreen> {
  bool isVisibleDetails=false;
  final List<TextEditingController> _amtController = [];
  List<MembersAllDuesModel> allDuesList=[];

  @override
  Widget build(BuildContext context) {
    print("====== loan type ${widget.accountType}");
    return CustomMainBackground(
        title: totalDuesText,
        // bottomNavBar: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child:
        //   payButton((){
        //     // Navigator.push(
        //     //     context,
        //     //     MaterialPageRoute(
        //     //         builder: (context) => TotalDuesScreen(
        //     //
        //     //         )));
        //   }, payNowText),
        // ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<HomeBloc>(create: (context) => HomeBloc(Repository())..add(GetAllDuesEvent(),))
          ],
          child: BlocConsumer<HomeBloc,HomeState>(
            builder: (context, state) {
              if(state is AllDuesLoadingState){
                return Center(child: CircularProgressIndicator(color: AppStyles.btnColor));
              }
              else if(state is AllDuesSuccessState){
                allDuesList = state.responseData;
                return blocBuilderBody(allDuesList);
              }
              else{
                return Center(child: CircularProgressIndicator(color: AppStyles.btnColor));
              }
            },
            listener: (context, state) { },
          ),
        )
    );
  }

  Widget blocBuilderBody(List<MembersAllDuesModel> allDuesList){
    if(widget.accountType != ""){
      List<MembersAllDuesModel> filteredList = allDuesList.where((item) => item.paccounttype == widget.accountType).toList();
      allDuesList = filteredList;
    }

    return (allDuesList.isEmpty)? Center(child: Text("No Data",style: AppStyles.headerTextBlack)):
      Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
        itemCount: allDuesList.length,
        itemBuilder: (context, index) {
          _amtController.add(TextEditingController());
          print("=======widget.accountType ${widget.accountType}");
            return buildCaruselCard(allDuesList,index);
        },
      ),
    );
  }

  Widget buildCaruselCard(List<MembersAllDuesModel> dueListData, int index) {
    double gapHeight=12.0;
    double rowWidth=0.0;
    int flex=2;
    MembersAllDuesModel listData = dueListData[index];
    return
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration:  borderContainer,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(listData.paccountname.toString(),style: const TextStyle(color: Colors.black,letterSpacing: 6, fontWeight: FontWeight.bold),),
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
              SizedBox(height: gapHeight),
              Text(listData.paccounttype.toString(),style: AppStyles.highLightText),
              SizedBox(height: gapHeight,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: flex,
                      child: Text('Due Amount',style: AppStyles.smallLabelTextBlack,)),
                  Expanded(
                      flex: flex,
                      child:getRowText(
                          rupeeSymbol: "₹",
                          text:(listData.pdueamount == "" || listData.pdueamount == null)?"0":
                          convertToCurrencyFormat(listData.pdueamount??0)
                      )),
                ],
              ),
              SizedBox(height: gapHeight,),
              Row(
                children: [
                  Expanded(
                      flex: flex,
                      child: Text('Branch :',style: AppStyles.smallLabelTextBlack,)),
                  Expanded(
                      flex: flex,
                      child:getRowText(
                          rupeeSymbol: "",
                          text: capitalize(listData.pbranchname??"")
                      )),
                ],
              ),
              SizedBox(height: gapHeight,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: flex,
                      child: Text('$enterAmount',style: AppStyles.smallLabelTextBlack,)),
                  Text(': '),
                  Expanded(
                    flex: flex,
                    child: Container(
                      height: 40,
                      child: TextFormField(
                        style:  AppStyles.boldTextBlack,
                        keyboardType: TextInputType.number,
                        controller: _amtController[index],
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyInputFormatter(),
                        ],
                        decoration: InputDecoration(
                          fillColor: AppStyles.gridColor,
                          filled: true,
                          hintText: 'Enter amount',
                          hintStyle: AppStyles.smallLabelTextBlack,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppStyles.bgColor3,)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppStyles.bgColor3,)
                          ),
                          disabledBorder:  OutlineInputBorder(
                              borderSide: BorderSide(color: AppStyles.bgColor3,)
                          ),
                          enabledBorder:  OutlineInputBorder(
                              borderSide: BorderSide(color: AppStyles.bgColor3,)
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter amount';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }

}
