import 'package:detoxa/dataModels/gender.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RoundedDropDown<T> extends StatelessWidget {
  final List items;
  final T selectedValue;
  final Function(T) onChanged;
  final Color color;
  const RoundedDropDown({
    Key key,
    this.items,
    this.onChanged,
    this.selectedValue,
    this.color,
  }) : super(key: key);

  String getText(var data) {
    if (data is Gender) {
      if (data == Gender.female) {
        return "Female";
      }
      return "Male";
    }
    if (data is String) {
      return data;
    }
    return data.toString();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        height: 45,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: color ?? (items == null ? Colors.grey : Colors.black),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButton<T>(
          isExpanded: true,
          menuMaxHeight: 200,
          value: selectedValue,
          items: items == null
              ? null
              : [
                  ...items.map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(getText(e)),
                      ),
                    ),
                  ),
                ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
