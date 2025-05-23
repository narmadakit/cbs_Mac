
import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:finsta_mac/Home/bloc/HomeBloc.dart';
import 'package:finsta_mac/Home/bloc/HomeEvent.dart';
import 'package:finsta_mac/Home/model/BanneImageModel.dart';
import 'package:finsta_mac/Home/model/LoanDataResponse.dart';
import 'package:finsta_mac/network/Repository.dart';
import 'package:finsta_mac/utils/AppStyles.dart';
import 'package:finsta_mac/view/MyDepositeScreen.dart';
import 'package:finsta_mac/view/MyLoansScreen.dart';
import 'package:finsta_mac/view/TotalDuesScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Home/bloc/HomeState.dart';
import '../Home/model/MembersAllDuesModel.dart';
import '../components/AppWidgets.dart';
import '../components/CustomMainBackground.dart';
import '../utils/AppText.dart';
import '../utils/GlobalFunctions.dart';
import '../utils/SharedPrefs.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  LoanDataResponse loanData=LoanDataResponse();
  bool loadingVisibility = false;
  bool bannerVisibility = true;
  bool duesLoadingVisibility = true;
  List<Savingslist>? savingLoan=[];
  List<BannerImageModel> bannerImageList=[];
  List<MembersAllDuesModel>? duesLoanList=[];
  double totalDuesListAmt=0;
  String memberName="";

  @override
  void initState() {
    getMemberDetails();
    super.initState();
  }

  getMemberDetails() async {
    memberName = await SharedPrefs.getString(SharedPrefs.memberName);
    _selectedIndex =0;
  }

  Future<void> refresh() async {
    // buildContext?.read<ExistHomeBloc>().add(GetContactData());
    Navigator.push(context, MaterialPageRoute(builder: (builder)=>const DashboardScreen()));
  }

  // final List<String> imageUrls = [
  //   'https://graphicsfamily.com/wp-content/uploads/2020/06/Bank-Service-Web-Banner-1180x664.jpg',
  //   'https://graphicsfamily.com/wp-content/uploads/2020/06/Bank-Service-Web-Banner-1180x664.jpg',
  //   'https://graphicsfamily.com/wp-content/uploads/2020/06/Bank-Service-Web-Banner-1180x664.jpg',
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            // Color(0xffd8b9fb),
            AppStyles.bgColor1,
            AppStyles.bgColor2,
            AppStyles.bgColor3,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(create: (context) => HomeBloc(Repository())..add(HomeInitSEvent(),))
        ],
        child: BlocConsumer<HomeBloc,HomeState>(
          listener: (context, state) {
            if(state is HomeLoadingState){
              loadingVisibility = true;
              bannerVisibility = true;
            }
            else if(state is HomeSuccessState){
              loanData = state.responseData;
              savingLoan=loanData.savingslist;
              loadingVisibility = false;
              context.read<HomeBloc>().add(GetAllDuesEvent());
            }
            else if(state is BannerImageSuccessState){
              bannerImageList=state.responseData;
              bannerVisibility = false;
            }
            else if(state is AllDuesSuccessState){
              duesLoanList = state.responseData;
              duesLoadingVisibility = false;
            }
          },
          builder:  (BuildContext context, state) {
            if(state is HomeLoadingState){
              return Center(child: CircularProgressIndicator(color: AppStyles.btnColor));
            }
            else if(state is HomeSuccessState){
              loanData = state.responseData;
              savingLoan=loanData.savingslist;
              return blocBuilderBody();
            }
            else if(state is BannerImageSuccessState){
              bannerImageList = state.responseData;
              return blocBuilderBody();
            }
            else if(state is AllDuesSuccessState){
              duesLoanList =state.responseData;
              return blocBuilderBody();
            }
            else{
              return Center(child: CircularProgressIndicator(color: AppStyles.btnColor),);
            }
          },
        ),
      ),
    );
  }

  Widget blocBuilderBody(){
    return CustomMainBackground(
      title1: ', ${memberName}',
    title: 'Hi',
    isBackButton: false,
    bottomNavBar: bottomNavBar(
      context: context,
      selectedIndex: _selectedIndex,
    ),
      body:
      RefreshIndicator(
        onRefresh: refresh,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 5),
          child: ListView(
              children: [
                (bannerVisibility)?
                Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(color: AppStyles.btnColor),
                )):
                CarouselSlider.builder(
                  carouselController: _controller,
                  itemCount: bannerImageList.length,
                  itemBuilder: (context, index, realIndex) {
                    Uint8List? bytesLogo;
                    if (bannerImageList[index].pschemepath != null && bannerImageList[index].pschemepath!.isNotEmpty) {
                      bytesLogo = base64Decode(bannerImageList[index].pschemeimagepath.toString());
                    }
                    return buildCaruselBanner(index,bytesLogo);
                  },
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: bannerImageList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: (_current == entry.key)? 15.0:6.0,
                        height: 5.0,
                        margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:(_current == entry.key)? AppStyles.btnColor : AppStyles.shadowColor ),
                      ),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 5),
                  child: Column(
                    children: [
                      CarouselSlider.builder(
                        carouselController: _controller,
                        itemCount: savingLoan?.length,
                        itemBuilder: (context, index, realIndex) {
                          Savingslist savingData=savingLoan![index];
                          return buildCaruselCard(savingData);
                        },
                        options: CarouselOptions(
                            autoPlay: false,
                            enlargeCenterPage: true,
                            aspectRatio: 2.1,
                            viewportFraction: 1,
                            enableInfiniteScroll: false,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: savingLoan!.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
                            child: Container(
                              width: 20.0,
                              height: 2.0,
                              margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: (_current == entry.key
                                      ? AppStyles.btnColor
                                      : AppStyles.shadowColor)
                                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                            ),
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: buildGrids(myLoans,"assets/icons/loan.png",(){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyLoansScreen(
                                                loanData.loanslist
                                            )));
                                  }),
                                ),
                                const SizedBox(width: 20,),
                                Expanded(
                                  child: buildGrids(myDepositsText,"assets/images/deposit1.png",(){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyDepositsScreen(
                                              loanData.rdlist,loanData.fdslist,
                                            )));
                                  }),
                                ),
                              ],
                            ),
                            // const SizedBox(height: 20,),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Expanded(
                            //       child: buildGrids(applyLoan,"assets/icons/newLoan.png",(){
                            //         showSnackBar(context, 'Coming Soon!');
                            //       }),
                            //     ),
                            //     const SizedBox(width: 20,),
                            //     Expanded(child: buildGrids(myShares,"assets/images/shares.png",(){
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) => MySharesScreen(
                            //                   loanData.shareslist
                            //               )));
                            //     })),
                            //   ],
                            // ),
                            const SizedBox(height: 20,),
                            duesLoadingVisibility?CircularProgressIndicator(color: AppStyles.btnColor,): totalDueContainer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ]
          ),
        ),
      ),
    );
  }


  Widget totalDueContainer() {
    totalDuesListAmt=0;
    for(var i =0;i<duesLoanList!.length;i++){
      totalDuesListAmt += duesLoanList![i].pdueamount;
    }
    print('=====sum $totalDuesListAmt');
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TotalDuesScreen(
                  accountType: "",
                )));
      },
      child: Container(
                height: 80,
                decoration: BoxDecoration(
                    color: AppStyles.gridColor,
                    borderRadius: AppStyles.borderRadiusCircular,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            circularBorderImage("assets/icons/dueLoan.png"),
                            const SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(totalDuesText,style: AppStyles.smallLabelTextBlack,),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    getRuppeText(fontSize: 15),
                                    Text('${convertToCurrencyFormat(totalDuesListAmt)}',style: const TextStyle(fontWeight: FontWeight.w600),),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child:
                        payButton(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TotalDuesScreen(
                                    accountType: "",
                                  )));
                        },"Details")
                      )
                    ],
                  ),
                ),
              ),
    );
  }

  Widget buildCaruselCard(Savingslist savingData) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        color:   AppStyles.cardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${savingData.poatype??""} ACCOUNT',style: const TextStyle(fontSize: 14,color: Colors.white),),
                    Row(
                      children: [
                        Text(savingData.pSavingaccountno??"",style: const TextStyle(color: Colors.white,letterSpacing: 6, fontWeight: FontWeight.bold),),
                        IconButton(
                       padding: EdgeInsets.all(0),
                       onPressed: () {
                         Clipboard.setData(ClipboardData(text: savingData.pSavingaccountno.toString())).then((_) {
                           ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(content: Text('Text copied to clipboard!')),
                           );
                         });
                       },
                       icon: const Icon(Icons.copy_all,size: 18),
                         color: Colors.grey,)
                      ],
                    ),
                  ],
                ),
                Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(availableBalance,style: AppStyles.smallLabelText,),
                    const SizedBox(height: 2,),
                    Row(
                      children: [
                        getRuppeText(fontSize: 15,color: AppStyles.gridColor),
                        Text('${convertToCurrencyFormat(savingData.paccountbalance)}',style: AppStyles.customTextStyle(color: AppStyles.gridColor, fontSize: 15),),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(savingData.pAccountstatus??"",style: AppStyles.customTextStyle(color: Colors.amber.shade800)),
                Image.asset("assets/images/bank2.png",height: 40,color: Colors.white,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCaruselBanner(int index, Uint8List? bytesLogo) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: AppStyles.bgColor1,
      ),

      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            // child: Image.asset("assets/images/banner.jpeg",fit: BoxFit.cover,
            //   width: double.infinity)
            child:
            Image.memory(bytesLogo!,
              width: double.infinity,
              fit: BoxFit.contain,)

        ),
      ),
    );
  }


}
