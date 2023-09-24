import 'package:flutter/material.dart';

enum PageState { idle, loading, error, success }

enum PageViewMode { grid, list }

enum ListMode { home, wishlist, cart }

enum FilterMode { none, priceAsc, priceDesc, nameAsc, nameDesc, bestDiscount }

class Utils {
  static String baseUrl() {
    return 'https://www.integralmedica.com.br/api/catalog_system/pub/products/search';
  }

  static String? emptyValidator(String? text) {
    if (text == null || text.isEmpty) return 'Campo não pode ser vazio.';
    return null;
  }

  static void showModal({required BuildContext context, required Widget widget}) {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      builder: (BuildContext context) {
        return widget;
      },
    );
  }

  static String filterName({required FilterMode filterMode}) {
    final data = {
      FilterMode.none: 'Sem ordenacao',
      FilterMode.priceAsc: 'Preco crescente',
      FilterMode.priceDesc: 'Preco decrescente',
      FilterMode.nameAsc: 'Nome crescente',
      FilterMode.nameDesc: 'Nome decrescente',
      FilterMode.bestDiscount: 'Melhor desconto',
    };

    return data[filterMode] ?? '';
  }

  static IconData filterIcon({required FilterMode filterMode}) {
    final data = {
      FilterMode.none: Icons.close,
      FilterMode.priceAsc: Icons.attach_money,
      FilterMode.priceDesc: Icons.attach_money,
      FilterMode.nameAsc: Icons.text_fields,
      FilterMode.nameDesc: Icons.text_fields,
      FilterMode.bestDiscount: Icons.discount,
    };

    return data[filterMode] ?? Icons.close;
  }
}
