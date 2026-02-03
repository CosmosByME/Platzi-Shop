import 'package:flutter/material.dart';
import 'package:myapp/models/category.dart';
import 'package:myapp/network/apis.dart';
import 'package:myapp/network/network.dart';

class CatalogProvider extends ChangeNotifier {
  final List<Category> _items = [];
  List<Category> get category => _items;
  bool loading = false;

  Future<void> fetchAll() async {
    loading = true;

    final data = await Network.request(api: Apis.categories);
    if (data != null) {
      _items.addAll(Network.parseCategories(data));
    }

    loading = false;
    notifyListeners();
  }
}
