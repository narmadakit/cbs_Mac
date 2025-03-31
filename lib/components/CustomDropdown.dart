import 'dart:developer';

import 'package:finsta_mac/utils/AppStyles.dart';
import 'package:flutter/material.dart';

import 'KeyValueModel.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String? selectedValue;
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(selectedValue!,style: AppStyles.boldTextBlack,),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, ValueChanged onChanged,List<KeyValueModel> items) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CustomDropdownBottomSheet(
          onItemSelected: onChanged, items: items,
        );
      },
    );
  }
}

class CustomDropdownBottomSheet extends StatelessWidget {
  final Function(String) onItemSelected;
  final List<KeyValueModel> items;

  const CustomDropdownBottomSheet({super.key, required this.items, required this.onItemSelected});

  @override
  Widget build(BuildContext context,) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].name),
            onTap: () {
              onItemSelected(items[index].name);
            },
          );
        },
      ),
    );
  }
}



