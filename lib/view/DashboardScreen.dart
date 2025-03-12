
import 'package:carousel_slider/carousel_slider.dart';
import 'package:finsta_mac/Home/bloc/HomeBloc.dart';
import 'package:finsta_mac/Home/bloc/HomeEvent.dart';
import 'package:finsta_mac/Home/model/LoanDataResponse.dart';
import 'package:finsta_mac/Profile/ProfileScreen.dart';
import 'package:finsta_mac/network/Repository.dart';
import 'package:finsta_mac/utils/AppStyles.dart';
import 'package:finsta_mac/view/MyDepositeScreen.dart';
import 'package:finsta_mac/view/MyLoansScreen.dart';
import 'package:finsta_mac/view/MyShares.dart';
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
  late int _selectedIndex = 0;
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  LoanDataResponse loanData=LoanDataResponse();
  bool loadingVisibility = false;
  bool duesLoadingVisibility = true;
  List<Savingslist>? savingLoan=[];
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
  }

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
              print("=====HomeLoadingState listener ");
              loadingVisibility = true;
            }
            else if(state is HomeSuccessState){
              print("=====HomeSuccessState listener ");
              loanData = state.responseData;
              savingLoan=loanData.savingslist;
              loadingVisibility = false;
              context.read<HomeBloc>().add(GetAllDuesEvent());
            }
            else if(state is AllDuesSuccessState){
              print("=====AllDuesSuccessState listener ");
              duesLoanList = state.responseData;
              duesLoadingVisibility = false;
            }
          },
          builder:  (BuildContext context, state) {
            if(state is HomeLoadingState){
              print("=======HomeLoadingState builder ");
              return Center(child: CircularProgressIndicator(color: AppStyles.btnColor));
            }
            else if(state is HomeSuccessState){
              print("=======HomeSuccessState Builder ");
              loanData = state.responseData;
              savingLoan=loanData.savingslist;
              return blocBuilderBody();
            }
            else if(state is AllDuesSuccessState){
              print("=======AllDuesSuccessState Builder ");
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
    bottomNavBar: Container(
    margin: const EdgeInsets.only(bottom: 5,left: 0,right: 0),
    padding: const EdgeInsets.only(top: 3),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    boxShadow:  [
    BoxShadow(color: AppStyles.shadowColor, spreadRadius: 0, blurRadius: 10),
    ],
    ),
    child: ClipRRect(
    borderRadius: BorderRadius.circular(30),
    child: BottomNavigationBar(
    backgroundColor: AppStyles.btnColor,
    type: BottomNavigationBarType.fixed,
    currentIndex: _selectedIndex,
    unselectedLabelStyle: const TextStyle(color: Colors.grey,fontSize: 12),
    unselectedItemColor: Colors.white,
    selectedItemColor: Colors.white,
    showUnselectedLabels: true,
    showSelectedLabels: true,
    onTap: (index) {
    setState(() {
    _selectedIndex = index;

    if(_selectedIndex == 1){
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => MyLoansScreen(
    loanData.loanslist
    )));
    }
    if(_selectedIndex == 2){
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => MyDepositsScreen(
    loanData.rdlist,loanData.fdslist
    )));
    }
    if(_selectedIndex == 3){
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => const ProfileScreen(
    )));
    }
    });
    },
    selectedLabelStyle: const TextStyle(color: Colors.grey,fontSize: 11),
    items: const [
    BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined,size: 20,),
    label: home,
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.home_repair_service_outlined,size: 20),
    label: loans,
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.savings_outlined,size: 20),
    label: deposits,
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.account_circle_outlined,size: 20),
    label: profile,
    ),
    ],
    ),
    )
    ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
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
                    aspectRatio: 1.9,
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
                          color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : AppStyles.imageBgColor)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
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
                          child: buildGrids(myDeposits,"assets/images/deposit1.png",(){
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
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: buildGrids(applyLoan,"assets/icons/newLoan.png",(){
                            showSnackBar(context, 'Coming Soon!');
                          }),
                        ),
                        const SizedBox(width: 20,),
                        Expanded(child: buildGrids(myShares,"assets/images/shares.png",(){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MySharesScreen(
                                      loanData.shareslist
                                  )));
                        })),
                      ],
                    ),
                    const SizedBox(height: 20,),
                   duesLoadingVisibility?CircularProgressIndicator(color: AppStyles.btnColor,): totalDueContainer(),
                  ],
                ),
              ),
            ]
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
                height: 90,
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
                              children: [
                                Text(totalDuesText,style: AppStyles.smallLabelTextBlack,),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    getRuppeText(fontSize: 15),
                                    Text('${convertToCurrencyFormat(totalDuesListAmt)}',style: TextStyle(fontWeight: FontWeight.w600),),
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
                        },payNowText)
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
                           // Show a message when text is copied successfully
                           ScaffoldMessenger.of(context).showSnackBar(
                             const SnackBar(content: Text('Text copied to clipboard!')),
                           );
                         });
                       },
                       icon: Icon( Icons.copy_all,size: 18),
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
                Text(savingData.pAccountstatus??"",style: AppStyles.customTextStyle(color: AppStyles.colorOrange)),
                Image.asset("assets/images/bank2.png",height: 40,color: Colors.white,),
              ],
            ),
          ],
        ),
      ),
    );
  }


}
