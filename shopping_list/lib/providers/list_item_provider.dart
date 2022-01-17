import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/shopping_item_provider.dart';

class ListItem with ChangeNotifier {
  List<ShoppingItem> products = [];
  List<String> jsonList = [];

// Clearing list function
  void clearList() {
    products.clear();
    jsonList.clear();
    prefsClear();
    notifyListeners();
  }

// Clearing storage function
  Future<void> prefsClear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

// Products encoding to json function
  void productsToJsonList(List<ShoppingItem> _products) {
    jsonList.clear();
    _products.forEach(
      (element) {
        var shoppingItemToJson = element.toJson();
        var stringShoppingItem = jsonEncode(shoppingItemToJson);
        jsonList.add(stringShoppingItem);
      },
    );
    notifyListeners();
  }

// Saving json list to storage function
  Future<void> jsonSave() async {
    final prefs = await SharedPreferences.getInstance();
    var jsonString = jsonList.toString();
    prefs.setString('jsonList', jsonString);
    print(jsonString);
    notifyListeners();
  }

// Adding new product to UI and Storage function
  Future<void> addProduct(ShoppingItem _data) async {
    var _newProduct = ShoppingItem(
      name: _data.name,
      quantity: _data.quantity,
      unit: _data.unit,
    );
    products.insert(0, _newProduct);
    productsToJsonList(products);
    jsonSave();
    notifyListeners();
  }

// Import list from storage function
  Future<List<ShoppingItem>> getList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var jL = prefs.getString('jsonList') as String;
    final List<dynamic> data = jsonDecode(jL);
    products = data.map((data) => ShoppingItem.fromJson(data)).toList();
    notifyListeners();
    return products;
  }
}
