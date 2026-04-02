import 'package:dokan/core/localization/app_localization.dart';
import 'package:flutter/material.dart';

class SizeDropdown extends StatefulWidget {
  const SizeDropdown({super.key});

  @override
  State<SizeDropdown> createState() => _SizeDropdownState();
}

class _SizeDropdownState extends State<SizeDropdown> {
  String? selectedSize;

  final List<String> sizes = ['S', 'M', 'L', 'XL'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        initialValue: selectedSize,
        hint:  Text(AppLocalizations.of(context).translate('select_size')),
        items: sizes.map((size) {
          return DropdownMenuItem(
            value: size,
            child: Text(size),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedSize = value;
          });
        },
      ),
    );
  }
}