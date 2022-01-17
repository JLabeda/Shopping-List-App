import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/list_item_provider.dart';

import '../screens/add_item_screen.dart';

import '../widgets/list_bar.dart';

class ShoppingListScreen extends StatefulWidget {
  static const routeName = '/shopping-list';

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  @override
  void initState() {
    Provider.of<ListItem>(context, listen: false).getList();
    super.initState();
  }

  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ListItem>(context);
    final products = productData.products;
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    void _bottomNavTap(int index) {
      setState(() {
        _currentTab = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: _currentTab == 0
            ? const Text('Shopping List')
            : const Text('Comming Soon!'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ListItem>(context, listen: false).clearList();
            },
            icon: const Icon(Icons.delete_forever_rounded),
          )
        ],
      ),
      body: (products.isEmpty && _currentTab == 0)
          ? const Center(
              child: Text('Enter Your first list item!'),
            )
          : _currentTab == 0
              ? ListView.builder(
                  itemBuilder: (ctx, i) => Dismissible(
                    onDismissed: (DismissDirection direction) {
                      setState(
                        () {
                          products.removeAt(i);
                          Provider.of<ListItem>(context, listen: false)
                              .productsToJsonList(products);
                          Provider.of<ListItem>(context, listen: false)
                              .jsonSave();
                        },
                      );
                    },
                    key: ValueKey(products[i]),
                    child: ListBar(
                      products[i].name,
                      products[i].quantity,
                      products[i].unit,
                      products[i].isPurchased,
                    ),
                  ),
                  itemCount: products.length,
                  padding: EdgeInsets.symmetric(
                    vertical: deviceHeight * 0.05,
                    horizontal: deviceWidth * 0.05,
                  ),
                )
              : ListView(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Multiple lists',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(),
                    Text(
                      'Share Lists with others',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Current List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.announcement_outlined),
            label: 'Comming soon',
          )
        ],
        currentIndex: _currentTab,
        onTap: _bottomNavTap,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          Navigator.of(context).pushNamed(AddItemScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
