import 'package:flutter/material.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/network/apis.dart';
import 'package:myapp/network/network.dart';

class HomeProvider with ChangeNotifier {
  static const _limit = 10;
  int _offset = 0;
  bool _stopPagination = false;
  bool loading = false;
  bool loadingSearch = false;

  List<Product> _items = [];
  List<Product> _searchList = [];
  List<Product> get items => _items;
  List<Product> get searchList => _searchList;

  void clearSearchList() {
    _searchList = [];
  }

  void fetchProducts() async {
    if (loading || _stopPagination) return;

    final data = await Network.request(
      api: Apis.products,
      queryParams: Apis.paginationProduct(_offset, _limit),
    );

    if (data == null) {
      _stopPagination = true;
      loading = false;
      notifyListeners();
      return;
    }

    final products = Network.parseProducts(data);
    _items.addAll(products);

    _offset += _limit;
    if (products.length < _offset) {
      _stopPagination = true;
    }
    loading = false;
    notifyListeners();
  }

  Future<void> onRefresh() async {
    loading = true;
    notifyListeners();

    final data = await Network.request(
      api: Apis.products,
      queryParams: Apis.paginationProduct(0, _limit),
    );

    if (data == null) {
      loading = false;
      notifyListeners();
      return;
    }

    final products = Network.parseProducts(data);
    _items = products;
    _offset = _limit;
    loading = false;
    notifyListeners();
  }

  Future<void> search(String text) async {
    loadingSearch = true;
    notifyListeners();

    final data = await Network.request(
      api: Apis.products,
      queryParams: Apis.searchProduct(text),
    );

    if (data == null) {
      loadingSearch = false;
      notifyListeners();
      return;
    }

    final products = Network.parseProducts(data);
    _searchList = products;
    loadingSearch = false;
    notifyListeners();
  }
}
