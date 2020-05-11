import 'package:flutter/foundation.dart';

import 'CatalogModel.dart';

class CartModel extends ChangeNotifier {
  CatalogModel _catalog;
  final List<int> _itemIds = [];
  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    assert(newCatalog != null);
    assert(_itemIds.every((id) => newCatalog.getById(id) != null),
        'The catalog $newCatalog does not have one of $_itemIds in it.');
    _catalog = newCatalog;
    notifyListeners();
  }

  List<Item> get items => _itemIds.map((id) => _catalog.getById(id)).toList();
  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  void add(Item item) {
    _itemIds.add(item.id);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }
}
