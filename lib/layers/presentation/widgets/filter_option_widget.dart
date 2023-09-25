import 'package:diletta_store/core/enums/filter_enum.dart';
import 'package:flutter/material.dart';

class FilterOptionWidget extends StatelessWidget {
  final Function filterFunction;
  final bool isActive;
  final String filterText;
  final FilterOption? filterArgument;

  const FilterOptionWidget({
    Key? key,
    required this.filterFunction,
    required this.filterText,
    required this.isActive,
    required this.filterArgument
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (filterArgument != null) {
          filterFunction(filterArgument);
        } else {
          filterFunction();
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? Colors.red : Colors.grey,
            width: isActive ? 2 : 1,
          ),
        ),
        child: Text(
          filterText,
          textScaleFactor: 1,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w500 : null,
            color: isActive ? Colors.red : Colors.grey,
          ),
        ),
      ),
    );
  }
}
