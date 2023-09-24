import 'package:ecommerce/app_colors.dart';
import 'package:ecommerce/utils.dart';
import 'package:flutter/material.dart';

class FilterModal extends StatelessWidget {
  const FilterModal({super.key, required this.onTap, required this.selected});

  final Function(FilterMode filterMode) onTap;
  final FilterMode selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            const Text(
              "Escolha o tipo de ordenacao:",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.center,
              child: Wrap(
                runSpacing: 24,
                spacing: 24,
                runAlignment: WrapAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  _filterIcon(FilterMode.none, context),
                  _filterIcon(FilterMode.priceDesc, context),
                  _filterIcon(FilterMode.priceAsc, context),
                  _filterIcon(FilterMode.nameDesc, context),
                  _filterIcon(FilterMode.nameAsc, context),
                  _filterIcon(FilterMode.bestDiscount, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterIcon(FilterMode filterMode, BuildContext context) {
    return Opacity(
      opacity: filterMode == selected ? 1 : 0.5,
      child: SizedBox(
        width: 120,
        child: Column(
          children: [
            IconButton.filledTonal(
              onPressed: () {
                onTap(filterMode);
                Navigator.pop(context);
              },
              iconSize: 30,
              color: AppColors.primaryColor,
              icon: Icon(
                Utils.filterIcon(filterMode: filterMode),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              Utils.filterName(filterMode: filterMode),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
