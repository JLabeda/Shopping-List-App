import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/shopping_item_provider.dart';
import '../providers/list_item_provider.dart';

class ListBar extends StatefulWidget {
  @required
  final String name;
  final String quantity;
  final String unit;
  bool isPurchased;

  ListBar(
    this.name,
    this.quantity,
    this.unit,
    this.isPurchased,
  );

  @override
  State<ListBar> createState() => _ListBarState();
}

class _ListBarState extends State<ListBar> {
  List<ShoppingItem> swapItem(List<ShoppingItem> _products) {
    var thisItem = _products.firstWhere((element) =>
        element.name == widget.name &&
        element.quantity == widget.quantity &&
        element.unit == widget.unit &&
        element.isPurchased == !widget.isPurchased);
    var itemIndex = _products.indexWhere((element) => element == thisItem);
    _products.remove(thisItem);
    thisItem.isPurchased = widget.isPurchased;
    _products.insert(itemIndex, thisItem);
    return _products;
  }

  @override
  Widget build(BuildContext context) {
    List<ShoppingItem> _products =
        Provider.of<ListItem>(context, listen: false).products;

    return Card(
      elevation: 5,
      child: CheckboxListTile(
        tileColor: !widget.isPurchased ? null : Colors.black12,
        selectedTileColor: Colors.black26,
        value: widget.isPurchased,
        onChanged: (_) {
          setState(() {
            widget.isPurchased = !widget.isPurchased;
          });
          swapItem(_products);
          Provider.of<ListItem>(context, listen: false)
              .productsToJsonList(_products);
          Provider.of<ListItem>(context, listen: false).jsonSave();
        },
        title: Text(
          widget.name,
          style: const TextStyle(fontSize: 23),
        ),
        secondary: Text(
          widget.quantity + ' ' + widget.unit,
          style: const TextStyle(fontSize: 15),
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
