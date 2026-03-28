import 'package:flutter/material.dart';

import '../../core/localization/app_localization.dart';

class ColorDropdown extends StatefulWidget {
  const ColorDropdown({super.key});

  @override
  State<ColorDropdown> createState() => _ColorDropdownState();
}

class _ColorDropdownState extends State<ColorDropdown> {
  String? selectedColor;


  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final List<String> colors = [
      locale.translate('black'),
      locale.translate('blue'),
      locale.translate('white'),
      locale.translate('red')
    ];

    return Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: DropdownButtonFormField<String>(
        initialValue: selectedColor,
        hint:  Text(locale.translate('select_color')),
        items: colors.map((size) {
          return DropdownMenuItem(
            value: size,
            child: Text(size),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedColor = value;
          });
        },
      ),
    );
  }
}