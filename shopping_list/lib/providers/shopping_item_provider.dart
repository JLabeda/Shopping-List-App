import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShoppingItem with ChangeNotifier {
  String name;
  String quantity;
  bool isPurchased;
  String unit;

  ShoppingItem({
    @required this.name = '',
    this.quantity = '',
    this.unit = '',
    this.isPurchased = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'isPurchased': isPurchased,
      'unit': unit,
    };
  }

  factory ShoppingItem.fromJson(Map<String, dynamic> json) {
    return ShoppingItem(
        name: json['name'],
        quantity: json['quantity'],
        isPurchased: json['isPurchased'],
        unit: json['unit']);
  }
}
