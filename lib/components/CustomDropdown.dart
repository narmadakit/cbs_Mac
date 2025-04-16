import 'dart:developer';

import 'package:finsta_mac/utils/AppStyles.dart';
import 'package:flutter/material.dart';

import 'KeyValueModel.dart';

class CustomDropdown<T> extends StatelessWidget {
  final KeyValueModel selectedValue;
  final BuildContext context;
  final List<KeyValueModel> items;
  final ValueChanged onChanged;
  final String hint;
  final IconData? icon;
  final String? labelText;
  final TextStyle? textStyle;
  final Color borderColor;

  const CustomDropdown({
    super.key,
    required this.context,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.hint,
    this.icon,
    this.labelText,
    this.textStyle = const TextStyle(fontSize: 16),
    this.borderColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBottomSheet(context,onChanged,items), // Open BottomSheet when tapped
      child: Container(
        padding: const EdgeInsets.only(left: 6, bottom: 12,top: 12),
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(selectedValue.name,style: AppStyles.boldTextBlack,overflow: TextOverflow.ellipsis,)),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, ValueChanged onChanged,List<KeyValueModel> items) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return CustomDropdownBottomSheet(
          onItemSelected: onChanged, items: items,
        );
      },
    );
  }
}

class CustomDropdownBottomSheet extends StatelessWidget {
  final Function(KeyValueModel) onItemSelected;
  final List<KeyValueModel> items;

  const CustomDropdownBottomSheet({super.key, required this.items, required this.onItemSelected});

  @override
  Widget build(BuildContext context,) {
    return  (items.isEmpty)?SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
        child: Center(child: Text("No Data",style:AppStyles.headerTextBlack))):
      Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return
            Column(
              children: [
                ListTile(
                title: Text(items[index].name),
                onTap: () {
                  onItemSelected(items[index]);
                },
                ),
                Divider(color: Colors.grey.shade300)
              ],
            );
        },
      ),
    );
  }
}



