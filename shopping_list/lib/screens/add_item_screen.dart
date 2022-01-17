import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/shopping_item_provider.dart';
import '../providers/list_item_provider.dart';

class AddItemScreen extends StatelessWidget {
  static const routeName = '/add-item';

  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController();
    final _quantityController = TextEditingController();
    final _unitController = TextEditingController();

    var _editedShoppingItem = ShoppingItem(name: '', quantity: '', unit: '');

    final productData = Provider.of<ListItem>(context, listen: false);

    void assignText() {
      _editedShoppingItem.name = _nameController.text;
      _editedShoppingItem.quantity = _quantityController.text;
      _editedShoppingItem.unit = _unitController.text;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add product'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        height: 250,
        child: Card(
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Card(
                  elevation: 4,
                  child: TextField(
                    controller: _nameController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(hintText: "Product name"),
                  ),
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Card(
                          elevation: 4,
                          child: SizedBox(
                            width: 150,
                            child: TextField(
                              controller: _quantityController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(hintText: "Amount"),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Card(
                          elevation: 4,
                          child: SizedBox(
                            width: 150,
                            child: TextField(
                              controller: _unitController,
                              textAlign: TextAlign.center,
                              decoration:
                                  const InputDecoration(hintText: "Unit"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 5, bottom: 5, right: 10),
                      height: 124,
                      child: ElevatedButton(
                        onPressed: () {
                          assignText();
                          productData.addProduct(_editedShoppingItem);
                          //_editedShoppingItem.toJson();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Add'),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
