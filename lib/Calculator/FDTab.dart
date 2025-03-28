import 'package:finsta_mac/Calculator/bloc/FdBloc/FDBloc.dart';
import 'package:finsta_mac/Calculator/bloc/FdBloc/FDState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/CustomDropdown.dart';
import '../network/Repository.dart';
import '../utils/AppStyles.dart';
import 'bloc/FdBloc/FDEvent.dart';

class FDTab extends StatefulWidget {
  const FDTab({super.key});

  @override
  State<FDTab> createState() => _FDTabState();
}

class _FDTabState extends State<FDTab> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FDBloc>(create: (context) => FDBloc(Repository())..add(FDInitEvent("FIXED DEPOSIT"),))
      ],
      child: BlocConsumer<FDBloc,FDStates>(
          builder: (context, state) {
           // if(state is FDGetTransactionSuccessState){
             return Container(
               child: const Column(
                 children: [
                   Text('FD Name'),
                   Row(
                     mainAxisAlignment:
                     MainAxisAlignment.spaceAround,
                     children: [
                       Text('FD NAme'),
                       // CustomDropdown(context: context,selectedValue: _selectedValue,
                       //   onChanged: (value) {
                       //     _selectedValue = value;
                       //     context.read<FDBloc>().add(FDInitEvent(_selectedValue));
                       //     setState(() {
                       //     });
                       //     Navigator.pop(context);
                       //   },
                       //   hint: "",items:depositType,icon: Icons.arrow_downward,labelText: '', )
                     ],
                   ),
                 ],
               ),
             );
           // }
           //   return Center(child: CircularProgressIndicator(color: AppStyles.btnColor,));

          },
          listener: (context, state) {

          },)
    );
  }
}
