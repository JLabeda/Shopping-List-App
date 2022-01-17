import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/screens/add_item_screen.dart';

import './providers/list_item_provider.dart';

import './screens/shopping_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ListItem(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            textTheme:
                GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme)),
        home: ShoppingListScreen(),
        routes: {
          AddItemScreen.routeName: (ctx) => AddItemScreen(),
          ShoppingListScreen.routeName: (ctx) => ShoppingListScreen(),
        },
      ),
    );
  }
}
